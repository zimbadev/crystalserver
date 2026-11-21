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

#include "io/iobountytasks.hpp"

#include "config/configmanager.hpp"
#include "creatures/monsters/monsters.hpp"
#include "creatures/players/player.hpp"
#include "game/game.hpp"
#include "io/ioweeklytasks.hpp"
#include "kv/kv.hpp"
#include "kv/value_wrapper.hpp"
#include "lib/di/container.hpp"
#include "utils/tools.hpp"

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <limits>

namespace {
	// Player KV scope of the bounty data that has no database column
	constexpr auto BOUNTY_KV_SCOPE = "bounty-tasks";

	// Config chances are percent values, the grade roll uses hundredths of a percent
	int32_t getBountyGradeChance(float basePercent, float stepPercent, float maxPercent, uint16_t steps) {
		const float chance = std::min(basePercent + stepPercent * static_cast<float>(steps), maxPercent);
		return static_cast<int32_t>(std::lround(std::clamp(chance, 0.0f, 100.0f) * 100.0f));
	}

	int32_t getBountyKVNumber(const std::shared_ptr<KV> &scope, const std::string &key) {
		const auto value = scope->get(key);
		if (!value) {
			return 0;
		}
		return static_cast<int32_t>(value->getNumber());
	}

	std::string getBountyKVString(const std::shared_ptr<KV> &scope, const std::string &key) {
		const auto value = scope->get(key);
		if (!value) {
			return {};
		}
		return value->get<StringType>();
	}

	// "1,2,3" -> { 1, 2, 3 }
	std::vector<uint32_t> parseBountyKVNumbers(const std::string &entry) {
		std::vector<uint32_t> numbers;
		for (const auto &field : explodeString(entry, ",")) {
			numbers.push_back(static_cast<uint32_t>(std::strtoul(field.c_str(), nullptr, 10)));
		}
		return numbers;
	}
} // namespace

IOBountyTasks &IOBountyTasks::getInstance() {
	return inject<IOBountyTasks>();
}

void IOBountyTasks::initializeListSlots(BountyTaskData &bountyData) {
	if (bountyData.preferredLists.empty()) {
		bountyData.preferredLists.resize(BOUNTY_MAX_LIST_SLOTS);
		// First slot starts unlocked (free), rest start locked
		bountyData.preferredLists[0].activedList = 1;
	}

	// Initialize talisman bonuses if not yet calculated (new player with no DB row)
	// Level 0 talismans should have isActivedUpgrade=1 and bountyPointsToUpgrade=5
	if (bountyData.talismanTiers[0].isActivedUpgrade == 0 && bountyData.talismanTiers[0].level == 0
	    && bountyData.talismanTiers[0].bountyPointsToUpgrade == 0) {
		for (uint8_t i = 0; i < TALISMAN_PATH_COUNT; ++i) {
			recalculateTalismanBonuses(bountyData.talismanTiers[i], i);
		}
	}
}

void IOBountyTasks::generateCreatureList(const std::shared_ptr<Player> &player, BountyTaskDifficulty_t difficulty) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(BOUNTY_TASKS_ENABLED)) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	bountyData.currentCreaturesList.clear();
	bountyData.selectedDifficulty = difficulty;

	// Initialize list slots if needed
	initializeListSlots(bountyData);

	const auto &bestiaryList = g_game().getBestiaryList();
	if (bestiaryList.size() < 36) {
		g_logger().error("[IOBountyTasks::generateCreatureList] - Bestiary size is less than 36, cannot generate bounty tasks.");
		saveExtraData(player);
		player->sendBountyTaskData();
		return;
	}

	// Collect preferred and unwanted race IDs from all list slots
	std::set<uint16_t> preferredRaceIds;
	std::set<uint16_t> unwantedRaceIds;
	for (const auto &slot : bountyData.preferredLists) {
		if (slot.activedList == 1) {
			if (slot.preferredRaceId != 0) {
				preferredRaceIds.insert(slot.preferredRaceId);
			}
			if (slot.unwantedRaceId != 0) {
				unwantedRaceIds.insert(slot.unwantedRaceId);
			}
		}
	}

	std::vector<uint16_t> blackList;
	auto maxIndex = static_cast<int32_t>(bestiaryList.size() - 1);

	uint8_t creaturesGenerated = 0;
	uint16_t tries = 0;
	while (creaturesGenerated < BOUNTY_MAX_CREATURES && tries < 1000) {
		uint16_t raceId = (*(std::next(bestiaryList.begin(), uniform_random(0, maxIndex)))).first;
		tries++;

		if (std::count(blackList.begin(), blackList.end(), raceId) != 0) {
			continue;
		}

		// Skip unwanted monsters
		if (unwantedRaceIds.count(raceId) > 0) {
			continue;
		}

		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype || mtype->info.experience == 0 || !mtype->info.isPreyable || mtype->info.isPreyExclusive) {
			continue;
		}

		// Filter by difficulty and bestiary stars
		// Beginner: Easy only (stars 0-1)
		// Adept: Easy + Medium mixed (stars 0-3)
		// Expert: Medium + Hard mixed (stars 2-5)
		// Master: Hard + Challenging mixed (stars 4-6)
		bool validForDifficulty = false;
		switch (difficulty) {
			case BOUNTY_DIFFICULTY_BEGINNER:
				validForDifficulty = (mtype->info.bestiaryStars <= 1);
				break;
			case BOUNTY_DIFFICULTY_ADEPT:
				validForDifficulty = (mtype->info.bestiaryStars <= 3);
				break;
			case BOUNTY_DIFFICULTY_EXPERT:
				validForDifficulty = (mtype->info.bestiaryStars >= 3 && mtype->info.bestiaryStars <= 4);
				break;
			case BOUNTY_DIFFICULTY_MASTER:
				validForDifficulty = (mtype->info.bestiaryStars >= 4);
				break;
		}

		if (!validForDifficulty) {
			// Preferred monster can bypass difficulty filter
			if (preferredRaceIds.count(raceId) > 0) {
				validForDifficulty = true;
			} else {
				continue;
			}
		}

		blackList.push_back(raceId);
		BountyCreatureEntry creature;
		creature.raceId = raceId;
		creature.requiredKills = getRequiredKills(difficulty, mtype->info.bestiaryStars);
		creature.rewardExp = getExpReward(difficulty, mtype->info.experience);
		creature.rewardBountyPoints = getBountyPointsReward(difficulty);
		creature.currentKills = 0;
		creature.claimRewardType = BOUNTY_CLAIM_SELECT_TASK;
		creature.taskIndex = creaturesGenerated;

		// Grade (Silver/Gold/Platinum) from the rarity of the creature, Elite from the board setting
		applyGradeAndElite(bountyData, creature, difficulty);

		bountyData.currentCreaturesList.push_back(creature);
		creaturesGenerated++;
	}

	bountyData.state = BOUNTY_STATE_SELECTION;
	saveExtraData(player);
	player->sendBountyTaskData();
}

