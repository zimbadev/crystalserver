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

struct WaitListInfo;

struct Wait {
	constexpr Wait(std::size_t initTimeout, uint32_t initPlayerGUID) :
		timeout(initTimeout), playerGUID(initPlayerGUID) { }

	std::size_t timeout;
	uint32_t playerGUID;
};

using WaitList = std::list<Wait>;

struct WaitListInfo {
	WaitList priorityWaitList;
	WaitList waitList;

	phmap::flat_hash_map<uint32_t, std::pair<WaitList::iterator, std::size_t>> playerReferences;
};

class WaitingList {
public:
	WaitingList();
	static WaitingList &getInstance();
	bool clientLogin(const std::shared_ptr<Player> &player) const;
	std::size_t getClientSlot(const std::shared_ptr<Player> &player) const;
	static std::size_t getTime(std::size_t slot);

private:
	void cleanupList(WaitList &list) const;
	std::size_t getTimeout(std::size_t slot) const;
	void addPlayerToList(const std::shared_ptr<Player> &player) const;
	std::unique_ptr<WaitListInfo> info;
};
