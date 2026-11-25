////////////////////////////////////////////////////////////////////////
// Crystal Server - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////

#include "creatures/players/daily_reward/daily_reward.hpp"

#include "config/configmanager.hpp"
#include "creatures/players/player.hpp"
#include "creatures/players/vocations/vocation.hpp"
#include "database/database.hpp"
#include "game/game.hpp"
#include "game/scheduling/dispatcher.hpp"
#include "items/containers/container.hpp"
#include "items/item.hpp"
#include "kv/value_wrapper.hpp"
#include "lib/di/container.hpp"
#include "server/network/message/networkmessage.hpp"
#include "utils/tools.hpp"

#include <algorithm>
#include <array>
#include <ctime>
#include <limits>
#include <optional>
#include <string_view>
#include <unordered_map>

namespace {
	struct RewardTypeMapping {
		std::string_view name;
		DailyRewardType_t type;
	};

	constexpr std::array<RewardTypeMapping, 6> REWARD_TYPE_TABLE { {
		{ "item", DAILY_REWARD_TYPE_ITEM },
		{ "storage", DAILY_REWARD_TYPE_STORAGE },
		{ "preyReroll", DAILY_REWARD_TYPE_PREY_REROLL },
		{ "xpBoost", DAILY_REWARD_TYPE_XP_BOOST },
		{ "cosmeticTokens", DAILY_REWARD_TYPE_COSMETIC_TOKENS },
		{ "bountyRerollTokens", DAILY_REWARD_TYPE_BOUNTY_REROLL_TOKENS },
	} };

	std::optional<DailyRewardType_t> parseRewardType(const std::string &value) {
		const auto it = std::ranges::find(REWARD_TYPE_TABLE, value, &RewardTypeMapping::name);
		if (it == REWARD_TYPE_TABLE.end()) {
			return std::nullopt;
		}
		return it->type;
	}

	// Premium rewards and resting area bonuses also count for VIP accounts
	bool hasDailyRewardPremium(const std::shared_ptr<Player> &player) {
		return (g_configManager().getBoolean(VIP_SYSTEM_ENABLED) && player->isVip()) || player->isPremium();
	}

	// Counts of a reward object are one byte on the wire
	uint8_t toDailyRewardCount(uint32_t amount) {
		return static_cast<uint8_t>(std::min<uint32_t>(amount, std::numeric_limits<uint8_t>::max()));
	}

	// storage field parsing
	struct StorageFieldMapping {
		std::string_view name;
		uint32_t DailyRewardStorages::*member;
	};

	constexpr std::array<StorageFieldMapping, 9> STORAGE_FIELD_TABLE { {
		{ "currentDayStreak", &DailyRewardStorages::currentDayStreak },
		{ "nextRewardTime", &DailyRewardStorages::nextRewardTime },
		{ "collectionTokens", &DailyRewardStorages::collectionTokens },
		{ "staminaBonus", &DailyRewardStorages::staminaBonus },
		{ "jokerTokens", &DailyRewardStorages::jokerTokens },
		{ "lastServerSave", &DailyRewardStorages::lastServerSave },
		{ "avoidDouble", &DailyRewardStorages::avoidDouble },
		{ "notifyReset", &DailyRewardStorages::notifyReset },
		{ "avoidDoubleJoker", &DailyRewardStorages::avoidDoubleJoker },
	} };

	uint16_t resolveItemId(const pugi::xml_node &itemNode) {
		if (const auto idAttr = itemNode.attribute("id")) {
			return static_cast<uint16_t>(idAttr.as_uint());
		}

		const std::string name = itemNode.attribute("name").as_string();
		if (name.empty()) {
			g_logger().error("[DailyRewards::loadFromXml] <item> node is missing both 'id' and 'name' attributes, skipping.");
			return 0;
		}

		const uint16_t itemId = Item::items.getItemIdByName(name);
		if (itemId == 0) {
			g_logger().error("[DailyRewards::loadFromXml] Unknown item name '{}', skipping.", name);
		}
		return itemId;
	}
} // namespace