void IOBountyTasks::fillMissingCreatures(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	if (bountyData.currentCreaturesList.size() >= BOUNTY_MAX_CREATURES) {
		return;
	}

	const auto &bestiaryList = g_game().getBestiaryList();
	if (bestiaryList.size() < 36) {
		return;
	}

	auto difficulty = bountyData.selectedDifficulty;

	// Collect preferred and unwanted race IDs from all preferred lists
	std::set<uint16_t> preferredRaceIds;
	std::set<uint16_t> unwantedRaceIds;
	for (const auto &slot : bountyData.preferredLists) {
		if (slot.activedList == 1) {
			if (slot.preferredRaceId != 0) {
				preferredRaceIds.insert(slot.preferredRaceId);
			}
			if (slot.unwantedRaceId != 0) {
				unwantedRaceIds.insert(slot.unwantedRaceId);
			}
		}
	}

	// Blacklist existing creature race IDs to avoid duplicates
	std::vector<uint16_t> blackList;
	for (const auto &creature : bountyData.currentCreaturesList) {
		blackList.push_back(creature.raceId);
	}

	auto maxIndex = static_cast<int32_t>(bestiaryList.size() - 1);
	uint8_t creaturesGenerated = static_cast<uint8_t>(bountyData.currentCreaturesList.size());
	uint16_t tries = 0;
	while (creaturesGenerated < BOUNTY_MAX_CREATURES && tries < 1000) {
		uint16_t raceId = (*(std::next(bestiaryList.begin(), uniform_random(0, maxIndex)))).first;
		tries++;

		if (std::count(blackList.begin(), blackList.end(), raceId) != 0) {
			continue;
		}

		if (unwantedRaceIds.count(raceId) > 0) {
			continue;
		}

		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype || mtype->info.experience == 0 || !mtype->info.isPreyable || mtype->info.isPreyExclusive) {
			continue;
		}

		bool validForDifficulty = false;
		switch (difficulty) {
			case BOUNTY_DIFFICULTY_BEGINNER:
				validForDifficulty = (mtype->info.bestiaryStars <= 1);
				break;
			case BOUNTY_DIFFICULTY_ADEPT:
				validForDifficulty = (mtype->info.bestiaryStars <= 3);
				break;
			case BOUNTY_DIFFICULTY_EXPERT:
				validForDifficulty = (mtype->info.bestiaryStars >= 3 && mtype->info.bestiaryStars <= 4);
				break;
			case BOUNTY_DIFFICULTY_MASTER:
				validForDifficulty = (mtype->info.bestiaryStars >= 4);
				break;
		}

		if (!validForDifficulty) {
			if (preferredRaceIds.count(raceId) > 0) {
				validForDifficulty = true;
			} else {
				continue;
			}
		}

		blackList.push_back(raceId);
		BountyCreatureEntry creature;
		creature.raceId = raceId;
		creature.requiredKills = getRequiredKills(difficulty, mtype->info.bestiaryStars);
		creature.rewardExp = getExpReward(difficulty, mtype->info.experience);
		creature.rewardBountyPoints = getBountyPointsReward(difficulty);
		creature.currentKills = 0;
		creature.claimRewardType = BOUNTY_CLAIM_SELECT_TASK;
		creature.taskIndex = creaturesGenerated;

		applyGradeAndElite(bountyData, creature, difficulty);

		bountyData.currentCreaturesList.push_back(creature);
		creaturesGenerated++;
	}

	saveExtraData(player);
}

