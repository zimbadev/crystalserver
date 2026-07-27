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
#include <optional>
#include <string_view>
#include <unordered_map>

namespace {
	struct RewardTypeMapping {
		std::string_view name;
		DailyRewardType_t type;
	};

	constexpr std::array<RewardTypeMapping, 4> REWARD_TYPE_TABLE { {
		{ "item", DAILY_REWARD_TYPE_ITEM },
		{ "storage", DAILY_REWARD_TYPE_STORAGE },
		{ "preyReroll", DAILY_REWARD_TYPE_PREY_REROLL },
		{ "xpBoost", DAILY_REWARD_TYPE_XP_BOOST },
	} };

	struct SystemTypeMapping {
		std::string_view name;
		DailyRewardSystemType_t type;
	};

	constexpr std::array<SystemTypeMapping, 2> SYSTEM_TYPE_TABLE { {
		{ "one", DAILY_REWARD_SYSTEM_TYPE_ONE },
		{ "two", DAILY_REWARD_SYSTEM_TYPE_TWO },
	} };

	std::optional<DailyRewardType_t> parseRewardType(const std::string &value) {
		const auto it = std::ranges::find(REWARD_TYPE_TABLE, value, &RewardTypeMapping::name);
		if (it == REWARD_TYPE_TABLE.end()) {
			return std::nullopt;
		}
		return it->type;
	}

