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

#include "game/bank/bank.hpp"

class Player;

struct GuildRank {
	uint32_t id;
	std::string name;
	uint8_t level;

	GuildRank(uint32_t initId, std::string initName, uint8_t initLevel) :
		id(initId), name(std::move(initName)), level(initLevel) { }
};

using GuildRank_ptr = std::shared_ptr<GuildRank>;

class Guild final : public Bankable {
public:
	Guild(uint32_t initId, std::string initName) :
		name(std::move(initName)), id(initId) { }

	void addMember(const std::shared_ptr<Player> &player);
	void removeMember(const std::shared_ptr<Player> &player);

	bool isGuild() override {
		return true;
	}

	void setOnline(bool value) override {
		online = value;
	}
	bool isOnline() const override {
		return online;
	}

	uint32_t getId() const {
		return id;
	}
	const std::string &getName() const {
		return name;
	}
	std::list<std::shared_ptr<Player>> getMembersOnline() const {
		return membersOnline;
	}
	uint32_t getMemberCountOnline() const {
		return membersOnline.size();
	}
	uint32_t getMemberCount() const {
		return memberCount;
	}
	void setMemberCount(uint32_t count) {
		memberCount = count;
	}
	uint64_t getBankBalance() const override {
		return bankBalance;
	}
	void setBankBalance(uint64_t balance) override {
		bankBalance = balance;
	}

	const std::vector<GuildRank_ptr> &getRanks() const {
		return ranks;
	}

	GuildRank_ptr getRankById(uint32_t id) const;
	GuildRank_ptr getRankByName(const std::string &name) const;
	GuildRank_ptr getRankByLevel(uint8_t level) const;
	void addRank(uint32_t id, const std::string &name, uint8_t level);

	const std::string &getMotd() const {
		return motd;
	}
	void setMotd(const std::string &newMotd) {
		this->motd = newMotd;
	}

private:
	std::list<std::shared_ptr<Player>> membersOnline;
	std::vector<GuildRank_ptr> ranks;
	std::string name;
	uint64_t bankBalance = 0;
	std::string motd;
	uint32_t id;
	uint32_t memberCount = 0;
	bool online = true;
};