void IOBountyTasks::selectTask(const std::shared_ptr<Player> &player, uint8_t taskIndex) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	if (bountyData.state != BOUNTY_STATE_SELECTION) {
		player->sendMessageDialog("You don't have any tasks available to select.");
		player->sendBountyTaskData();
		return;
	}

	if (taskIndex >= bountyData.currentCreaturesList.size()) {
		player->sendMessageDialog("Invalid task selection.");
		player->sendBountyTaskData();
		return;
	}

	const auto &creature = bountyData.currentCreaturesList[taskIndex];
	bountyData.activeTask.raceId = creature.raceId;
	bountyData.activeTask.requiredKills = creature.requiredKills;
	bountyData.activeTask.currentKills = 0;
	bountyData.activeTask.rewardExp = creature.rewardExp;
	bountyData.activeTask.rewardBountyPoints = creature.rewardBountyPoints;
	bountyData.activeTask.taskGrade = creature.taskGrade;
	bountyData.activeTask.difficulty = bountyData.selectedDifficulty;
	bountyData.activeTask.taskIndex = taskIndex;
	bountyData.activeTask.isElite = creature.isElite;
	bountyData.activeTask.rewardDust = creature.rewardDust;

	// The creatures that were not chosen gain rarity, an improved chosen one is reset
	growRarity(bountyData, taskIndex);

	bountyData.state = BOUNTY_STATE_ACTIVE;
	bountyData.currentCreaturesList.clear();

	saveExtraData(player);
	player->sendBountyTaskData();
	player->refreshTaskIcons();
}

void IOBountyTasks::changeDifficulty(const std::shared_ptr<Player> &player, BountyTaskDifficulty_t difficulty, bool setElite /* = false */, bool elite /* = false */) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();

	// The Elite setting travels with the difficulty (15.33) and applies to the next rolled tasks only
	if (setElite) {
		bountyData.eliteEnabled = elite;
		saveExtraData(player);
	}

	// The client keeps the board busy until it gets a board, so every path below answers with one
	if (difficulty > BOUNTY_DIFFICULTY_LAST) {
		player->sendBountyTaskData();
		return;
	}

	// Validate player level meets the minimum for the requested difficulty
	// Uses the same level gates as weekly tasks: Beginner=8, Adept=30, Expert=150, Master=300
	uint32_t minLevel = IOWeeklyTasks::getMinLevelForDifficulty(static_cast<uint8_t>(difficulty));
	if (player->getLevel() < minLevel) {
		g_logger().warn("[IOBountyTasks::changeDifficulty] - Player {} (level {}) tried to set difficulty {} (requires level {})", player->getName(), player->getLevel(), static_cast<int>(difficulty), minLevel);
		player->sendCancelMessage(fmt::format("You need level {} or higher to select this difficulty.", minLevel));
		player->sendBountyTaskData();
		return;
	}

	bountyData.selectedDifficulty = difficulty;
	// Only store the difficulty, creature list is regenerated on reroll (case 3)
	player->sendBountyTaskData();
}

void IOBountyTasks::rerollCreatureList(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();

	// Winter Update 2026: rerolls only cost Reroll Tokens, the free reroll timer is gone
	if (bountyData.rerollTasks == 0) {
		player->sendMessageDialog("You don't have any reroll tokens available.");
		player->sendBountyTaskData();
		return;
	}

	bountyData.rerollTasks--;

	// Every creature of the rerolled list gains rarity
	if (bountyData.state == BOUNTY_STATE_SELECTION) {
		growRarity(bountyData, -1);
	}

	// A reroll while a task is running gives it up (as before); forget it so its Elite modifiers and icons end
	const bool hadTask = bountyData.state == BOUNTY_STATE_ACTIVE || bountyData.state == BOUNTY_STATE_COMPLETED;
	if (hadTask) {
		bountyData.activeTask = BountyTaskActive();
	}

	generateCreatureList(player, bountyData.selectedDifficulty);

	if (hadTask) {
		player->refreshTaskIcons();
	}
}

void IOBountyTasks::claimDailyReroll(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	// Winter Update 2026: the "Claim Daily" reroll is removed. Only a 15.30 client still sends this action;
	// tell the player where tokens come from now and answer with the board.
	player->sendTextMessage(MESSAGE_STATUS, "Reroll tokens are no longer claimed here. You receive one for every daily reward you claim and for every bounty task you complete.");
	player->sendBountyTaskData();
}

void IOBountyTasks::setPreferredMonster(const std::shared_ptr<Player> &player, uint8_t listType, uint8_t slot, uint16_t raceId) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	initializeListSlots(bountyData);

	if (slot >= bountyData.preferredLists.size()) {
		player->sendBountyTaskData();
		return;
	}

	if (bountyData.preferredLists[slot].activedList == 0) {
		player->sendBountyTaskData();
		return;
	}

	// Validate raceId is a real bestiary creature (prevent sniffer manipulation)
	if (raceId != 0) {
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype) {
			g_logger().warn("[IOBountyTasks::setPreferredMonster] - Player {} sent invalid raceId {}", player->getName(), raceId);
			player->sendBountyTaskData();
			return;
		}
	}

	// Clearing preferred costs 10 bounty points
	if (raceId == 0 && bountyData.preferredLists[slot].preferredRaceId != 0) {
		static constexpr uint32_t CLEAR_COST = 10;
		if (bountyData.bountyPoints < CLEAR_COST) {
			player->sendMessageDialog("You don't have enough bounty points to clear this slot.");
			player->sendBountyTaskData();
			return;
		}
		bountyData.bountyPoints -= CLEAR_COST;
		player->sendTaskBoardResourceBalance();
	}

	bountyData.preferredLists[slot].preferredRaceId = raceId;
	player->sendBountyTaskData();
}