DailyRewards &DailyRewards::getInstance() {
	return inject<DailyRewards>();
}

bool DailyRewards::loadFromXml(bool /*reloading*/) {
	pugi::xml_document doc;
	const auto folder = g_configManager().getString(CORE_DIRECTORY) + "/XML/dailyrewards.xml";
	const pugi::xml_parse_result result = doc.load_file(folder.c_str());
	if (!result) {
		printXMLError(__FUNCTION__, folder, result);
		return false;
	}

	const auto root = doc.child("dailyrewards");
	if (!root) {
		g_logger().error("[DailyRewards::loadFromXml] Missing dailyrewards root node");
		return false;
	}

	testMode = root.attribute("testMode").as_bool(false);
	serverTimeThreshold = root.attribute("serverTimeThreshold").as_uint(86400);
	rerollTokensPerClaim = toDailyRewardCount(root.attribute("rerollTokensPerClaim").as_uint(1));

	storages = DailyRewardStorages {};
	strikeBonuses.clear();
	rewards.clear();
	shrineItems.clear();

	// storages
	{
		std::unordered_set<std::string> seenNames;
		std::unordered_map<uint32_t, std::string> seenKeys;

		for (const auto &storageNode : root.child("storages").children("storage")) {
			const std::string name = storageNode.attribute("name").as_string();
			const uint32_t key = storageNode.attribute("key").as_uint();

			if (name.empty()) {
				g_logger().error("[DailyRewards::loadFromXml] <storage> node is missing the 'name' attribute, skipping.");
				continue;
			}
			if (key == 0) {
				g_logger().error("[DailyRewards::loadFromXml] Storage '{}' has an invalid key=0, skipping.", name);
				continue;
			}
			if (!seenNames.insert(name).second) {
				g_logger().error("[DailyRewards::loadFromXml] Duplicate storage name '{}', ignoring duplicate entry.", name);
				continue;
			}
			if (const auto [it, inserted] = seenKeys.try_emplace(key, name); !inserted) {
				g_logger().error(
					"[DailyRewards::loadFromXml] Storage '{}' reuses key {} already used by '{}', skipping.",
					name, key, it->second
				);
				continue;
			}

			const auto fieldIt = std::ranges::find(STORAGE_FIELD_TABLE, name, &StorageFieldMapping::name);
			if (fieldIt == STORAGE_FIELD_TABLE.end()) {
				g_logger().warn("[DailyRewards::loadFromXml] Unknown storage name '{}', ignoring.", name);
				continue;
			}
			storages.*(fieldIt->member) = key;
		}
	}

	// strikeBonuses
	for (const auto &bonusNode : root.child("strikeBonuses").children("bonus")) {
		const uint8_t day = static_cast<uint8_t>(bonusNode.attribute("day").as_uint());
		if (day == 0 || day > REWARD_COUNT) {
			g_logger().error("[DailyRewards::loadFromXml] Strike bonus day '{}' is out of range (1-{}), skipping.", day, REWARD_COUNT);
			continue;
		}
		if (strikeBonuses.contains(day)) {
			g_logger().error("[DailyRewards::loadFromXml] Duplicate strike bonus for day '{}', ignoring duplicate entry.", day);
			continue;
		}

		DailyRewardStrikeBonus bonus;
		bonus.day = day;
		bonus.text = bonusNode.attribute("text").as_string();
		strikeBonuses.emplace(day, std::move(bonus));
	}

	// The <itemGroups> and <vocationItems> nodes of older files are ignored: since the Winter Update 2026
	// the claim is one click and every day has a fixed reward.

	// rewards
	for (const auto &rewardNode : root.child("rewards").children("reward")) {
		const uint8_t day = static_cast<uint8_t>(rewardNode.attribute("day").as_uint());
		if (day == 0 || day > REWARD_COUNT) {
			g_logger().error("[DailyRewards::loadFromXml] Reward day '{}' is out of range (1-{}), skipping.", day, REWARD_COUNT);
			continue;
		}
		if (rewards.contains(day)) {
			g_logger().error("[DailyRewards::loadFromXml] Duplicate reward for day '{}', ignoring duplicate entry.", day);
			continue;
		}

		const std::string typeValue = rewardNode.attribute("type").as_string("item");
		const auto parsedType = parseRewardType(typeValue);
		if (!parsedType) {
			g_logger().error("[DailyRewards::loadFromXml] Reward day '{}' has unknown type '{}', skipping.", day, typeValue);
			continue;
		}

		DailyRewardDayConfig reward;
		reward.day = day;
		reward.type = *parsedType;
		reward.freeAccount = static_cast<uint16_t>(rewardNode.attribute("freeAccount").as_uint());
		reward.premiumAccount = static_cast<uint16_t>(rewardNode.attribute("premiumAccount").as_uint());
		reward.freePercent = static_cast<uint16_t>(rewardNode.attribute("freePercent").as_uint(50));
		reward.premiumPercent = static_cast<uint16_t>(rewardNode.attribute("premiumPercent").as_uint(50));
		reward.itemCharges = static_cast<uint16_t>(rewardNode.attribute("itemCharges").as_uint());
		for (const auto &itemNode : rewardNode.children("item")) {
			if (const uint16_t itemId = resolveItemId(itemNode); itemId != 0) {
				reward.items.emplace_back(itemId);
			}
		}
		if (reward.type == DAILY_REWARD_TYPE_ITEM && reward.items.empty()) {
			g_logger().warn("[DailyRewards::loadFromXml] Reward day '{}' has type 'item' but no <item>: this day only gives the reroll tokens of every claim.", day);
		}
		rewards.emplace(day, std::move(reward));
	}

	// shrines
	for (const auto &shrineNode : root.child("shrines").children("item")) {
		if (const uint16_t itemId = resolveItemId(shrineNode); itemId != 0) {
			shrineItems.insert(itemId);
		}
	}

	loaded = true;
	return true;
}

