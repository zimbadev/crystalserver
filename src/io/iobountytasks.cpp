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
#include "lib/di/container.hpp"

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
				validForDifficulty = (mtype->info.bestiaryStars >= 2 && mtype->info.bestiaryStars <= 5);
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

		// Small chance for silver/gold tasks
		int32_t silverGoldChance = uniform_random(1, 100);
		if (silverGoldChance <= 2) {
			creature.taskGrade = BOUNTY_GRADE_GOLD;
			creature.rewardExp = static_cast<uint32_t>(creature.rewardExp * 4);
			creature.rewardBountyPoints = static_cast<uint8_t>(std::min<uint16_t>(creature.rewardBountyPoints * 4, 255));
		} else if (silverGoldChance <= 10) {
			creature.taskGrade = BOUNTY_GRADE_SILVER;
			creature.rewardExp = static_cast<uint32_t>(creature.rewardExp * 2);
			creature.rewardBountyPoints = static_cast<uint8_t>(std::min<uint16_t>(creature.rewardBountyPoints * 2, 255));
		}

		bountyData.currentCreaturesList.push_back(creature);
		creaturesGenerated++;
	}

	bountyData.state = BOUNTY_STATE_SELECTION;
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
				validForDifficulty = (mtype->info.bestiaryStars >= 2 && mtype->info.bestiaryStars <= 5);
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

		int32_t silverGoldChance = uniform_random(1, 100);
		if (silverGoldChance <= 2) {
			creature.taskGrade = BOUNTY_GRADE_GOLD;
			creature.rewardExp = static_cast<uint32_t>(creature.rewardExp * 4);
			creature.rewardBountyPoints = static_cast<uint8_t>(std::min<uint16_t>(creature.rewardBountyPoints * 4, 255));
		} else if (silverGoldChance <= 10) {
			creature.taskGrade = BOUNTY_GRADE_SILVER;
			creature.rewardExp = static_cast<uint32_t>(creature.rewardExp * 2);
			creature.rewardBountyPoints = static_cast<uint8_t>(std::min<uint16_t>(creature.rewardBountyPoints * 2, 255));
		}

		bountyData.currentCreaturesList.push_back(creature);
		creaturesGenerated++;
	}
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

	bountyData.state = BOUNTY_STATE_ACTIVE;
	bountyData.currentCreaturesList.clear();

	player->sendBountyTaskData();
	player->refreshTaskIcons();
}

