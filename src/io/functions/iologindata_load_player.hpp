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

#include "io/iologindata.hpp"

class Player;
class DBResult;
using DBResult_ptr = std::shared_ptr<DBResult>;

class IOLoginDataLoad : public IOLoginData {
public:
	static bool loadPlayerBasicInfo(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static bool preLoadPlayer(const std::shared_ptr<Player> &player, const std::string &name);
	static void loadPlayerExperience(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerBlessings(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerConditions(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerAnimusMastery(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerDefaultOutfit(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerSkullSystem(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerSkill(const std::shared_ptr<Player> &player, const DBResult_ptr &result);
	static void loadPlayerKills(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerGuild(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerStashItems(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerBestiaryCharms(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerInstantSpellList(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerInventoryItems(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerStoreInbox(const std::shared_ptr<Player> &player);
	static void loadPlayerDepotItems(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadRewardItems(const std::shared_ptr<Player> &player);
	static void loadPlayerInboxItems(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerStorageMap(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerVip(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerPreyClass(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerTaskHuntingClass(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerForgeHistory(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerBosstiary(const std::shared_ptr<Player> &player, DBResult_ptr result);
	static void loadPlayerInitializeSystem(const std::shared_ptr<Player> &player);
	static void loadPlayerUpdateSystem(const std::shared_ptr<Player> &player);

private:
	using ItemsMap = std::map<uint32_t, std::pair<std::shared_ptr<Item>, uint32_t>>;

	static void bindRewardBag(const std::shared_ptr<Player> &player, ItemsMap &rewardItemsMap);
	static void insertItemsIntoRewardBag(const ItemsMap &rewardItemsMap);

	static void loadItems(ItemsMap &itemsMap, const DBResult_ptr &result, const std::shared_ptr<Player> &player);
};