bool DailyRewards::isShrineItem(uint16_t itemId) const {
	return shrineItems.contains(itemId);
}

std::vector<DailyRewardEntry> DailyRewards::getRewardEntries(uint8_t day, bool premium) const {
	std::vector<DailyRewardEntry> entries;

	if (const auto rewardIt = rewards.find(day); rewardIt != rewards.end()) {
		const auto &dailyTable = rewardIt->second;
		const uint16_t amount = premium ? dailyTable.premiumAccount : dailyTable.freeAccount;

		switch (dailyTable.type) {
			case DAILY_REWARD_TYPE_ITEM: {
				for (const uint16_t itemId : dailyTable.items) {
					if (amount == 0) {
						break;
					}
					const ItemType &itemType = Item::items[itemId];
					DailyRewardEntry entry;
					entry.kind = DAILY_REWARD_KIND_ITEM;
					entry.itemId = itemId;
					entry.itemCharges = dailyTable.itemCharges;
					entry.name = itemType.article.empty() ? itemType.name : fmt::format("{} {}", itemType.article, itemType.name);
					entry.count = toDailyRewardCount(amount);
					entries.emplace_back(std::move(entry));
				}
				break;
			}
			case DAILY_REWARD_TYPE_PREY_REROLL: {
				if (amount > 0) {
					DailyRewardEntry entry;
					entry.kind = DAILY_REWARD_KIND_PREY_WILDCARDS;
					entry.count = toDailyRewardCount(amount);
					entries.emplace_back(std::move(entry));
				}
				break;
			}
			case DAILY_REWARD_TYPE_XP_BOOST: {
				const uint16_t percent = premium ? dailyTable.premiumPercent : dailyTable.freePercent;
				if (amount > 0 && percent > 0) {
					DailyRewardEntry entry;
					entry.kind = DAILY_REWARD_KIND_XP_BOOST;
					entry.minutes = amount;
					entry.percent = percent;
					entries.emplace_back(std::move(entry));
				}
				break;
			}
			case DAILY_REWARD_TYPE_COSMETIC_TOKENS: {
				if (amount > 0) {
					DailyRewardEntry entry;
					entry.kind = DAILY_REWARD_KIND_COSMETIC_TOKENS;
					entry.count = toDailyRewardCount(amount);
					entries.emplace_back(std::move(entry));
				}
				break;
			}
			case DAILY_REWARD_TYPE_BOUNTY_REROLL_TOKENS: {
				if (amount > 0) {
					DailyRewardEntry entry;
					entry.kind = DAILY_REWARD_KIND_BOUNTY_REROLL_TOKENS;
					entry.count = toDailyRewardCount(amount);
					entries.emplace_back(std::move(entry));
				}
				break;
			}
			default:
				break;
		}
	}

	// Every claim also gives Bounty Reroll Tokens
	if (rerollTokensPerClaim > 0) {
		DailyRewardEntry entry;
		entry.kind = DAILY_REWARD_KIND_BOUNTY_REROLL_TOKENS;
		entry.count = rerollTokensPerClaim;
		entries.emplace_back(std::move(entry));
	}

	return entries;
}

