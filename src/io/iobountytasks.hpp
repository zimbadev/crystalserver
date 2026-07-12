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

#pragma once

#include "server/network/message/networkmessage.hpp"

class Player;
class NetworkMessage;

// Bounty Task difficulty levels
enum BountyTaskDifficulty_t : uint8_t {
	BOUNTY_DIFFICULTY_BEGINNER = 0,
	BOUNTY_DIFFICULTY_ADEPT = 1,
	BOUNTY_DIFFICULTY_EXPERT = 2,
	BOUNTY_DIFFICULTY_MASTER = 3,

	BOUNTY_DIFFICULTY_FIRST = BOUNTY_DIFFICULTY_BEGINNER,
	BOUNTY_DIFFICULTY_LAST = BOUNTY_DIFFICULTY_MASTER
};

// Bounty Task state
enum BountyTaskState_t : uint8_t {
	BOUNTY_STATE_NONE = 0,
	BOUNTY_STATE_SELECTION = 1, // Player has 3 tasks to choose from
	BOUNTY_STATE_ACTIVE = 2, // Player is doing a task
	BOUNTY_STATE_COMPLETED = 3 // Player completed a task and can claim
};

// Claim reward type for bounty task offers
enum BountyClaimRewardType_t : uint8_t {
	BOUNTY_CLAIM_SELECT_TASK = 0, // Task can be selected
	BOUNTY_CLAIM_REWARD_NO_CLICK = 1, // Claim reward button (not clickable)
	BOUNTY_CLAIM_REWARD_CLICKED = 2 // Claim reward button (clickable)
};

// Task grade (quality) for bounty task offers
enum BountyTaskGrade_t : uint8_t {
	BOUNTY_GRADE_NORMAL = 0,
	BOUNTY_GRADE_SILVER = 1, // 2x rewards
	BOUNTY_GRADE_GOLD = 2 // 4x rewards
};

// Reroll mode for bounty tasks (claim daily reroll button state)
enum BountyRerollMode_t : uint8_t {
	BOUNTY_REROLL_DAILY_CLAIMABLE = 0, // Daily reroll available (timer expired, button clickable)
	BOUNTY_REROLL_TIMER_RUNNING = 1, // Timer running (button disabled, shows countdown)
	BOUNTY_REROLL_LIMIT_REACHED = 2 // Max tokens reached (button disabled)
};

// Talisman path indices
enum BountyTalismanPath_t : uint8_t {
	BOUNTY_TALISMAN_DAMAGE = 0,
	BOUNTY_TALISMAN_LIFELEECH = 1,
	BOUNTY_TALISMAN_LOOT = 2,
	BOUNTY_TALISMAN_BESTIARY = 3
};

static constexpr uint8_t TALISMAN_PATH_COUNT = 4;
static constexpr uint8_t BOUNTY_MAX_CREATURES = 3;
static constexpr uint8_t BOUNTY_MAX_LIST_SLOTS = 5;
static constexpr uint8_t BOUNTY_MAX_REROLL_TASKS = 10;

// Talisman tier data as sent in protocol
struct BountyTalismanTier {
	uint8_t multiplier1 = 0; // Current bonus percentage (protocol: level sent to client)
	uint8_t multiplier2 = 0; // Additional bonus percentage (protocol: unused, always 0)
	uint8_t isActivedUpgrade = 0; // Whether upgrade button is active (clickable)
	uint16_t bountyPointsToUpgrade = 0; // Cost in bounty points for next upgrade

	// Internal tracking
	uint8_t level = 0; // Current upgrade level
	uint32_t bonusHundredths = 0; // Cached bonus in hundredths of percent (e.g. 250 = 2.50%)
};

// Bounty list slot (preferred/unwanted monster filters)
struct BountyListSlot {
	uint8_t activedList = 0; // 0 = locked, 1 = unlocked
	uint16_t preferredRaceId = 0;
	uint16_t unwantedRaceId = 0;
};

// Single creature entry in the bounty creature list
struct BountyCreatureEntry {
	uint16_t raceId = 0;
	uint16_t requiredKills = 0;
	uint32_t rewardExp = 0;
	uint8_t rewardBountyPoints = 0;
	uint16_t currentKills = 0;
	BountyClaimRewardType_t claimRewardType = BOUNTY_CLAIM_SELECT_TASK;
	BountyTaskGrade_t taskGrade = BOUNTY_GRADE_NORMAL;
	uint8_t taskIndex = 0; // Position in the creature list (0-2)
};

// Active bounty task (currently being hunted)
struct BountyTaskActive {
	uint16_t raceId = 0;
	uint16_t requiredKills = 0;
	uint16_t currentKills = 0;
	uint32_t rewardExp = 0;
	uint8_t rewardBountyPoints = 0;
	BountyTaskGrade_t taskGrade = BOUNTY_GRADE_NORMAL;
	BountyTaskDifficulty_t difficulty = BOUNTY_DIFFICULTY_BEGINNER;
	uint8_t taskIndex = 0; // Original creature list index when selected
};

