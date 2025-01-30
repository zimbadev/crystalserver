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

class PropWriteStream;
class DBInsert;

class IOLoginDataSave : public IOLoginData {
public:
	static bool savePlayerFirst(const std::shared_ptr<Player> &player);
	static bool savePlayerStash(const std::shared_ptr<Player> &player);
	static bool savePlayerSpells(const std::shared_ptr<Player> &player);
	static bool savePlayerKills(const std::shared_ptr<Player> &player);
	static bool savePlayerBestiarySystem(const std::shared_ptr<Player> &player);
	static bool savePlayerItem(const std::shared_ptr<Player> &player);
	static bool savePlayerDepotItems(const std::shared_ptr<Player> &player);
	static bool saveRewardItems(const std::shared_ptr<Player> &player);
	static bool savePlayerInbox(const std::shared_ptr<Player> &player);
	static bool savePlayerPreyClass(const std::shared_ptr<Player> &player);
	static bool savePlayerTaskHuntingClass(const std::shared_ptr<Player> &player);
	static bool savePlayerForgeHistory(const std::shared_ptr<Player> &player);
	static bool savePlayerBosstiary(const std::shared_ptr<Player> &player);
	static bool savePlayerStorage(const std::shared_ptr<Player> &player);
	static bool savePlayerStatement(const std::shared_ptr<Player> &player, const std::string &receiver, uint16_t channelId, const std::string &text, uint32_t &statementId);
	static bool savePlayerNamesAndChangeName(const std::shared_ptr<Player> &player, const std::string &newName, const std::string &oldName);

protected:
	using ItemBlockList = std::list<std::pair<int32_t, std::shared_ptr<Item>>>;
	using ItemDepotList = std::list<std::pair<int32_t, std::shared_ptr<Item>>>;
	using ItemRewardList = std::list<std::pair<int32_t, std::shared_ptr<Item>>>;
	using ItemInboxList = std::list<std::pair<int32_t, std::shared_ptr<Item>>>;

	static bool saveItems(const std::shared_ptr<Player> &player, const ItemBlockList &itemList, DBInsert &query_insert, PropWriteStream &stream);
};