uint8_t DailyRewards::getStreakBonusChance(const std::shared_ptr<Player> &player) const {
	if (!player) {
		return 0;
	}

	return static_cast<uint8_t>(std::min<uint32_t>(getStreakLevel(player), MAX_STREAK_BONUS_CHANCE));
}

uint32_t DailyRewards::getCollectionTokens(const std::shared_ptr<Player> &player) const {
	return std::max<int32_t>(0, player->getStorageValue(storages.collectionTokens));
}

void DailyRewards::setCollectionTokens(const std::shared_ptr<Player> &player, int32_t value) const {
	player->addStorageValue(storages.collectionTokens, value);
}

uint32_t DailyRewards::getJokerTokens(const std::shared_ptr<Player> &player) const {
	return std::max<int32_t>(0, player->getStorageValue(storages.jokerTokens));
}

void DailyRewards::setJokerTokens(const std::shared_ptr<Player> &player, int32_t value) const {
	player->addStorageValue(storages.jokerTokens, value);
}

uint8_t DailyRewards::getDayStreak(const std::shared_ptr<Player> &player) const {
	return static_cast<uint8_t>(std::max<int32_t>(0, player->getStorageValue(storages.currentDayStreak)));
}

void DailyRewards::setDayStreak(const std::shared_ptr<Player> &player, int32_t value) const {
	player->addStorageValue(storages.currentDayStreak, value);
}

uint32_t DailyRewards::getNextRewardTime(const std::shared_ptr<Player> &player) const {
	static constexpr uint32_t MIN_VALID_TIMESTAMP = 1400000000; // ignore corrupted quest storages (e.g. 14899 = 1)
	const int32_t storage = player->getStorageValue(storages.nextRewardTime);
	if (storage <= 0) {
		return 0;
	}
	const auto value = static_cast<uint32_t>(storage);
	if (value < MIN_VALID_TIMESTAMP) {
		return 0;
	}
	return value;
}

void DailyRewards::setNextRewardTime(const std::shared_ptr<Player> &player, int32_t value) const {
	player->addStorageValue(storages.nextRewardTime, value);
}

uint32_t DailyRewards::getStreakLevel(const std::shared_ptr<Player> &player) const {
	const auto streakKV = player->kv()->scoped("daily-reward")->get("streak");
	if (streakKV && streakKV.has_value()) {
		return static_cast<uint32_t>(streakKV->getNumber());
	}
	return 0;
}

void DailyRewards::setStreakLevel(const std::shared_ptr<Player> &player, uint32_t value) const {
	player->kv()->scoped("daily-reward")->set("streak", ValueWrapper(static_cast<int>(value)));
}

void DailyRewards::updateLastServerSave(time_t timestamp) const {
	cachedLastServerSave = timestamp;
	const auto query = fmt::format(
		"INSERT INTO `global_storage` (`key`, `value`) VALUES ({}, {}) ON DUPLICATE KEY UPDATE `value` = {}",
		storages.lastServerSave,
		timestamp,
		timestamp
	);
	g_database().executeQuery(query);
}

