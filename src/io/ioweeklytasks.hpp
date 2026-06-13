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

// Task Board packet option (second byte of 0x5B packet)
enum TaskBoardOption_t : uint8_t {
	TASK_BOARD_BOUNTY = 0, // Bounty task
	TASK_BOARD_WEEKLY = 1, // Weekly task
	TASK_BOARD_HUNT_SHOP = 2 // Hunt task shop
};

// Kill task counts: specific creature tasks (NOT counting "any creature" which is always present)
// Total kill displayed in client = 1 (any creature) + WEEKLY_KILL_TASKS_xxx = 6 normal / 9 expansion
static constexpr uint8_t WEEKLY_KILL_TASKS_NORMAL = 5;
static constexpr uint8_t WEEKLY_KILL_TASKS_EXPANSION = 8;

// Delivery task counts (no "any creature" equivalent, so these are the actual totals)
static constexpr uint8_t WEEKLY_DELIVERY_TASKS_NORMAL = 6;
static constexpr uint8_t WEEKLY_DELIVERY_TASKS_EXPANSION = 9;

// Delivery item definition (loaded from Lua)
struct DeliveryItemDef {
	uint16_t itemId = 0;
	uint16_t count = 0;
};

// Weekly kill task entry
struct WeeklyKillTask {
	uint16_t raceId = 0;
	uint16_t totalKills = 0;
	uint16_t currentKills = 0;
};

// Weekly delivery task entry
struct WeeklyDeliveryTask {
	uint8_t index = 0;
	uint16_t itemId = 0;
	uint8_t unknown1 = 0;
	uint8_t unknown2 = 0;
	uint32_t totalItems = 0;
	uint32_t collectedItems = 0;
	uint8_t delivered = 0; // 0 = not delivered, 1 = delivered
};

// Hunting Task Shop offer types
enum HuntingTaskShopOfferType_t : uint8_t {
	HUNTING_SHOP_OFFER_ITEM = 0,
	HUNTING_SHOP_OFFER_MOUNT = 1,
	HUNTING_SHOP_OFFER_OUTFIT = 2,
	HUNTING_SHOP_OFFER_ITEM_DOUBLE = 3,
	HUNTING_SHOP_OFFER_BONUS_PROMOTION = 4,
	HUNTING_SHOP_OFFER_WEEKLY_EXPANSION = 5
};

// Hunting Task Shop offer status (buttonBuyMode sent to client)
// 0 = BUY button, no tooltip, clickable when HTP >= price (client checks automatically)
// 1 = BUY button, tooltip "Not Available", not clickable
// 2 = BUY button, tooltip "You don't have enough hunting task points", not clickable
// 3 = BUY button, tooltip "Requires base outfit", not clickable
// 4 = BOUGHT button (already purchased)
enum HuntingTaskShopOfferStatus_t : uint8_t {
	HUNTING_SHOP_STATUS_AVAILABLE = 0, // BUY, clickable if HTP >= price
	HUNTING_SHOP_STATUS_NOT_AVAILABLE = 1, // BUY, "Not Available"
	HUNTING_SHOP_STATUS_NOT_ENOUGH_HTP = 2, // BUY, "You don't have enough hunting task points"
	HUNTING_SHOP_STATUS_REQUIRES_OUTFIT = 3, // BUY, "Requires base outfit"
	HUNTING_SHOP_STATUS_BOUGHT = 4 // BOUGHT
};

// Single shop offer
struct HuntingTaskShopOffer {
	HuntingTaskShopOfferType_t offerType = HUNTING_SHOP_OFFER_ITEM;
	std::string name;
	std::string description;
	uint32_t looktypeOrItemId = 0;
	uint8_t addon = 0; // Only for outfits (type 2)
	uint32_t itemId2 = 0; // Only for item double (type 3)
	uint32_t price = 0; // In hunting task points
};

// Weekly task difficulty multiplier (protocol value sent to client)
// Controls the HTP per kill task shown in the client UI
// 0 = 25 HTP/kill, 1 = 50 HTP/kill, 2 = 100 HTP/kill, 3 = 110 HTP/kill
enum WeeklyDifficultyMultiplier_t : uint8_t {
	DIFFICULTY_MULTIPLIER_BEGINNER = 0, // 25 HTP per kill task
	DIFFICULTY_MULTIPLIER_ADEPT = 1, // 50 HTP per kill task
	DIFFICULTY_MULTIPLIER_EXPERT = 2, // 100 HTP per kill task
	DIFFICULTY_MULTIPLIER_MASTER = 3, // 110 HTP per kill task
};

// Player's complete weekly task data
class WeeklyTaskData {
public:
	WeeklyTaskData() = default;
	~WeeklyTaskData() = default;

	// "Any creature" global kill counter
	uint16_t anyCreatureTotalKills = 0;
	uint16_t anyCreatureCurrentKills = 0;

	// Specific creature kill tasks
	std::vector<WeeklyKillTask> killTasks;

	// Delivery tasks
	std::vector<WeeklyDeliveryTask> deliveryTasks;

	// Difficulty multiplier (0-3, maps to difficulty level for HTP per kill task)
	uint8_t difficultyMultiplier = 0;

	// Reward experience per task
	uint32_t killTaskRewardExp = 0;
	uint32_t deliveryTaskRewardExp = 0;

	// Completed task counters
	uint8_t completedKillTasks = 0;
	uint8_t completedDeliveryTasks = 0;

	// Weekly progress finished flag (0 = not finished, 1 = finished)
	uint8_t weeklyProgressFinished = 0;

	// Reward values displayed in client
	uint32_t rewardHuntingTasksPoints = 0;
	uint32_t rewardSoulseals = 0;

	// Chosen difficulty for the week (0=beginner, 1=adept, 2=expert, 3=master)
	uint8_t weeklyDifficulty = 0;