void IOBountyTasks::setUnwantedMonster(const std::shared_ptr<Player> &player, uint8_t listType, uint8_t slot, uint16_t raceId) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	initializeListSlots(bountyData);

	if (slot >= bountyData.preferredLists.size()) {
		player->sendBountyTaskData();
		return;
	}

	if (bountyData.preferredLists[slot].activedList == 0) {
		player->sendBountyTaskData();
		return;
	}

	// Validate raceId is a real bestiary creature (prevent sniffer manipulation)
	if (raceId != 0) {
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype) {
			g_logger().warn("[IOBountyTasks::setUnwantedMonster] - Player {} sent invalid raceId {}", player->getName(), raceId);
			player->sendBountyTaskData();
			return;
		}
	}

	// Clearing unwanted costs 10 bounty points
	if (raceId == 0 && bountyData.preferredLists[slot].unwantedRaceId != 0) {
		static constexpr uint32_t CLEAR_COST = 10;
		if (bountyData.bountyPoints < CLEAR_COST) {
			player->sendMessageDialog("You don't have enough bounty points to clear this slot.");
			player->sendBountyTaskData();
			return;
		}
		bountyData.bountyPoints -= CLEAR_COST;
		player->sendTaskBoardResourceBalance();
	}

	bountyData.preferredLists[slot].unwantedRaceId = raceId;
	player->sendBountyTaskData();
}

void IOBountyTasks::unlockListSlot(const std::shared_ptr<Player> &player, uint8_t /*clientSlot*/) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	initializeListSlots(bountyData);

	// A 15.30 client always sends 0 and a 15.33 client sends no slot at all - find the next locked slot to unlock
	size_t slot = 0;
	bool found = false;
	for (size_t i = 0; i < bountyData.preferredLists.size(); ++i) {
		if (bountyData.preferredLists[i].activedList == 0) {
			slot = i;
			found = true;
			break;
		}
	}

	if (!found) {
		player->sendBountyTaskData();
		return;
	}

	// Unlock costs per slot: 0, 300, 600, 900, 1200
	static constexpr uint32_t SLOT_UNLOCK_COSTS[] = { 0, 300, 600, 900, 1200 };
	uint32_t cost = (slot < 5) ? SLOT_UNLOCK_COSTS[slot] : 1200;

	if (bountyData.bountyPoints < cost) {
		player->sendMessageDialog("You don't have enough bounty points to unlock this list slot.");
		player->sendBountyTaskData();
		return;
	}

	bountyData.bountyPoints -= cost;
	bountyData.preferredLists[slot].activedList = 1;

	player->sendBountyTaskData();
	player->sendTaskBoardResourceBalance();
}

void IOBountyTasks::onCreatureKill(const std::shared_ptr<Player> &player, uint16_t raceId) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(BOUNTY_TASKS_ENABLED)) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	if (bountyData.state != BOUNTY_STATE_ACTIVE) {
		return;
	}

	if (bountyData.activeTask.raceId != raceId) {
		return;
	}

	uint32_t kills = g_configManager().getNumber(BOUNTY_TASKS_KILL_MULTIPLIER);

	bountyData.activeTask.currentKills = std::min(
		bountyData.activeTask.currentKills + kills,
		(uint32_t)bountyData.activeTask.requiredKills
	);

	if (bountyData.activeTask.currentKills >= bountyData.activeTask.requiredKills) {
		bountyData.state = BOUNTY_STATE_COMPLETED;
		player->sendTextMessage(MESSAGE_STATUS, "You have completed your bounty task! Claim your reward.");
		player->sendScreenshotAndBannerBountyTaskFinished(bountyData.activeTask.raceId);
	}

	player->sendBountyTaskData();
}