time_t DailyRewards::getLastServerSave() const {
	if (cachedLastServerSave > 0) {
		return cachedLastServerSave;
	}

	const auto query = fmt::format("SELECT `value` FROM `global_storage` WHERE `key` = {}", storages.lastServerSave);
	if (const auto &result = g_database().storeQuery(query)) {
		cachedLastServerSave = static_cast<time_t>(result->getNumber<int64_t>("value"));
		return cachedLastServerSave;
	}

	const time_t currentTime = std::time(nullptr);
	updateLastServerSave(currentTime);
	return currentTime;
}

bool DailyRewards::isRewardTaken(const std::shared_ptr<Player> &player) const {
	const uint32_t nextReward = getNextRewardTime(player);
	const time_t now = std::time(nullptr);

	if (nextReward > static_cast<uint32_t>(now)) {
		return true;
	}

	if (nextReward > 0 && now >= static_cast<time_t>(nextReward)) {
		return false;
	}

	if (player->getDailyReward() == DAILY_REWARD_COLLECTED) {
		return true;
	}

	const int32_t playerStorage = player->getStorageValue(storages.avoidDouble);
	const time_t lastSave = getLastServerSave();
	return playerStorage == static_cast<int32_t>(lastSave);
}

void DailyRewards::insertHistory(uint32_t playerGuid, uint8_t dayStreak, const std::string &description) const {
	const auto query = fmt::format(
		"INSERT INTO `daily_reward_history`(`player_id`, `daystreak`, `timestamp`, `description`) VALUES ({}, {}, {}, {})",
		playerGuid,
		dayStreak,
		std::time(nullptr),
		g_database().escapeString(description)
	);
	g_database().executeQuery(query);
}

void DailyRewards::scheduleStaminaRegen(uint32_t playerId, uint32_t delayMs) {
	if (const auto it = staminaEvents.find(playerId); it != staminaEvents.end()) {
		g_dispatcher().stopEvent(it->second);
		staminaEvents.erase(it);
	}

	const uint64_t eventId = g_dispatcher().scheduleEvent(
		delayMs,
		[playerId, delayMs]() {
			const auto &player = g_game().getPlayerByID(playerId);
			if (!player) {
				g_dailyRewards().stopPlayerBonuses(playerId);
				return;
			}

			g_dailyRewards().refreshStreak(player);
			// Resting area bonus of Premium accounts
			if (!hasDailyRewardPremium(player)) {
				g_dailyRewards().stopPlayerBonuses(playerId);
				return;
			}

			if (player->getZoneType() == ZONE_PROTECTION) {
				uint16_t stamina = player->getStaminaMinutes();
				uint32_t nextDelay = delayMs;
				if (stamina > 2340 && stamina < 2520) {
					nextDelay = 6 * 60 * 1000;
				}
				if (stamina < 2520) {
					player->addStaminaMinutes(1);
					player->sendTextMessage(MESSAGE_FAILURE, "One minute of stamina has been refilled.");
				}
				g_dailyRewards().scheduleStaminaRegen(playerId, nextDelay);
			} else {
				g_dailyRewards().scheduleStaminaRegen(playerId, delayMs);
			}
		},
		"DailyRewardStaminaRegen"
	);
	staminaEvents[playerId] = eventId;
}

void DailyRewards::scheduleSoulRegen(uint32_t playerId, uint32_t delayMs) {
	if (const auto it = soulEvents.find(playerId); it != soulEvents.end()) {
		g_dispatcher().stopEvent(it->second);
		soulEvents.erase(it);
	}

	const uint64_t eventId = g_dispatcher().scheduleEvent(
		delayMs,
		[playerId, delayMs]() {
			const auto &player = g_game().getPlayerByID(playerId);
			if (!player) {
				g_dailyRewards().stopPlayerBonuses(playerId);
				return;
			}

			g_dailyRewards().refreshStreak(player);
			// Resting area bonus of Premium accounts
			if (!hasDailyRewardPremium(player)) {
				g_dailyRewards().stopPlayerBonuses(playerId);
				return;
			}

			if (player->getZoneType() == ZONE_PROTECTION) {
				const uint8_t maxSoul = 200;
				if (player->getSoul() < maxSoul) {
					player->changeSoul(1);
					player->sendTextMessage(MESSAGE_FAILURE, "One soul point has been restored.");
				}
			}
			g_dailyRewards().scheduleSoulRegen(playerId, delayMs);
		},
		"DailyRewardSoulRegen"
	);
	soulEvents[playerId] = eventId;
}

