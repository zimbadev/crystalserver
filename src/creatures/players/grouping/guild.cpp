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

#include "creatures/players/grouping/guild.hpp"

#include "game/game.hpp"

void Guild::addMember(const std::shared_ptr<Player> &player) {
	membersOnline.emplace_back(player);
	for (const auto &member : getMembersOnline()) {
		g_game().updatePlayerHelpers(member);
	}
}

void Guild::removeMember(const std::shared_ptr<Player> &player) {
	// loop over to udpate all members and delete the player from the list
	membersOnline.remove(player);
	for (const auto &member : membersOnline) {
		g_game().updatePlayerHelpers(member);
	}

	g_game().updatePlayerHelpers(player);
	if (membersOnline.empty()) {
		g_game().removeGuild(id);
	}
}

GuildRank_ptr Guild::getRankById(uint32_t rankId) const {
	for (const auto &rank : ranks) {
		if (rank->id == rankId) {
			return rank;
		}
	}
	return nullptr;
}

GuildRank_ptr Guild::getRankByName(const std::string &guildName) const {
	for (const auto &rank : ranks) {
		if (rank->name == guildName) {
			return rank;
		}
	}
	return nullptr;
}

GuildRank_ptr Guild::getRankByLevel(uint8_t level) const {
	for (const auto &rank : ranks) {
		if (rank->level == level) {
			return rank;
		}
	}
	return nullptr;
}

void Guild::addRank(uint32_t rankId, const std::string &rankName, uint8_t level) {
	ranks.emplace_back(std::make_shared<GuildRank>(rankId, rankName, level));
}
