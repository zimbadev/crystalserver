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

#include <cstdint>
#include <map>
#include <memory>
#include <string>
#include <unordered_set>
#include <vector>

class NetworkMessage;
class Player;

// Reward type of a day in dailyrewards.xml
enum DailyRewardType_t : uint8_t {
	DAILY_REWARD_TYPE_ITEM = 1,
	DAILY_REWARD_TYPE_STORAGE = 2,
	DAILY_REWARD_TYPE_PREY_REROLL = 3,
	DAILY_REWARD_TYPE_XP_BOOST = 4,
	DAILY_REWARD_TYPE_COSMETIC_TOKENS = 5,
	DAILY_REWARD_TYPE_BOUNTY_REROLL_TOKENS = 6,
};

// Redeem mode byte of a reward object in the 15.30 layout of S2C 0xE4 (the 15.33 layout has no such byte)
enum DailyRewardSystemType_t : uint8_t {
	DAILY_REWARD_SYSTEM_TYPE_ONE = 1, // pick items from a list (no longer used: the claim is one click)
	DAILY_REWARD_SYSTEM_TYPE_TWO = 2, // fixed list
};

// Kind byte of one entry of a reward object in S2C 0xE4
enum DailyRewardKind_t : uint8_t {
	DAILY_REWARD_KIND_ITEM = 1, // u16 itemId, string name, u8 count
	DAILY_REWARD_KIND_PREY_WILDCARDS = 2, // u8 count
	DAILY_REWARD_KIND_XP_BOOST = 3, // 15.30: u16 minutes; 15.33: u16 minutes, u16 percent
	DAILY_REWARD_KIND_COSMETIC_TOKENS = 4, // 15.33 only: u8 count
	DAILY_REWARD_KIND_BOUNTY_REROLL_TOKENS = 5, // 15.33 only: u8 count
};

enum DailyRewardAccountStatus_t : uint8_t {
	DAILY_REWARD_STATUS_FREE = 0,
	DAILY_REWARD_STATUS_PREMIUM = 1,
};

enum DailyRewardSource_t : uint8_t {
	DAILY_REWARD_FROM_SHRINE = 0,
	DAILY_REWARD_FROM_PANEL = 1,
};

struct DailyRewardStorages {
	uint32_t currentDayStreak = 14897;
	uint32_t nextRewardTime = 14899;
	uint32_t collectionTokens = 14901;
	uint32_t staminaBonus = 14902;
	uint32_t jokerTokens = 14903;
	uint32_t lastServerSave = 14110;
	uint32_t avoidDouble = 13412;
	uint32_t notifyReset = 13413;
	uint32_t avoidDoubleJoker = 13414;
};

struct DailyRewardStrikeBonus {
	uint8_t day = 0;
	std::string text;
};

struct DailyRewardDayConfig {
	uint8_t day = 0;
	DailyRewardType_t type = DAILY_REWARD_TYPE_ITEM;
	// Amount for a free / Premium account: item count, prey wildcards, tokens or XP boost minutes
	uint16_t freeAccount = 0;
	uint16_t premiumAccount = 0;
	// XP boost percent for a free / Premium account
	uint16_t freePercent = 50;
	uint16_t premiumPercent = 50;
	uint16_t itemCharges = 0;
	std::vector<uint16_t> items;
};

// One granted reward of a day, already resolved for the account status
struct DailyRewardEntry {
	DailyRewardKind_t kind = DAILY_REWARD_KIND_ITEM;
	uint16_t itemId = 0; // item
	uint16_t itemCharges = 0; // item
	std::string name; // item
	uint8_t count = 0; // item, prey wildcards, tokens
	uint16_t minutes = 0; // XP boost
	uint16_t percent = 0; // XP boost
};

class DailyRewards {
public:
	static constexpr uint8_t REWARD_COUNT = 7;
	// Streak bonus: every streak day adds one percentage point of chance for double weapon
	// proficiency experience, up to this value
	static constexpr uint8_t MAX_STREAK_BONUS_CHANCE = 7;

	DailyRewards() = default;