void IOBountyTasks::claimTaskReward(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	if (bountyData.state != BOUNTY_STATE_COMPLETED) {
		player->sendMessageDialog("You don't have a completed task to claim.");
		player->sendBountyTaskData();
		return;
	}

	// Grant rewards (apply config multipliers)
	// rewardExp and rewardBountyPoints already include the grade multiplier and the Elite experience bonus
	const uint64_t expMultiplier = static_cast<uint64_t>(std::max<int32_t>(g_configManager().getNumber(BOUNTY_TASKS_EXP_MULTIPLIER), 1));
	const uint64_t pointsMultiplier = static_cast<uint64_t>(std::max<int32_t>(g_configManager().getNumber(BOUNTY_TASKS_POINTS_MULTIPLIER), 1));
	const uint32_t rerollMultiplier = static_cast<uint32_t>(std::max<int32_t>(g_configManager().getNumber(BOUNTY_TASKS_REROLL_MULTIPLIER), 1));

	const uint64_t rewardExp = std::min<uint64_t>(bountyData.activeTask.rewardExp * expMultiplier, std::numeric_limits<uint32_t>::max());
	const uint32_t rewardPoints = static_cast<uint32_t>(std::min<uint64_t>(bountyData.activeTask.rewardBountyPoints * pointsMultiplier, std::numeric_limits<uint32_t>::max()));

	// Every completed task gives a Reroll Token, up to the token cap
	const uint32_t maxRerollTokens = getMaxRerollTokens();
	const uint32_t rerollTokensBefore = bountyData.rerollTasks;
	bountyData.rerollTasks = static_cast<uint8_t>(std::min<uint32_t>(rerollTokensBefore + rerollMultiplier, std::max<uint32_t>(maxRerollTokens, rerollTokensBefore)));
	const uint32_t rerollTokensGained = bountyData.rerollTasks - rerollTokensBefore;

	// Elite tasks also reward forge dust, for Premium accounts only
	uint64_t rewardDust = 0;
	if (bountyData.activeTask.isElite && bountyData.activeTask.rewardDust > 0 && player->isPremium()) {
		rewardDust = bountyData.activeTask.rewardDust;
		if (g_configManager().getBoolean(BOUNTY_TASKS_ELITE_DUST_RESPECTS_LIMIT)) {
			const uint64_t dustLimit = player->getForgeDustLevel();
			const uint64_t currentDust = player->getForgeDusts();
			rewardDust = currentDust < dustLimit ? std::min<uint64_t>(rewardDust, dustLimit - currentDust) : 0;
		}
	}

	player->addExperience(nullptr, rewardExp, true);
	player->addBountyPoints(rewardPoints);
	if (rewardDust > 0) {
		player->addForgeDusts(rewardDust);
	}

	std::string rewardMessage = fmt::format("You have claimed your bounty task reward! (+{} exp, +{} bounty points", rewardExp, rewardPoints);
	if (rewardDust > 0) {
		rewardMessage += fmt::format(", +{} dust", rewardDust);
	}
	if (rerollTokensGained > 0) {
		rewardMessage += fmt::format(", +{} reroll token{}", rerollTokensGained, rerollTokensGained != 1 ? "s" : "");
	}
	rewardMessage += ")";
	player->sendTextMessage(MESSAGE_STATUS, rewardMessage);

	// Reset and generate new creature list
	bountyData.activeTask = BountyTaskActive();
	bountyData.state = BOUNTY_STATE_NONE;
	generateCreatureList(player, bountyData.selectedDifficulty);
	player->refreshTaskIcons();
}