	std::optional<DailyRewardSystemType_t> parseSystemType(const std::string &value) {
		const auto it = std::ranges::find(SYSTEM_TYPE_TABLE, value, &SystemTypeMapping::name);
		if (it == SYSTEM_TYPE_TABLE.end()) {
			return std::nullopt;
		}
		return it->type;
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

	storages = DailyRewardStorages {};
	strikeBonuses.clear();
	rewards.clear();
	vocationItems.clear();
	shrineItems.clear();
	itemGroups.clear();

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

	// itemGroups
	for (const auto &groupNode : root.child("itemGroups").children("group")) {
		const std::string groupName = groupNode.attribute("name").as_string();
		if (groupName.empty()) {
			g_logger().error("[DailyRewards::loadFromXml] <group> node is missing the 'name' attribute, skipping.");
			continue;
		}
		if (itemGroups.contains(groupName)) {
			g_logger().error("[DailyRewards::loadFromXml] Duplicate item group '{}', ignoring duplicate entry.", groupName);
			continue;
		}

		std::vector<uint16_t> items;
		for (const auto &itemNode : groupNode.children("item")) {
			if (const uint16_t itemId = resolveItemId(itemNode); itemId != 0) {
				items.emplace_back(itemId);
			}
		}
		itemGroups.emplace(groupName, std::move(items));
	}

	// vocationItems
	for (const auto &vocationNode : root.child("vocationItems").children("vocation")) {
		const uint8_t vocationId = static_cast<uint8_t>(vocationNode.attribute("id").as_uint());
		if (vocationItems.contains(vocationId)) {
			g_logger().error("[DailyRewards::loadFromXml] Duplicate vocationItems entry for vocation id '{}', ignoring duplicate.", vocationId);
			continue;
		}

		std::vector<uint16_t> items;
		std::unordered_set<uint16_t> seenItems;

		const std::string groupsAttr = vocationNode.attribute("groups").as_string();
		for (const std::string &groupName : explodeString(groupsAttr, ",")) {
			const auto groupIt = itemGroups.find(groupName);
			if (groupIt == itemGroups.end()) {
				g_logger().error(
					"[DailyRewards::loadFromXml] Vocation '{}' references unknown item group '{}', ignoring.",
					vocationId, groupName
				);
				continue;
			}
			for (const uint16_t itemId : groupIt->second) {
				if (seenItems.insert(itemId).second) {
					items.emplace_back(itemId);
				}
			}
		}

		// vocations can still declare extra items inline, on top of any referenced groups.
		for (const auto &itemNode : vocationNode.children("item")) {
			if (const uint16_t itemId = resolveItemId(itemNode); itemId != 0 && seenItems.insert(itemId).second) {
				items.emplace_back(itemId);
			}
		}

		vocationItems.emplace(vocationId, std::move(items));
	}

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

		const std::string systemValue = rewardNode.attribute("systemType").as_string("one");
		const auto parsedSystemType = parseSystemType(systemValue);
		if (!parsedSystemType) {
			g_logger().error("[DailyRewards::loadFromXml] Reward day '{}' has unknown systemType '{}', skipping.", day, systemValue);
			continue;
		}

		DailyRewardDayConfig reward;
		reward.day = day;
		reward.type = *parsedType;
		reward.systemType = *parsedSystemType;
		reward.freeAccount = static_cast<uint16_t>(rewardNode.attribute("freeAccount").as_uint());
		reward.premiumAccount = static_cast<uint16_t>(rewardNode.attribute("premiumAccount").as_uint());
		reward.itemCharges = static_cast<uint16_t>(rewardNode.attribute("itemCharges").as_uint());
		for (const auto &itemNode : rewardNode.children("item")) {
			if (const uint16_t itemId = resolveItemId(itemNode); itemId != 0) {
				reward.items.emplace_back(itemId);
			}
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

			if (player->getZoneType() == ZONE_PROTECTION) {
				uint8_t maxSoul = 100;
				if ((g_configManager().getBoolean(VIP_SYSTEM_ENABLED) && player->isVip()) || player->isPremium()) {
					maxSoul = 200;
				}
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
	const uint32_t streakLevel = getStreakLevel(player);
	if (streakLevel >= DAILY_REWARD_STAMINA_REGENERATION) {
		uint32_t delay = 3 * 60 * 1000;
		if (player->getStaminaMinutes() > 2340 && player->getStaminaMinutes() <= 2520) {
			delay = 6 * 60 * 1000;
		}
		scheduleStaminaRegen(player->getID(), delay);
	}

	if (streakLevel >= DAILY_REWARD_SOUL_REGENERATION) {
		const uint32_t delay = player->getVocation()->getSoulGainTicks();
		scheduleSoulRegen(player->getID(), delay);
	}
}

void DailyRewards::initPlayer(const std::shared_ptr<Player> &player) {
	const time_t now = std::time(nullptr);

	uint32_t nextReward = getNextRewardTime(player);
	if (player->getDailyReward() == DAILY_REWARD_COLLECTED && nextReward == 0) {
		setNextRewardTime(player, static_cast<int32_t>(now + serverTimeThreshold));
		nextReward = getNextRewardTime(player);
	}

	if (nextReward > 0 && now >= nextReward) {
		if (player->getStorageValue(storages.notifyReset) != static_cast<int32_t>(nextReward)) {
			player->addStorageValue(storages.notifyReset, static_cast<int32_t>(nextReward));
			int32_t missedDays = 0;
			if (now > static_cast<time_t>(nextReward)) {
				missedDays = static_cast<int32_t>((now - static_cast<time_t>(nextReward)) / serverTimeThreshold);
			}
			if (missedDays > 0) {
				if (getJokerTokens(player) >= static_cast<uint32_t>(missedDays)) {
					setJokerTokens(player, static_cast<int32_t>(getJokerTokens(player) - missedDays));
					player->sendTextMessage(MESSAGE_LOGIN, fmt::format("You lost {} joker tokens to prevent loosing your streak.", missedDays));
				} else {
					setStreakLevel(player, 0);
					if (player->getLastLoginSaved() > 0) {
						if (getJokerTokens(player) > 0) {
							setJokerTokens(player, 0);
						}
						player->sendTextMessage(MESSAGE_LOGIN, "You just lost your daily reward streak.");
					}
				}
			}
		}
	}

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

	const bool rewardTaken = isRewardTaken(player);
	uint32_t nextRewardTime = getNextRewardTime(player);
	if (rewardTaken && nextRewardTime == 0) {
		nextRewardTime = static_cast<uint32_t>(std::time(nullptr) + serverTimeThreshold);
	}

	const uint8_t shrineFlag = source == DAILY_REWARD_FROM_SHRINE ? 1 : 0;
	player->sendDailyRewardCollectionResource(0x15, getJokerTokens(player));
	player->sendDailyRewardCollectionResource(0x14, getCollectionTokens(player));
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

	if (isRewardTaken(player) && !testMode) {
		player->sendMessageDialog("You have already collected your daily reward.");
		return;
	}

	const uint8_t target = msg.getByte();
	if (target != 0) {
		if (getCollectionTokens(player) < 1) {
			player->sendMessageDialog("You do not have enough collection tokens to proceed.");
			return;
		}
		setCollectionTokens(player, static_cast<int32_t>(getCollectionTokens(player) - 1));
	}

	const uint8_t rewardIndex = getDayStreak(player) + 1;
	const auto rewardIt = rewards.find(rewardIndex);
	if (rewardIt == rewards.end()) {
		player->sendMessageDialog("Something went wrong and we cannot process this request.");
		return;
	}

	const auto &dailyTable = rewardIt->second;
	uint16_t rewardCount = dailyTable.freeAccount;
	if ((g_configManager().getBoolean(VIP_SYSTEM_ENABLED) && player->isVip()) || player->isPremium()) {
		rewardCount = dailyTable.premiumAccount;
	}

	std::string dailyRewardMessage;
	if (dailyTable.type == DAILY_REWARD_TYPE_ITEM) {
		std::vector<uint16_t> possibleItems;
		const uint8_t baseId = player->getVocation()->getBaseId();
		if (const auto itemsIt = vocationItems.find(baseId); itemsIt != vocationItems.end()) {
			possibleItems = itemsIt->second;
		}
		if (!dailyTable.items.empty()) {
			possibleItems = dailyTable.items;
		}

		struct SelectedItem {
			uint16_t itemId = 0;
			uint8_t count = 0;
		};
		std::vector<SelectedItem> selectedItems;
		const uint8_t columnsPicked = msg.getByte();
		uint32_t orderedCounter = 0;
		uint32_t totalCounter = 0;

		for (uint8_t i = 0; i < columnsPicked; ++i) {
			const uint16_t itemId = msg.get<uint16_t>();
			const uint8_t count = msg.getByte();
			orderedCounter += count;
			if (std::ranges::find(possibleItems, itemId) != possibleItems.end()) {
				selectedItems.push_back({ itemId, count });
				totalCounter += count;
			}
		}

		if (totalCounter > rewardCount) {
			g_logger().error(
				"[DailyRewards::playerSelectReward] Player '{}' tried to collect {} items but only {} are allowed for this reward, rejecting.",
				player->getName(),
				totalCounter,
				rewardCount
			);
			player->sendMessageDialog("You cannot collect more items than the daily reward allows.");
			return;
		}
		if (totalCounter != orderedCounter) {
			g_logger().error("[DailyRewards::playerSelectReward] Player '{}' tried to collect invalid daily reward items, rejecting.", player->getName());
			return;
		}

		const auto &inbox = player->getStoreInbox();
		if (!inbox || inbox->size() + selectedItems.size() > inbox->capacity()) {
			player->sendMessageDialog("You do not have enough space in your store inbox.");
			return;
		}

		std::string description;
		for (size_t index = 0; index < selectedItems.size(); ++index) {
			const auto &selected = selectedItems[index];
			const ItemType &itemType = Item::items[selected.itemId];
			if (dailyTable.itemCharges > 0) {
				if (!itemType.stackable) {
					for (uint8_t chargeIndex = 0; chargeIndex < selected.count; ++chargeIndex) {
						const auto &inboxItem = Item::CreateItem(selected.itemId, 1);
						if (!inboxItem) {
							continue;
						}
						inboxItem->setAttribute(ItemAttribute_t::STORE, static_cast<int64_t>(std::time(nullptr)));
						inboxItem->setAttribute(ItemAttribute_t::CHARGES, dailyTable.itemCharges);
						inbox->addItem(inboxItem);
					}
				} else {
					const auto &inboxItem = Item::CreateItem(selected.itemId, selected.count);
					if (inboxItem) {
						inboxItem->setAttribute(ItemAttribute_t::STORE, static_cast<int64_t>(std::time(nullptr)));
						inbox->addItem(inboxItem);
					}
				}
			} else if (itemType.stackable) {
				const auto &inboxItem = Item::CreateItem(selected.itemId, selected.count);
				if (inboxItem) {
					inboxItem->setAttribute(ItemAttribute_t::STORE, static_cast<int64_t>(std::time(nullptr)));
					inbox->addItem(inboxItem);
				}
			} else {
				for (uint8_t itemIndex = 0; itemIndex < selected.count; ++itemIndex) {
					const auto &inboxItem = Item::CreateItem(selected.itemId, 1);
					if (!inboxItem) {
						continue;
					}
					inboxItem->setAttribute(ItemAttribute_t::STORE, static_cast<int64_t>(std::time(nullptr)));
					inbox->addItem(inboxItem);
				}
			}

			description += fmt::format("{}x {}", selected.count, itemType.name);
			if (index + 1 < selectedItems.size()) {
				description += ", ";
			} else {
				description += ".";
			}
		}
		dailyRewardMessage = "Picked items: " + description;
	} else if (dailyTable.type == DAILY_REWARD_TYPE_XP_BOOST) {
		uint16_t rewardCountReviewed = rewardCount;
		const auto xpBoostLeftMinutes = player->kv()->get("daily-reward-xp-boost");
		if (xpBoostLeftMinutes && xpBoostLeftMinutes.has_value()) {
			const auto left = static_cast<uint16_t>(xpBoostLeftMinutes->getNumber());
			if (left > 0) {
				rewardCountReviewed = rewardCountReviewed > left ? rewardCountReviewed - left : 0;
			}
		}

		player->setXpBoostTime(player->getXpBoostTime() + (rewardCountReviewed * 60));
		player->kv()->set("daily-reward-xp-boost", ValueWrapper(static_cast<int>(rewardCount)));
		player->setXpBoostPercent(50);
		dailyRewardMessage = fmt::format("Picked reward: XP Bonus for {} minutes.", rewardCount);
	} else if (dailyTable.type == DAILY_REWARD_TYPE_PREY_REROLL) {
		player->addPreyCards(rewardCount);
		dailyRewardMessage = fmt::format("Picked reward: {}x Prey bonus reroll(s).", rewardCount);
	}

	if (!dailyRewardMessage.empty()) {
		insertHistory(player->getGUID(), getDayStreak(player), fmt::format("Claimed reward no. {}. {}", getDayStreak(player) + 1, dailyRewardMessage));
		processReward(player, target == 0 ? DAILY_REWARD_FROM_SHRINE : DAILY_REWARD_FROM_PANEL);
	}
}