// Player's complete bounty task data
class BountyTaskData {
public:
	BountyTaskData() = default;
	~BountyTaskData() = default;

	BountyTaskState_t state = BOUNTY_STATE_NONE;
	BountyTaskDifficulty_t selectedDifficulty = BOUNTY_DIFFICULTY_BEGINNER;

	// Current creatures list (up to 3 entries)
	std::vector<BountyCreatureEntry> currentCreaturesList;

	// Active task (only one at a time)
	BountyTaskActive activeTask;

	// Talisman paths (4 paths)
	BountyTalismanTier talismanTiers[TALISMAN_PATH_COUNT];

	// Preferred lists (preferred/unwanted monster filters, up to 5 slots)
	std::vector<BountyListSlot> preferredLists;

	// Bounty points balance
	uint32_t bountyPoints = 0;

	// Reroll info
	uint8_t rerollTasks = 0;

	// Free reroll / daily claim timestamp (24hr cooldown)
	int64_t freeRerollTimeStamp = 0;
};

class IOBountyTasks {
public:
	IOBountyTasks() = default;

	// non-copyable
	IOBountyTasks(const IOBountyTasks &) = delete;
	void operator=(const IOBountyTasks &) = delete;

	static IOBountyTasks &getInstance();

	// Generate random creature list based on difficulty and player level
	void generateCreatureList(const std::shared_ptr<Player> &player, BountyTaskDifficulty_t difficulty);

	// Fill missing creatures if currentCreaturesList has fewer than BOUNTY_MAX_CREATURES
	void fillMissingCreatures(const std::shared_ptr<Player> &player);

	// Player selects a task from the creature list
	void selectTask(const std::shared_ptr<Player> &player, uint8_t taskIndex);

	// Player changes difficulty
	void changeDifficulty(const std::shared_ptr<Player> &player, BountyTaskDifficulty_t difficulty);

	// Player requests a reroll of the creature list
	void rerollCreatureList(const std::shared_ptr<Player> &player);

	// Claim daily reroll tokens
	void claimDailyReroll(const std::shared_ptr<Player> &player);

	// Set preferred monster
	void setPreferredMonster(const std::shared_ptr<Player> &player, uint8_t listType, uint8_t slot, uint16_t raceId);

	// Set unwanted monster
	void setUnwantedMonster(const std::shared_ptr<Player> &player, uint8_t listType, uint8_t slot, uint16_t raceId);

	// Called when a player kills a creature - updates bounty task progress
	void onCreatureKill(const std::shared_ptr<Player> &player, uint16_t raceId);

	// Claim completed task reward
	void claimTaskReward(const std::shared_ptr<Player> &player);

	// Upgrade talisman path with bounty points (pathIndex: 0-3)
	void upgradeTalisman(const std::shared_ptr<Player> &player, uint8_t pathIndex);

	// Initialize default list slots for a player
	void initializeListSlots(BountyTaskData &bountyData);

	// Unlock a list slot with bounty points
	void unlockListSlot(const std::shared_ptr<Player> &player, uint8_t slot);

	// Get kill requirements for difficulty and creature bestiary stars
	uint16_t getRequiredKills(BountyTaskDifficulty_t difficulty, uint8_t bestiaryStars) const;

	// Get exp reward for difficulty and creature
	uint32_t getExpReward(BountyTaskDifficulty_t difficulty, uint32_t creatureExp) const;

	// Get bounty points reward for difficulty
	uint8_t getBountyPointsReward(BountyTaskDifficulty_t difficulty) const;

	// Get talisman upgrade cost for the next level
	static uint16_t getTalismanUpgradeCost(uint8_t currentLevel);

	// Recalculate talisman protocol values from level (called on load and upgrade)
	static void recalculateTalismanBonuses(BountyTalismanTier &tier, uint8_t pathIndex);

	// Calculate actual talisman bonus in hundredths of percent from level and path
	// Paths 0-2: Level 1=2.5%, then +0.5%/level until 15% (L26), then +0.25%/level until 50% (L166)
	// Path 3:    +1%/level until 20% (L20), then +0.5%/level until 100% (L180)
	static uint32_t getTalismanBonusHundredths(uint8_t level, uint8_t pathIndex);

	// Get talisman bonus for a specific path if the creature matches the active bounty task
	// Returns bonus in hundredths of a percent (e.g. 250 = 2.50%, 1500 = 15.00%)
	// Returns 0 if no active task, creature doesn't match, or talisman path has no bonus
	uint16_t getBountyTalismanBonus(const std::shared_ptr<Player> &player, uint16_t raceId, uint8_t pathIndex) const;
};

constexpr auto g_iobountytasks = IOBountyTasks::getInstance;