void IOBountyTasks::upgradeTalisman(const std::shared_ptr<Player> &player, uint8_t pathIndex) {
	if (!player) {
		return;
	}

	if (pathIndex >= TALISMAN_PATH_COUNT) {
		player->sendBountyTaskData();
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	auto &talisman = bountyData.talismanTiers[pathIndex];

	if (talisman.isActivedUpgrade == 0) {
		player->sendMessageDialog("This talisman path upgrade is not available.");
		player->sendBountyTaskData();
		return;
	}

	uint16_t cost = talisman.bountyPointsToUpgrade;
	if (bountyData.bountyPoints < cost) {
		player->sendMessageDialog("You don't have enough bounty points to upgrade this talisman path.");
		player->sendBountyTaskData();
		return;
	}

	bountyData.bountyPoints -= cost;
	talisman.level++;

	// Recalculate bonuses and upgrade cost
	recalculateTalismanBonuses(talisman, pathIndex);

	player->sendBountyTaskData();
	player->sendTaskBoardResourceBalance();
}

uint16_t IOBountyTasks::getRequiredKills(BountyTaskDifficulty_t difficulty, uint8_t /*bestiaryStars*/) const {
	// Kill counts per difficulty - purely random within range:
	// Beginner: 50-100, Adept: 100-200, Expert: 200-300, Master: 300-600
	uint16_t minKills = 50;
	uint16_t maxKills = 100;

	switch (difficulty) {
		case BOUNTY_DIFFICULTY_BEGINNER:
			minKills = 50;
			maxKills = 100;
			break;
		case BOUNTY_DIFFICULTY_ADEPT:
			minKills = 100;
			maxKills = 200;
			break;
		case BOUNTY_DIFFICULTY_EXPERT:
			minKills = 200;
			maxKills = 300;
			break;
		case BOUNTY_DIFFICULTY_MASTER:
			minKills = 300;
			maxKills = 600;
			break;
	}

	return static_cast<uint16_t>(uniform_random(minKills, maxKills));
}

uint32_t IOBountyTasks::getExpReward(BountyTaskDifficulty_t difficulty, uint32_t creatureExp) const {
	uint32_t minMultiplier = 1;
	uint32_t maxMultiplier = 1;
	switch (difficulty) {
		case BOUNTY_DIFFICULTY_BEGINNER:
			minMultiplier = 30;
			maxMultiplier = 50;
			break;
		case BOUNTY_DIFFICULTY_ADEPT:
			minMultiplier = 70;
			maxMultiplier = 100;
			break;
		case BOUNTY_DIFFICULTY_EXPERT:
			minMultiplier = 150;
			maxMultiplier = 200;
			break;
		case BOUNTY_DIFFICULTY_MASTER:
			minMultiplier = 300;
			maxMultiplier = 400;
			break;
	}
	uint32_t multiplier = static_cast<uint32_t>(uniform_random(minMultiplier, maxMultiplier));
	return creatureExp * multiplier;
}

uint8_t IOBountyTasks::getBountyPointsReward(BountyTaskDifficulty_t difficulty) const {
	switch (difficulty) {
		case BOUNTY_DIFFICULTY_BEGINNER:
			return 3;
		case BOUNTY_DIFFICULTY_ADEPT:
			return 7;
		case BOUNTY_DIFFICULTY_EXPERT:
			return 16;
		case BOUNTY_DIFFICULTY_MASTER:
			return 27;
		default:
			return 3;
	}
}

uint8_t IOBountyTasks::getGradeMultiplier(BountyTaskGrade_t grade) {
	switch (grade) {
		case BOUNTY_GRADE_SILVER:
			return 2;
		case BOUNTY_GRADE_GOLD:
			return 4;
		case BOUNTY_GRADE_PLATINUM:
			return 8;
		default:
			return 1;
	}
}

uint16_t IOBountyTasks::getEliteDustReward(BountyTaskDifficulty_t difficulty, BountyTaskGrade_t grade) const {
	// Base value per difficulty (config), multiplied by the grade
	int32_t baseDust = 0;
	switch (difficulty) {
		case BOUNTY_DIFFICULTY_BEGINNER:
			baseDust = g_configManager().getNumber(BOUNTY_TASKS_ELITE_DUST_BEGINNER);
			break;
		case BOUNTY_DIFFICULTY_ADEPT:
			baseDust = g_configManager().getNumber(BOUNTY_TASKS_ELITE_DUST_ADEPT);
			break;
		case BOUNTY_DIFFICULTY_EXPERT:
			baseDust = g_configManager().getNumber(BOUNTY_TASKS_ELITE_DUST_EXPERT);
			break;
		case BOUNTY_DIFFICULTY_MASTER:
			baseDust = g_configManager().getNumber(BOUNTY_TASKS_ELITE_DUST_MASTER);
			break;
		default:
			break;
	}

	const int64_t dust = static_cast<int64_t>(std::max<int32_t>(baseDust, 0)) * getGradeMultiplier(grade);
	return static_cast<uint16_t>(std::min<int64_t>(dust, std::numeric_limits<uint16_t>::max()));
}

uint8_t IOBountyTasks::getMaxRerollTokens() {
	// `reroll_tokens` is a signed tinyint column
	return static_cast<uint8_t>(std::clamp<int32_t>(g_configManager().getNumber(BOUNTY_TASKS_MAX_REROLL_TOKENS), 0, BOUNTY_MAX_COLUMN_REROLL_TOKENS));
}

bool IOBountyTasks::isEliteTaskCreature(const std::shared_ptr<Player> &player, uint16_t raceId) const {
	if (!player) {
		return false;
	}

	const auto &bountyData = player->getBountyTaskData();
	return bountyData.state == BOUNTY_STATE_ACTIVE && bountyData.activeTask.isElite && bountyData.activeTask.raceId == raceId;
}

BountyTaskGrade_t IOBountyTasks::rollTaskGrade(const BountyTaskData &bountyData, uint16_t raceId) const {
	uint16_t steps = 0;
	bool rerolled = false;
	if (const auto it = bountyData.rarityStates.find(raceId); it != bountyData.rarityStates.end()) {
		steps = it->second.steps;
		rerolled = it->second.rerolled;
	}

	const auto &config = g_configManager();
	const int32_t silverChance = getBountyGradeChance(config.getFloat(BOUNTY_TASKS_SILVER_BASE_CHANCE), config.getFloat(BOUNTY_TASKS_SILVER_CHANCE_STEP), config.getFloat(BOUNTY_TASKS_SILVER_MAX_CHANCE), steps);
	const int32_t goldChance = getBountyGradeChance(config.getFloat(BOUNTY_TASKS_GOLD_BASE_CHANCE), config.getFloat(BOUNTY_TASKS_GOLD_CHANCE_STEP), config.getFloat(BOUNTY_TASKS_GOLD_MAX_CHANCE), steps);
	int32_t platinumChance = getBountyGradeChance(config.getFloat(BOUNTY_TASKS_PLATINUM_BASE_CHANCE), config.getFloat(BOUNTY_TASKS_PLATINUM_CHANCE_STEP), config.getFloat(BOUNTY_TASKS_PLATINUM_MAX_CHANCE), steps);
	if (!rerolled && config.getBoolean(BOUNTY_TASKS_PLATINUM_REQUIRES_REROLL)) {
		platinumChance = 0;
	}

	// One roll in hundredths of a percent, best grade first
	const int32_t roll = uniform_random(1, 10000);
	if (roll <= platinumChance) {
		return BOUNTY_GRADE_PLATINUM;
	}
	if (roll <= platinumChance + goldChance) {
		return BOUNTY_GRADE_GOLD;
	}
	if (roll <= platinumChance + goldChance + silverChance) {
		return BOUNTY_GRADE_SILVER;
	}
	return BOUNTY_GRADE_NORMAL;
}

void IOBountyTasks::applyGradeAndElite(const BountyTaskData &bountyData, BountyCreatureEntry &creature, BountyTaskDifficulty_t difficulty) const {
	creature.taskGrade = rollTaskGrade(bountyData, creature.raceId);
	creature.isElite = bountyData.eliteEnabled;

	// The grade multiplies experience, bounty points and Elite dust; Elite adds experience on top
	const uint64_t gradeMultiplier = getGradeMultiplier(creature.taskGrade);
	uint64_t rewardExp = creature.rewardExp * gradeMultiplier;
	if (creature.isElite) {
		const auto eliteExpPercent = static_cast<uint64_t>(std::max<int32_t>(g_configManager().getNumber(BOUNTY_TASKS_ELITE_EXP_PERCENT), 0));
		rewardExp += rewardExp * eliteExpPercent / 100;
		creature.rewardDust = getEliteDustReward(difficulty, creature.taskGrade);
	} else {
		creature.rewardDust = 0;
	}

	// `active_reward_exp` is a signed int column
	creature.rewardExp = static_cast<uint32_t>(std::min<uint64_t>(rewardExp, std::numeric_limits<int32_t>::max()));
	creature.rewardBountyPoints = static_cast<uint16_t>(std::min<uint64_t>(creature.rewardBountyPoints * gradeMultiplier, std::numeric_limits<uint16_t>::max()));
}

void IOBountyTasks::growRarity(BountyTaskData &bountyData, int32_t chosenIndex) const {
	const bool rerolled = chosenIndex < 0;
	int32_t index = 0;
	for (const auto &creature : bountyData.currentCreaturesList) {
		if (index++ == chosenIndex) {
			// Choosing an improved task resets the chances of that creature
			if (creature.taskGrade != BOUNTY_GRADE_NORMAL) {
				bountyData.rarityStates.erase(creature.raceId);
			}
			continue;
		}

		auto &state = bountyData.rarityStates[creature.raceId];
		if (state.steps < std::numeric_limits<uint16_t>::max()) {
			++state.steps;
		}
		if (rerolled) {
			state.rerolled = true;
		}
	}
}

void IOBountyTasks::loadExtraData(const std::shared_ptr<Player> &player) const {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	const auto scope = player->kv()->scoped(BOUNTY_KV_SCOPE);

	bountyData.eliteEnabled = getBountyKVNumber(scope, "elite-enabled") != 0;

	// Active task: only when the KV values belong to the task of the database row
	const bool hasActiveTask = bountyData.state == BOUNTY_STATE_ACTIVE || bountyData.state == BOUNTY_STATE_COMPLETED;
	if (hasActiveTask && bountyData.activeTask.raceId != 0 && getBountyKVNumber(scope, "active-raceid") == bountyData.activeTask.raceId) {
		bountyData.activeTask.isElite = getBountyKVNumber(scope, "active-elite") != 0;
		bountyData.activeTask.rewardDust = static_cast<uint16_t>(std::clamp<int32_t>(getBountyKVNumber(scope, "active-dust"), 0, std::numeric_limits<uint16_t>::max()));
		// The column only holds up to 127 points, the KV has the full value
		const int32_t activePoints = getBountyKVNumber(scope, "active-points");
		if (activePoints > bountyData.activeTask.rewardBountyPoints) {
			bountyData.activeTask.rewardBountyPoints = static_cast<uint16_t>(std::min<int32_t>(activePoints, std::numeric_limits<uint16_t>::max()));
		}
	}

	// Offered creatures: "raceId,isElite,rewardDust;" in list order
	const auto offers = explodeString(getBountyKVString(scope, "offers"), ";");
	for (size_t i = 0; i < bountyData.currentCreaturesList.size() && i < offers.size(); ++i) {
		const auto fields = parseBountyKVNumbers(offers[i]);
		auto &creature = bountyData.currentCreaturesList[i];
		if (fields.size() < 3 || fields[0] != creature.raceId) {
			continue;
		}
		creature.isElite = fields[1] != 0;
		creature.rewardDust = static_cast<uint16_t>(std::min<uint32_t>(fields[2], std::numeric_limits<uint16_t>::max()));
	}

	// Rarity growth: "raceId,steps,rerolled;"
	bountyData.rarityStates.clear();
	for (const auto &entry : explodeString(getBountyKVString(scope, "rarity"), ";")) {
		const auto fields = parseBountyKVNumbers(entry);
		if (fields.size() < 3 || fields[0] == 0 || fields[0] > std::numeric_limits<uint16_t>::max()) {
			continue;
		}
		BountyRarityState state;
		state.steps = static_cast<uint16_t>(std::min<uint32_t>(fields[1], std::numeric_limits<uint16_t>::max()));
		state.rerolled = fields[2] != 0;
		bountyData.rarityStates[static_cast<uint16_t>(fields[0])] = state;
	}
}

void IOBountyTasks::saveExtraData(const std::shared_ptr<Player> &player) const {
	if (!player) {
		return;
	}

	const auto &bountyData = player->getBountyTaskData();
	const auto scope = player->kv()->scoped(BOUNTY_KV_SCOPE);

	scope->set("elite-enabled", ValueWrapper(static_cast<int>(bountyData.eliteEnabled ? 1 : 0)));
	scope->set("active-raceid", ValueWrapper(static_cast<int>(bountyData.activeTask.raceId)));
	scope->set("active-elite", ValueWrapper(static_cast<int>(bountyData.activeTask.isElite ? 1 : 0)));
	scope->set("active-dust", ValueWrapper(static_cast<int>(bountyData.activeTask.rewardDust)));
	scope->set("active-points", ValueWrapper(static_cast<int>(bountyData.activeTask.rewardBountyPoints)));

	std::string offers;
	for (const auto &creature : bountyData.currentCreaturesList) {
		offers += fmt::format("{},{},{};", creature.raceId, creature.isElite ? 1 : 0, creature.rewardDust);
	}
	scope->set("offers", ValueWrapper(offers));

	std::string rarity;
	for (const auto &[raceId, state] : bountyData.rarityStates) {
		rarity += fmt::format("{},{},{};", raceId, state.steps, state.rerolled ? 1 : 0);
	}
	scope->set("rarity", ValueWrapper(rarity));
}

uint16_t IOBountyTasks::getTalismanUpgradeCost(uint8_t currentLevel) {
	return static_cast<uint16_t>(5 + currentLevel * 12);
}

uint32_t IOBountyTasks::getTalismanBonusHundredths(uint8_t level, uint8_t pathIndex) {
	// Calculate the actual bonus in hundredths of a percent for a given talisman level
	//
	// Paths 0-2 (Damage, Life Leech, Loot):
	//   Level 1 = 2.5%, then +0.5% per level until 15.0% (level 26)
	//   After 15%: +0.25% per level until max 50% (level 166)
	//   Examples: L1=2.5%, L2=3.0%, L3=3.5%, ..., L26=15.0%, L27=15.25%, ..., L166=50.0%
	//
	// Path 3 (Bestiary):
	//   +1% per level until 20% (level 20)
	//   After 20%: +0.5% per level until max 100% (level 180)
	//   Examples: L1=1%, L2=2%, ..., L20=20%, L21=20.5%, ..., L180=100%
	if (level == 0) {
		return 0;
	}

	switch (pathIndex) {
		case BOUNTY_TALISMAN_DAMAGE:
		case BOUNTY_TALISMAN_LIFELEECH:
		case BOUNTY_TALISMAN_LOOT: {
			// Level 1 = 250 (2.5%), then +50 (0.5%) per level until 1500 (15.0%) at level 26
			// After level 26: +25 (0.25%) per level until 5000 (50%) at level 166
			if (level <= 26) {
				// 250 + (level - 1) * 50
				return 250 + (level - 1) * 50;
			}
			// 1500 + (level - 26) * 25, capped at 5000 (50%)
			return std::min<uint32_t>(1500 + (level - 26) * 25, 5000);
		}
		case BOUNTY_TALISMAN_BESTIARY: {
			// Level 1 = 100 (1%), +100 (1%) per level until 2000 (20%) at level 20
			// After level 20: +50 (0.5%) per level until 10000 (100%) at level 180
			if (level <= 20) {
				return level * 100;
			}
			// 2000 + (level - 20) * 50, capped at 10000 (100%)
			return std::min<uint32_t>(2000 + (level - 20) * 50, 10000);
		}
		default:
			return 0;
	}
}

void IOBountyTasks::recalculateTalismanBonuses(BountyTalismanTier &tier, uint8_t pathIndex) {
	if (tier.level == 0) {
		tier.multiplier1 = 0;
		tier.multiplier2 = 0;
		tier.isActivedUpgrade = 1;
		tier.bonusHundredths = 0;
		tier.bountyPointsToUpgrade = getTalismanUpgradeCost(0);
		return;
	}

	// Protocol sends the LEVEL in multiplier1 (client calculates display percentage)
	// multiplier2 is unused (always 0)
	tier.multiplier1 = tier.level;
	tier.multiplier2 = 0;

	// Cache the bonus percentage so we don't recalculate every hit
	tier.bonusHundredths = getTalismanBonusHundredths(tier.level, pathIndex);

	// Max levels based on reaching max bonus:
	// Paths 0-2: 50% = 2.5% + 25*0.5% = 15% (level 26) + 140*0.25% = 35% → level 166
	// Path 3:   100% = 20*1% = 20% (level 20) + 160*0.5% = 80% → level 180
	uint8_t maxLevel;
	switch (pathIndex) {
		case BOUNTY_TALISMAN_DAMAGE:
		case BOUNTY_TALISMAN_LIFELEECH:
		case BOUNTY_TALISMAN_LOOT:
			maxLevel = 166;
			break;
		case BOUNTY_TALISMAN_BESTIARY:
			maxLevel = 180;
			break;
		default:
			maxLevel = 166;
			break;
	}

	if (tier.level >= maxLevel) {
		tier.isActivedUpgrade = 0;
		tier.bountyPointsToUpgrade = 0;
	} else {
		tier.isActivedUpgrade = 1;
		tier.bountyPointsToUpgrade = getTalismanUpgradeCost(tier.level);
	}
}

uint16_t IOBountyTasks::getBountyTalismanBonus(const std::shared_ptr<Player> &player, uint16_t raceId, uint8_t pathIndex) const {
	if (!player || pathIndex >= TALISMAN_PATH_COUNT) {
		return 0;
	}

	if (!player->isBountyTalismanEquipped()) {
		return 0;
	}

	const auto &bountyData = player->getBountyTaskData();
	if (bountyData.state != BOUNTY_STATE_ACTIVE) {
		return 0;
	}

	if (bountyData.activeTask.raceId != raceId) {
		return 0;
	}

	// Return cached bonus in hundredths of a percent (pre-calculated on load/upgrade)
	const auto &tier = bountyData.talismanTiers[pathIndex];
	return static_cast<uint16_t>(tier.bonusHundredths);
}