void IOBountyTasks::changeDifficulty(const std::shared_ptr<Player> &player, BountyTaskDifficulty_t difficulty) {
	if (!player) {
		return;
	}

	if (difficulty > BOUNTY_DIFFICULTY_LAST) {
		return;
	}

	// Validate player level meets the minimum for the requested difficulty
	// Uses the same level gates as weekly tasks: Beginner=8, Adept=30, Expert=150, Master=300
	uint32_t minLevel = IOWeeklyTasks::getMinLevelForDifficulty(static_cast<uint8_t>(difficulty));
	if (player->getLevel() < minLevel) {
		g_logger().warn("[IOBountyTasks::changeDifficulty] - Player {} (level {}) tried to set difficulty {} (requires level {})", player->getName(), player->getLevel(), static_cast<int>(difficulty), minLevel);
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	bountyData.selectedDifficulty = difficulty;
	// Only store the difficulty, creature list is regenerated on reroll (case 4)
}

void IOBountyTasks::rerollCreatureList(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();

	if (bountyData.rerollTasks <= 0 && bountyData.freeRerollTimeStamp > OTSYS_TIME()) {
		player->sendMessageDialog("You don't have any reroll tokens available.");
		player->sendBountyTaskData();
		return;
	}

	if (bountyData.freeRerollTimeStamp <= OTSYS_TIME()) {
		bountyData.freeRerollTimeStamp = OTSYS_TIME() + g_configManager().getNumber(BOUNTY_TASKS_FREE_REROLL_TIME) * 1000;
	} else if (bountyData.rerollTasks > 0) {
		bountyData.rerollTasks--;
	}

	generateCreatureList(player, bountyData.selectedDifficulty);
}

void IOBountyTasks::claimDailyReroll(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();

	if (bountyData.rerollTasks >= BOUNTY_MAX_REROLL_TASKS) {
		player->sendMessageDialog("You already have the maximum number of reroll tokens.");
		player->sendBountyTaskData();
		return;
	}

	if (bountyData.freeRerollTimeStamp > OTSYS_TIME()) {
		player->sendMessageDialog("You cannot claim a daily reroll right now.");
		player->sendBountyTaskData();
		return;
	}

	bountyData.rerollTasks++;
	bountyData.freeRerollTimeStamp = OTSYS_TIME() + g_configManager().getNumber(BOUNTY_TASKS_FREE_REROLL_TIME) * 1000;

	player->sendTextMessage(MESSAGE_STATUS, "You have claimed a daily reroll token.");
	player->sendBountyTaskData();
}

void IOBountyTasks::setPreferredMonster(const std::shared_ptr<Player> &player, uint8_t listType, uint8_t slot, uint16_t raceId) {
	if (!player) {
		return;
	}

	auto &bountyData = player->getBountyTaskData();
	initializeListSlots(bountyData);

	if (slot >= bountyData.preferredLists.size()) {
		return;
	}

	if (bountyData.preferredLists[slot].activedList == 0) {
		return;
	}

	// Validate raceId is a real bestiary creature (prevent sniffer manipulation)
	if (raceId != 0) {
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype) {
			g_logger().warn("[IOBountyTasks::setPreferredMonster] - Player {} sent invalid raceId {}", player->getName(), raceId);
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
		return;
	}

	if (bountyData.preferredLists[slot].activedList == 0) {
		return;
	}

	// Validate raceId is a real bestiary creature (prevent sniffer manipulation)
	if (raceId != 0) {
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype) {
			g_logger().warn("[IOBountyTasks::setUnwantedMonster] - Player {} sent invalid raceId {}", player->getName(), raceId);
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

	// Client always sends 0 - find the next locked slot to unlock
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
	uint32_t expMultiplier = g_configManager().getNumber(BOUNTY_TASKS_EXP_MULTIPLIER);
	uint32_t pointsMultiplier = g_configManager().getNumber(BOUNTY_TASKS_POINTS_MULTIPLIER);
	uint32_t rerollMultiplier = g_configManager().getNumber(BOUNTY_TASKS_REROLL_MULTIPLIER);

	uint32_t rewardExp = bountyData.activeTask.rewardExp * std::max<uint32_t>(expMultiplier, 1);
	uint16_t rewardPoints = std::min<uint16_t>(bountyData.activeTask.rewardBountyPoints * std::max<uint32_t>(pointsMultiplier, 1), 255);
	uint8_t rerollTasksGain = static_cast<uint8_t>(std::max<uint32_t>(rerollMultiplier, 1));

	player->addExperience(nullptr, rewardExp, true);
	player->addBountyPoints(static_cast<uint8_t>(rewardPoints));
	bountyData.rerollTasks += rerollTasksGain;

	player->sendTextMessage(MESSAGE_STATUS, "You have claimed your bounty task reward! (+" + std::to_string(rewardExp) + " exp, +" + std::to_string(rewardPoints) + " bounty points)");

	// Reset and generate new creature list
	bountyData.activeTask = BountyTaskActive();
	bountyData.state = BOUNTY_STATE_NONE;
	generateCreatureList(player, bountyData.selectedDifficulty);
	player->refreshTaskIcons();
}

void IOBountyTasks::upgradeTalisman(const std::shared_ptr<Player> &player, uint8_t pathIndex) {
	if (!player || pathIndex >= TALISMAN_PATH_COUNT) {
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
