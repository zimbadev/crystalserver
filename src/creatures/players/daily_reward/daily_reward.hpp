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
#include <string>
#include <unordered_set>
#include <vector>

class NetworkMessage;
class Player;

enum DailyRewardType_t : uint8_t {
	DAILY_REWARD_TYPE_ITEM = 1,
	DAILY_REWARD_TYPE_STORAGE = 2,
	DAILY_REWARD_TYPE_PREY_REROLL = 3,
	DAILY_REWARD_TYPE_XP_BOOST = 4,
};

enum DailyRewardSystemType_t : uint8_t {
	DAILY_REWARD_SYSTEM_TYPE_ONE = 1,
	DAILY_REWARD_SYSTEM_TYPE_TWO = 2,
};

enum DailyRewardSystemSubType_t : uint8_t {
	DAILY_REWARD_SYSTEM_SKIP = 1,
	DAILY_REWARD_SYSTEM_TYPE_PREY_REROLL = 2,
	DAILY_REWARD_SYSTEM_TYPE_XP_BOOST = 3,
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
	DailyRewardSystemType_t systemType = DAILY_REWARD_SYSTEM_TYPE_ONE;
	uint16_t freeAccount = 0;
	uint16_t premiumAccount = 0;
	uint16_t itemCharges = 0;
	std::vector<uint16_t> items;
};

class DailyRewards {
public:
	static constexpr uint8_t REWARD_COUNT = 7;

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

	const std::map<uint8_t, std::vector<uint16_t>> &getVocationItems() const {
		return vocationItems;
	}

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

	DailyRewardStorages storages;
	std::map<uint8_t, DailyRewardStrikeBonus> strikeBonuses;
	std::map<uint8_t, DailyRewardDayConfig> rewards;
	std::map<uint8_t, std::vector<uint16_t>> vocationItems;
	std::unordered_set<uint16_t> shrineItems;

	std::map<std::string, std::vector<uint16_t>> itemGroups;

	std::map<uint32_t, uint64_t> staminaEvents;
	std::map<uint32_t, uint64_t> soulEvents;
	mutable time_t cachedLastServerSave = 0;
};

constexpr auto g_dailyRewards = DailyRewards::getInstance;
