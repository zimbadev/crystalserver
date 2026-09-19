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

class Guild;
using GuildWarVector = std::vector<uint32_t>;

class IOGuild {
public:
	static std::shared_ptr<Guild> loadGuild(uint32_t guildId);
	static void saveGuild(const std::shared_ptr<Guild> &guild);
	static uint32_t getGuildIdByName(const std::string &name);
	static void getWarList(uint32_t guildId, GuildWarVector &guildWarVector);

	static bool setMotd(uint32_t guildId, std::string newMotd);
	static std::string getMotd(uint32_t guildId);

	// Guild management functions
	static bool disbandGuild(uint32_t guildId);
	static bool invitePlayerToGuild(uint32_t guildId, const std::string &playerName);
	static bool removePlayerFromGuild(uint32_t guildId, const std::string &playerName);
	static bool promotePlayer(uint32_t guildId, const std::string &playerName);
	static bool demotePlayer(uint32_t guildId, const std::string &playerName);
	static bool passLeadership(uint32_t guildId, const std::string &newLeaderName);
	static bool setPlayerGuildNick(uint32_t guildId, const std::string &playerName, const std::string &nick);
	static bool setRankName(uint32_t guildId, uint8_t rankLevel, const std::string &newName);
	static bool clearMotd(uint32_t guildId);
	static uint32_t createGuild(const std::string &guildName, const std::string &leaderName);
	static bool joinGuild(const std::string &guildName, const std::string &playerName);
};