void DailyRewards::stopPlayerBonuses(uint32_t playerId) {
	if (const auto it = staminaEvents.find(playerId); it != staminaEvents.end()) {
		g_dispatcher().stopEvent(it->second);
		staminaEvents.erase(it);
	}
	if (const auto it = soulEvents.find(playerId); it != soulEvents.end()) {
		g_dispatcher().stopEvent(it->second);
		soulEvents.erase(it);
	}
}

void DailyRewards::loadPlayerBonuses(const std::shared_ptr<Player> &player) {
	refreshStreak(player);
	// Winter Update 2026: the resting area bonuses no longer depend on the reward streak.
	// Premium: hit point, mana, stamina and soul regeneration, with doubled hit point and mana regeneration.
	// Free: hit point and mana regeneration (both handled in ConditionRegeneration::executeCondition).
	if (!hasDailyRewardPremium(player)) {
		stopPlayerBonuses(player->getID());
		return;
	}

	uint32_t staminaDelay = 3 * 60 * 1000;
	if (player->getStaminaMinutes() > 2340 && player->getStaminaMinutes() <= 2520) {
		staminaDelay = 6 * 60 * 1000;
	}
	scheduleStaminaRegen(player->getID(), staminaDelay);

	const uint32_t soulDelay = player->getVocation()->getSoulGainTicks();
	scheduleSoulRegen(player->getID(), soulDelay);
}

void DailyRewards::refreshStreak(const std::shared_ptr<Player> &player) const {
	const uint32_t nextReward = getNextRewardTime(player);
	if (nextReward == 0 || serverTimeThreshold == 0) {
		return;
	}

	const time_t now = std::time(nullptr);
	// The claim stays open for serverTimeThreshold seconds after nextReward.
	if (now < static_cast<time_t>(nextReward) + static_cast<time_t>(serverTimeThreshold)) {
		return;
	}

	if (player->getStorageValue(storages.notifyReset) == static_cast<int32_t>(nextReward)) {
		return; // the streak was already lost in this period
	}

	const auto missedDays = static_cast<uint32_t>((now - static_cast<time_t>(nextReward)) / serverTimeThreshold);
	const uint32_t jokers = getJokerTokens(player);
	if (jokers >= missedDays) {
		setJokerTokens(player, static_cast<int32_t>(jokers - missedDays));
		// The jokers stand in for the missed claims: move the open claim forward.
		setNextRewardTime(player, static_cast<int32_t>(nextReward + missedDays * serverTimeThreshold));
		player->sendTextMessage(MESSAGE_LOGIN, fmt::format("You used {} joker token(s) to keep your daily reward streak.", missedDays));
		return;
	}

	player->addStorageValue(storages.notifyReset, static_cast<int32_t>(nextReward));
	const bool hadStreak = getStreakLevel(player) > 0;
	setStreakLevel(player, 0);
	if (jokers > 0) {
		setJokerTokens(player, 0);
	}
	if (hadStreak) {
		player->sendTextMessage(MESSAGE_LOGIN, "You just lost your daily reward streak.");
	}
}

void DailyRewards::initPlayer(const std::shared_ptr<Player> &player) {
	const time_t now = std::time(nullptr);

	if (player->getDailyReward() == DAILY_REWARD_COLLECTED && getNextRewardTime(player) == 0) {
		setNextRewardTime(player, static_cast<int32_t>(now + serverTimeThreshold));
	}

	refreshStreak(player);

	if (isRewardTaken(player)) {
		player->sendDailyRewardCollectionState(DAILY_REWARD_COLLECTED);
		player->setDailyReward(DAILY_REWARD_COLLECTED);
	} else {
		player->sendDailyRewardCollectionState(DAILY_REWARD_NOTCOLLECTED);
		player->setDailyReward(DAILY_REWARD_NOTCOLLECTED);
	}

	if (getLastServerSave() >= player->getLastLoginSaved()) {
		player->setRemoveBossTime(1);
	}

	loadPlayerBonuses(player);
}