	// Soulseals points earned this week
	uint32_t soulsealsPoints = 0;

	// Flag set by server save on reset day — indicates this player needs reward distribution on next login
	bool needsRewardDistribution = false;

	// Throttle for item notification sends (prevents burst sends during looting)
	int64_t lastItemNotifySend = 0;
};

class IOWeeklyTasks {
public:
	IOWeeklyTasks() = default;

	// non-copyable
	IOWeeklyTasks(const IOWeeklyTasks &) = delete;
	void operator=(const IOWeeklyTasks &) = delete;

	static IOWeeklyTasks &getInstance();

	// Initialize weekly tasks for a player (called when opening weekly tasks tab)
	void initializeWeeklyTasks(const std::shared_ptr<Player> &player);

	// Check and distribute weekly rewards on player login
	// Only processes if the player had active tasks and the global reset period has passed
	void checkWeeklyRewardsOnLogin(const std::shared_ptr<Player> &player);

	// Generate new weekly tasks (called on weekly reset)
	void generateWeeklyTasks(const std::shared_ptr<Player> &player, uint8_t difficulty);

	// Called when a player kills a creature
	void onCreatureKill(const std::shared_ptr<Player> &player, uint16_t raceId);

	// Called when a player clicks "deliver" for a delivery task
	// Collects items from inventory, depot, and stash
	void deliverWeeklyTask(const std::shared_ptr<Player> &player, uint8_t taskIndex);

	// Check if it's time for a weekly reset
	bool shouldResetWeekly() const;

	// Perform weekly reset for a player
	void performWeeklyReset(const std::shared_ptr<Player> &player);

	// Reset weekly task data to empty state with weeklyProgressFinished = 1
	// Used when weekly period expires - player must choose difficulty again
	void resetWeeklyTaskData(const std::shared_ptr<Player> &player);

	// Claim weekly rewards (soulseals, hunting task points)
	void claimWeeklyRewards(const std::shared_ptr<Player> &player);

	// Distribute weekly rewards at Monday server save (HTP + soulseals)
	void distributeWeeklyRewards(const std::shared_ptr<Player> &player);

	// Get HTP per kill task based on difficulty
	// Beginner: 25, Adept: 50, Expert: 100, Master: 110
	static uint32_t getHTPPerKillTask(uint8_t difficulty);

	// Get HTP multiplier based on total completed tasks
	// 4+ tasks = 2x, 8+ = 3x, 12+ = 5x, 16+ = 8x
	static uint8_t getHTPMultiplier(uint8_t completedTasks);

	// Get the hunting task shop offers
	const std::vector<HuntingTaskShopOffer> &getShopOffers() const;

	// Buy from the hunting task shop
	void buyShopOffer(const std::shared_ptr<Player> &player, uint8_t offerIndex);

	// Initialize shop offers (called at server start)
	void initializeShopOffers();

	// Initialize delivery items from Lua (called at server start)
	void initializeDeliveryItems();

	// Initialize the global weekly reset timestamp (called at server start)
	void initializeResetTimestamp();

	// Check and mark players for weekly reward distribution on server startup
	// If today is the configured reset day, marks all players with active tasks in the DB
	void checkWeeklyResetOnStartup();

	// Get the global weekly reset timestamp (for client countdown display)
	uint32_t getResetTimestamp() const;

	// Get next weekly reset timestamp (based on configured day of week)
	static uint32_t getNextResetTimestamp();

	// Mark all players in DB for reward distribution (called during SS on reset day)
	// Sets needs_reward = 1 for all players who have active tasks
	static void markAllPlayersForRewardDistribution();

	// Count items in depot chests (all depots, excluding inbox)
	static uint32_t getDepotItemCount(const std::shared_ptr<Player> &player, uint16_t itemId);

	// Recalculate weekly task XP rewards (called when player levels up)
	void recalculateWeeklyTaskRewards(const std::shared_ptr<Player> &player);

	// Recalculate HTP and soulseals reward values (called when a task is completed)
	void recalculateWeeklyRewardValues(const std::shared_ptr<Player> &player);

	// Get "any creature" kill count for a given difficulty
	static uint16_t getAnyCreatureKillCount(uint8_t difficulty);

	// Get XP cap based on difficulty
	static uint32_t getExpCap(uint8_t difficulty);

	// Get minimum level required for a difficulty
	static uint32_t getMinLevelForDifficulty(uint8_t difficulty);

	// Get the highest unlocked difficulty for a given player level (0-3)
	static uint8_t getUnlockedDifficulty(uint32_t playerLevel);

	// Ensure kill/delivery task vectors have the exact expected count,
	// generating missing entries on the fly if needed (called before sending packet)
	void ensureWeeklyTaskCount(const std::shared_ptr<Player> &player);

	// Get dynamic shop offer status for a player (checks if already owned)
	uint8_t getPlayerOfferStatus(const std::shared_ptr<Player> &player, const HuntingTaskShopOffer &offer) const;

private:
	std::vector<HuntingTaskShopOffer> shopOffers;
	std::vector<DeliveryItemDef> deliveryItems;
	uint32_t globalResetTimestamp = 0;

	// Helper to calculate kill count for specific creature tasks
	uint16_t getTaskKillCount(uint32_t playerLevel, uint8_t difficulty) const;

	// Helper to calculate reward exp (~1995 * level, capped by difficulty)
	uint32_t calculateRewardExp(uint32_t playerLevel, uint8_t difficulty) const;

	// Helper to remove items from depot chests
	static uint32_t removeDepotItems(const std::shared_ptr<Player> &player, uint16_t itemId, uint32_t amount);
};

constexpr auto g_ioweeklytasks = IOWeeklyTasks::getInstance;