	// Singleton - ensures we don't accidentally copy it
	DailyRewards(const DailyRewards &) = delete;
	void operator=(const DailyRewards &) = delete;

	static DailyRewards &getInstance();

	bool loadFromXml(bool reloading = false);
	bool isLoaded() const {
		return loaded;
	}

	bool isShrineItem(uint16_t itemId) const;

	void initPlayer(const std::shared_ptr<Player> &player);
	void stopPlayerBonuses(uint32_t playerId);
	void loadDailyReward(const std::shared_ptr<Player> &player, DailyRewardSource_t source);
	void playerOpenRewardWall(const std::shared_ptr<Player> &player);
	void playerOpenRewardHistory(const std::shared_ptr<Player> &player);
	void playerSelectReward(const std::shared_ptr<Player> &player, NetworkMessage &msg);

	void updateLastServerSave(time_t timestamp) const;
	time_t getLastServerSave() const;

	const DailyRewardStorages &getStorages() const {
		return storages;
	}

	const std::map<uint8_t, DailyRewardDayConfig> &getRewards() const {
		return rewards;
	}

	// Rewards a claim of this day (1..REWARD_COUNT) gives, in the order they are shown.
	// The Reroll Token every claim gives is the last entry.
	std::vector<DailyRewardEntry> getRewardEntries(uint8_t day, bool premium) const;

	// Chance in percent (0..MAX_STREAK_BONUS_CHANCE) for double weapon proficiency experience
	uint8_t getStreakBonusChance(const std::shared_ptr<Player> &player) const;

	const std::map<uint8_t, DailyRewardStrikeBonus> &getStrikeBonuses() const {
		return strikeBonuses;
	}

	bool isTestMode() const {
		return testMode;
	}

	uint32_t getServerTimeThreshold() const {
		return serverTimeThreshold;
	}

private:
	bool isRewardTaken(const std::shared_ptr<Player> &player) const;
	void refreshStreak(const std::shared_ptr<Player> &player) const;
	void pickedReward(const std::shared_ptr<Player> &player);
	void processReward(const std::shared_ptr<Player> &player, DailyRewardSource_t source);
	void loadPlayerBonuses(const std::shared_ptr<Player> &player);
	void insertHistory(uint32_t playerGuid, uint8_t dayStreak, const std::string &description) const;

	uint32_t getCollectionTokens(const std::shared_ptr<Player> &player) const;
	void setCollectionTokens(const std::shared_ptr<Player> &player, int32_t value) const;
	uint32_t getJokerTokens(const std::shared_ptr<Player> &player) const;
	void setJokerTokens(const std::shared_ptr<Player> &player, int32_t value) const;
	uint8_t getDayStreak(const std::shared_ptr<Player> &player) const;
	void setDayStreak(const std::shared_ptr<Player> &player, int32_t value) const;
	uint32_t getNextRewardTime(const std::shared_ptr<Player> &player) const;
	void setNextRewardTime(const std::shared_ptr<Player> &player, int32_t value) const;
	uint32_t getStreakLevel(const std::shared_ptr<Player> &player) const;
	void setStreakLevel(const std::shared_ptr<Player> &player, uint32_t value) const;

	void scheduleStaminaRegen(uint32_t playerId, uint32_t delayMs);
	void scheduleSoulRegen(uint32_t playerId, uint32_t delayMs);

	bool loaded = false;
	bool testMode = false;
	uint32_t serverTimeThreshold = 86400;
	// Bounty Reroll Tokens every claim gives on top of the reward of the day
	uint8_t rerollTokensPerClaim = 1;

	DailyRewardStorages storages;
	std::map<uint8_t, DailyRewardStrikeBonus> strikeBonuses;
	std::map<uint8_t, DailyRewardDayConfig> rewards;
	std::unordered_set<uint16_t> shrineItems;

	std::map<uint32_t, uint64_t> staminaEvents;
	std::map<uint32_t, uint64_t> soulEvents;
	mutable time_t cachedLastServerSave = 0;
};

constexpr auto g_dailyRewards = DailyRewards::getInstance;