void DailyRewards::loadDailyReward(const std::shared_ptr<Player> &player, DailyRewardSource_t source) {
	if (!player) {
		return;
	}

	refreshStreak(player);

	const bool rewardTaken = isRewardTaken(player);
	// The flag is otherwise only updated at login and on a claim, so it can be stale for players
	// who stay online until the next reward is available.
	player->setDailyReward(rewardTaken ? DAILY_REWARD_COLLECTED : DAILY_REWARD_NOTCOLLECTED);
	uint32_t nextRewardTime = getNextRewardTime(player);
	if (rewardTaken && nextRewardTime == 0) {
		nextRewardTime = static_cast<uint32_t>(std::time(nullptr) + serverTimeThreshold);
	}

	const uint8_t shrineFlag = source == DAILY_REWARD_FROM_SHRINE ? 1 : 0;
	player->sendDailyRewardCollectionResource(0x15, getJokerTokens(player));
	player->sendDailyRewardCollectionResource(0x14, getCollectionTokens(player));
	// 15.33: the reward wall shows both token balances (nothing is sent to an older client)
	player->sendResourceBalance(RESOURCE_BOUNTY_REROLL_TOKENS, player->getRerollTasks());
	player->sendResourceBalance(RESOURCE_COSMETIC_TOKENS, player->getCosmeticTokens());
	player->sendDailyRewardBasic();
	player->sendOpenRewardWall(
		shrineFlag,
		getDayStreak(player),
		getJokerTokens(player),
		getStreakLevel(player),
		nextRewardTime,
		rewardTaken,
		testMode
	);
	player->sendDailyRewardCollectionState(rewardTaken ? DAILY_REWARD_COLLECTED : DAILY_REWARD_NOTCOLLECTED);
}

void DailyRewards::playerOpenRewardWall(const std::shared_ptr<Player> &player) {
	loadDailyReward(player, DAILY_REWARD_FROM_PANEL);
}

void DailyRewards::playerOpenRewardHistory(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}
	player->sendDailyRewardHistory(player->getGUID());
}

void DailyRewards::pickedReward(const std::shared_ptr<Player> &player) {
	if (getDayStreak(player) != 6) {
		setDayStreak(player, getDayStreak(player) + 1);
	} else {
		setDayStreak(player, 0);
	}

	setStreakLevel(player, getStreakLevel(player) + 1);
	player->addStorageValue(storages.avoidDouble, static_cast<int32_t>(getLastServerSave()));
	player->setDailyReward(DAILY_REWARD_COLLECTED);
	setNextRewardTime(player, static_cast<int32_t>(std::time(nullptr) + serverTimeThreshold));
	g_game().addMagicEffect(player->getPosition(), CONST_ME_FIREWORK_YELLOW);
}

void DailyRewards::processReward(const std::shared_ptr<Player> &player, DailyRewardSource_t source) {
	pickedReward(player);
	loadDailyReward(player, source);
	loadPlayerBonuses(player);
}

