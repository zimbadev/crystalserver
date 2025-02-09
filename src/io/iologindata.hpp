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

class Player;
class Item;
class DBResult;

struct VIPEntry;
struct VIPGroupEntry;

using ItemBlockList = std::list<std::pair<int32_t, std::shared_ptr<Item>>>;

class IOLoginData {
public:
	static bool gameWorldAuthentication(const std::string &accountDescriptor, const std::string &sessionOrPassword, std::string &characterName, uint32_t &accountId, bool oldProtocol, const uint32_t ip);
	static uint8_t getAccountType(uint32_t accountId);
	static bool loadPlayerById(const std::shared_ptr<Player> &player, uint32_t id, bool disableIrrelevantInfo = true);
	static bool loadPlayerByName(const std::shared_ptr<Player> &player, const std::string &name, bool disableIrrelevantInfo = true);
	static bool loadPlayer(const std::shared_ptr<Player> &player, const std::shared_ptr<DBResult> &result, bool disableIrrelevantInfo = false);
	static bool savePlayer(const std::shared_ptr<Player> &player);
	static uint32_t getGuidByName(const std::string &name);
	static bool getGuidByNameEx(uint32_t &guid, bool &specialVip, std::string &name);
	static std::string getNameByGuid(uint32_t guid);
	static bool formatPlayerName(std::string &name);
	static void increaseBankBalance(uint32_t guid, uint64_t bankBalance);

	static std::vector<VIPEntry> getVIPEntries(uint32_t accountId);
	static void addVIPEntry(uint32_t accountId, uint32_t guid, const std::string &description, uint32_t icon, bool notify);
	static void editVIPEntry(uint32_t accountId, uint32_t guid, const std::string &description, uint32_t icon, bool notify);
	static void removeVIPEntry(uint32_t accountId, uint32_t guid);

	static std::vector<VIPGroupEntry> getVIPGroupEntries(uint32_t accountId, uint32_t guid);
	static void addVIPGroupEntry(uint8_t groupId, uint32_t accountId, const std::string &groupName, bool customizable);
	static void editVIPGroupEntry(uint8_t groupId, uint32_t accountId, const std::string &groupName, bool customizable);
	static void removeVIPGroupEntry(uint8_t groupId, uint32_t accountId);
	static void addGuidVIPGroupEntry(uint8_t groupId, uint32_t accountId, uint32_t guid);
	static void removeGuidVIPGroupEntry(uint32_t accountId, uint32_t guid);

private:
	static bool savePlayerGuard(const std::shared_ptr<Player> &player);
};