void DailyRewards::playerSelectReward(const std::shared_ptr<Player> &player, NetworkMessage &msg) {
	if (!player) {
		return;
	}

	// C2S 0xDA: u8 source (0 = reward shrine, otherwise instant access), u8 n, n x { u16 itemId, u8 count }.
	// Since the Winter Update 2026 the claim is one click: every day has a fixed reward, so the item
	// picks an older client may still send are not read.
	const uint8_t target = msg.getByte();
	const DailyRewardSource_t source = target == 0 ? DAILY_REWARD_FROM_SHRINE : DAILY_REWARD_FROM_PANEL;

	// The client keeps its claim pending until the reward wall (S2C 0xE2) arrives again,
	// so a refused claim is answered with the wall as well
	refreshStreak(player);

	if (isRewardTaken(player) && !testMode) {
		player->sendMessageDialog("You have already collected your daily reward.");
		loadDailyReward(player, source);
		return;
	}

	const bool premium = hasDailyRewardPremium(player);
	const uint8_t rewardDay = getDayStreak(player) + 1;
	const auto entries = getRewardEntries(rewardDay, premium);

	// Check everything that can fail before anything is taken or given
	uint32_t inboxSlots = 0;
	for (const auto &entry : entries) {
		if (entry.kind != DAILY_REWARD_KIND_ITEM) {
			continue;
		}
		inboxSlots += Item::items[entry.itemId].stackable ? 1 : entry.count;
	}

	const auto &inbox = player->getStoreInbox();
	if (inboxSlots > 0 && (!inbox || inbox->size() + inboxSlots > inbox->capacity())) {
		player->sendMessageDialog("You do not have enough space in your store inbox.");
		loadDailyReward(player, source);
		return;
	}

	if (target != 0) {
		if (getCollectionTokens(player) < 1) {
			player->sendMessageDialog("You do not have enough collection tokens to proceed.");
			loadDailyReward(player, source);
			return;
		}
		setCollectionTokens(player, static_cast<int32_t>(getCollectionTokens(player) - 1));
	}

	std::string description;
	const auto describe = [&description](const std::string &text) {
		if (!description.empty()) {
			description += ", ";
		}
		description += text;
	};

	for (const auto &entry : entries) {
		switch (entry.kind) {
			case DAILY_REWARD_KIND_ITEM: {
				const ItemType &itemType = Item::items[entry.itemId];
				// Stackable items are one stack, everything else is created one by one
				const uint8_t stacks = itemType.stackable ? 1 : entry.count;
				const uint16_t stackCount = itemType.stackable ? entry.count : 1;
				for (uint8_t stackIndex = 0; stackIndex < stacks; ++stackIndex) {
					const auto &inboxItem = Item::CreateItem(entry.itemId, stackCount);
					if (!inboxItem) {
						continue;
					}
					inboxItem->setAttribute(ItemAttribute_t::STORE, static_cast<int64_t>(std::time(nullptr)));
					if (entry.itemCharges > 0 && !itemType.stackable) {
						inboxItem->setAttribute(ItemAttribute_t::CHARGES, entry.itemCharges);
					}
					inbox->addItemBack(inboxItem);
				}
				describe(fmt::format("{}x {}", entry.count, itemType.name));
				break;
			}
			case DAILY_REWARD_KIND_PREY_WILDCARDS: {
				player->addPreyCards(entry.count);
				describe(fmt::format("{}x Prey Wildcard", entry.count));
				break;
			}
			case DAILY_REWARD_KIND_XP_BOOST: {
				// The daily reward XP boost is separate from the store XP boost (both are added while
				// active); a new daily boost replaces what is left of the old one
				const uint32_t seconds = std::min<uint32_t>(static_cast<uint32_t>(entry.minutes) * 60, std::numeric_limits<uint16_t>::max());
				player->setDailyXpBoostPercent(entry.percent);
				player->setDailyXpBoostTime(static_cast<uint16_t>(seconds));
				player->sendStats();
				describe(fmt::format("{}% XP boost for {} minutes", entry.percent, entry.minutes));
				break;
			}
			case DAILY_REWARD_KIND_COSMETIC_TOKENS: {
				player->addCosmeticTokens(entry.count);
				describe(fmt::format("{}x Cosmetic Token", entry.count));
				break;
			}
			case DAILY_REWARD_KIND_BOUNTY_REROLL_TOKENS: {
				// Stops at the token cap of the bounty board
				player->addRerollTasks(entry.count);
				describe(fmt::format("{}x Bounty Reroll Token", entry.count));
				break;
			}
			default:
				break;
		}
	}

	if (description.empty()) {
		description = "nothing";
	}

	const std::string dailyRewardMessage = fmt::format("Claimed reward no. {}. Received: {}.", rewardDay, description);
	player->sendTextMessage(MESSAGE_EVENT_ADVANCE, dailyRewardMessage);
	insertHistory(player->getGUID(), getDayStreak(player), dailyRewardMessage);
	processReward(player, source);
}
