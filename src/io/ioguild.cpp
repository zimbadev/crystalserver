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

#include "io/ioguild.hpp"

#include "database/database.hpp"
#include "creatures/players/grouping/guild.hpp"

std::shared_ptr<Guild> IOGuild::loadGuild(uint32_t guildId) {
	Database &db = Database::getInstance();
	std::ostringstream query;
	query << "SELECT `name`, `balance` FROM `guilds` WHERE `id` = " << guildId;
	if (DBResult_ptr result = db.storeQuery(query.str())) {
		const auto guild = std::make_shared<Guild>(guildId, result->getString("name"));
		guild->setBankBalance(result->getNumber<uint64_t>("balance"));
		query.str(std::string());
		query << "SELECT `id`, `name`, `level` FROM `guild_ranks` WHERE `guild_id` = " << guildId;

		if ((result = db.storeQuery(query.str()))) {
			do {
				guild->addRank(result->getNumber<uint32_t>("id"), result->getString("name"), result->getNumber<uint16_t>("level"));
			} while (result->next());
		}
		return guild;
	}
	return nullptr;
}

void IOGuild::saveGuild(const std::shared_ptr<Guild> &guild) {
	if (!guild) {
		return;
	}
	Database &db = Database::getInstance();
	std::ostringstream updateQuery;
	updateQuery << "UPDATE `guilds` SET ";
	updateQuery << "`balance` = " << guild->getBankBalance();
	updateQuery << " WHERE `id` = " << guild->getId();
	db.executeQuery(updateQuery.str());
}

uint32_t IOGuild::getGuildIdByName(const std::string &name) {
	Database &db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `id` FROM `guilds` WHERE `name` = " << db.escapeString(name);

	DBResult_ptr result = db.storeQuery(query.str());
	if (!result) {
		return 0;
	}
	return result->getNumber<uint32_t>("id");
}

void IOGuild::getWarList(uint32_t guildId, GuildWarVector &guildWarVector) {
	std::ostringstream query;
	query << "SELECT `guild1`, `guild2` FROM `guild_wars` WHERE (`guild1` = " << guildId << " OR `guild2` = " << guildId << ") AND `status` = 1";

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return;
	}

	do {
		auto guild1 = result->getNumber<uint32_t>("guild1");
		if (guildId != guild1) {
			guildWarVector.push_back(guild1);
		} else {
			guildWarVector.push_back(result->getNumber<uint32_t>("guild2"));
		}
	} while (result->next());
}

bool IOGuild::setMotd(uint32_t guildId, std::string newMotd) {
	Database &db = Database::getInstance();
	std::ostringstream query;
	query << "UPDATE `guilds` SET `motd` = " << db.escapeString(newMotd) << " WHERE `id` = " << guildId;
	return db.executeQuery(query.str());
}

std::string IOGuild::getMotd(uint32_t guildId) {
	std::ostringstream query;
	query << "SELECT `motd` FROM `guilds` WHERE `id` = " << guildId;
	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return "";
	}

	return result->getString("motd");
}

bool IOGuild::disbandGuild(uint32_t guildId) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "DELETE FROM `guild_membership` WHERE `guild_id` = " << guildId;
	if (!db.executeQuery(query1.str())) {
		return false;
	}

	std::ostringstream query2;
	query2 << "DELETE FROM `guild_ranks` WHERE `guild_id` = " << guildId;
	if (!db.executeQuery(query2.str())) {
		return false;
	}

	std::ostringstream query3;
	query3 << "DELETE FROM `guild_invites` WHERE `guild_id` = " << guildId;
	db.executeQuery(query3.str());

	std::ostringstream query4;
	query4 << "DELETE FROM `guilds` WHERE `id` = " << guildId;
	return db.executeQuery(query4.str());
}

bool IOGuild::invitePlayerToGuild(uint32_t guildId, const std::string &playerName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName);
	DBResult_ptr result = db.storeQuery(query1.str());
	if (!result) {
		return false;
	}

	uint32_t playerId = result->getNumber<uint32_t>("id");
	std::ostringstream query2;
	query2 << "SELECT `guild_id` FROM `guild_membership` WHERE `player_id` = " << playerId;
	DBResult_ptr membershipResult = db.storeQuery(query2.str());
	if (membershipResult) {
		return false;
	}

	std::ostringstream query3;
	query3 << "SELECT `player_id` FROM `guild_invites` WHERE `player_id` = " << playerId << " AND `guild_id` = " << guildId;
	DBResult_ptr inviteResult = db.storeQuery(query3.str());
	if (inviteResult) {
		return false;
	}

	std::ostringstream query4;
	query4 << "INSERT INTO `guild_invites` (`player_id`, `guild_id`, `date`) VALUES (" << playerId << ", " << guildId << ", " << time(nullptr) << ")";
	return db.executeQuery(query4.str());
}

bool IOGuild::removePlayerFromGuild(uint32_t guildId, const std::string &playerName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName);
	DBResult_ptr result = db.storeQuery(query1.str());
	if (!result) {
		return false;
	}

	uint32_t playerId = result->getNumber<uint32_t>("id");
	std::ostringstream query2;
	query2 << "DELETE FROM `guild_membership` WHERE `player_id` = " << playerId << " AND `guild_id` = " << guildId;
	return db.executeQuery(query2.str());
}

bool IOGuild::promotePlayer(uint32_t guildId, const std::string &playerName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `rank_id` FROM `guild_membership` WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName) << ") AND `guild_id` = " << guildId;
	DBResult_ptr result = db.storeQuery(query1.str());
	if (!result) {
		return false;
	}

	uint32_t currentRankId = result->getNumber<uint32_t>("rank_id");
	std::ostringstream query2;
	query2 << "SELECT `level` FROM `guild_ranks` WHERE `id` = " << currentRankId;
	DBResult_ptr rankResult = db.storeQuery(query2.str());
	if (!rankResult) {
		return false;
	}

	uint8_t currentLevel = rankResult->getNumber<uint8_t>("level");
	std::ostringstream query3;
	query3 << "SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " << guildId << " AND `level` = " << (currentLevel + 1) << " LIMIT 1";
	DBResult_ptr nextRankResult = db.storeQuery(query3.str());
	if (!nextRankResult) {
		return false;
	}

	uint32_t nextRankId = nextRankResult->getNumber<uint32_t>("id");
	std::ostringstream query4;
	query4 << "UPDATE `guild_membership` SET `rank_id` = " << nextRankId << " WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName) << ") AND `guild_id` = " << guildId;
	return db.executeQuery(query4.str());
}

bool IOGuild::demotePlayer(uint32_t guildId, const std::string &playerName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `rank_id` FROM `guild_membership` WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName) << ") AND `guild_id` = " << guildId;
	DBResult_ptr result = db.storeQuery(query1.str());
	if (!result) {
		return false;
	}

	uint32_t currentRankId = result->getNumber<uint32_t>("rank_id");
	std::ostringstream query2;
	query2 << "SELECT `level` FROM `guild_ranks` WHERE `id` = " << currentRankId;
	DBResult_ptr rankResult = db.storeQuery(query2.str());
	if (!rankResult) {
		return false;
	}

	uint8_t currentLevel = rankResult->getNumber<uint8_t>("level");
	if (currentLevel <= 1) {
		return false;
	}

	std::ostringstream query3;
	query3 << "SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " << guildId << " AND `level` = " << (currentLevel - 1) << " LIMIT 1";
	DBResult_ptr prevRankResult = db.storeQuery(query3.str());
	if (!prevRankResult) {
		return false;
	}

	uint32_t prevRankId = prevRankResult->getNumber<uint32_t>("id");
	std::ostringstream query4;
	query4 << "UPDATE `guild_membership` SET `rank_id` = " << prevRankId << " WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName) << ") AND `guild_id` = " << guildId;
	return db.executeQuery(query4.str());
}

bool IOGuild::passLeadership(uint32_t guildId, const std::string &newLeaderName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(newLeaderName);
	DBResult_ptr result = db.storeQuery(query1.str());
	if (!result) {
		return false;
	}

	uint32_t newLeaderId = result->getNumber<uint32_t>("id");
	std::ostringstream query2;
	query2 << "SELECT `rank_id` FROM `guild_membership` WHERE `player_id` = " << newLeaderId << " AND `guild_id` = " << guildId;
	result = db.storeQuery(query2.str());
	if (!result) {
		return false;
	}

	uint32_t newLeaderCurrentRankId = result->getNumber<uint32_t>("rank_id");
	std::ostringstream query3;
	query3 << "SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " << guildId << " AND `level` = 3 LIMIT 1";
	result = db.storeQuery(query3.str());
	if (!result) {
		return false;
	}

	uint32_t leaderRankId = result->getNumber<uint32_t>("id");
	std::ostringstream query4;
	query4 << "SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " << guildId << " AND `level` = 2 LIMIT 1";
	result = db.storeQuery(query4.str());
	if (!result) {
		return false;
	}

	uint32_t viceLeaderRankId = result->getNumber<uint32_t>("id");
	std::ostringstream query5;
	query5 << "SELECT `player_id` FROM `guild_membership` WHERE `guild_id` = " << guildId << " AND `rank_id` = " << leaderRankId;
	result = db.storeQuery(query5.str());
	if (!result) {
		return false;
	}

	uint32_t currentLeaderId = result->getNumber<uint32_t>("player_id");
	std::ostringstream query6;
	query6 << "UPDATE `guild_membership` SET `rank_id` = " << viceLeaderRankId << " WHERE `player_id` = " << currentLeaderId << " AND `guild_id` = " << guildId;
	if (!db.executeQuery(query6.str())) {
		return false;
	}

	std::ostringstream query7;
	query7 << "UPDATE `guild_membership` SET `rank_id` = " << leaderRankId << " WHERE `player_id` = " << newLeaderId << " AND `guild_id` = " << guildId;
	if (!db.executeQuery(query7.str())) {
		return false;
	}

	std::ostringstream query8;
	query8 << "UPDATE `guilds` SET `ownerid` = " << newLeaderId << " WHERE `id` = " << guildId;
	if (!db.executeQuery(query8.str())) {
		return false;
	}

	return true;
}

bool IOGuild::setPlayerGuildNick(uint32_t guildId, const std::string &playerName, const std::string &nick) {
	Database &db = Database::getInstance();

	std::ostringstream query;
	query << "UPDATE `guild_membership` SET `nick` = " << db.escapeString(nick) << " WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName) << ") AND `guild_id` = " << guildId;
	return db.executeQuery(query.str());
}

bool IOGuild::setRankName(uint32_t guildId, uint8_t rankLevel, const std::string &newName) {
	Database &db = Database::getInstance();

	std::ostringstream query;
	query << "UPDATE `guild_ranks` SET `name` = " << db.escapeString(newName) << " WHERE `guild_id` = " << guildId << " AND `level` = " << static_cast<uint32_t>(rankLevel);
	return db.executeQuery(query.str());
}

bool IOGuild::clearMotd(uint32_t guildId) {
	Database &db = Database::getInstance();

	std::ostringstream query;
	query << "UPDATE `guilds` SET `motd` = '' WHERE `id` = " << guildId;
	return db.executeQuery(query.str());
}

uint32_t IOGuild::createGuild(const std::string &guildName, const std::string &leaderName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `id` FROM `guilds` WHERE `name` = " << db.escapeString(guildName);
	DBResult_ptr result = db.storeQuery(query1.str());
	if (result) {
		return 0;
	}

	std::ostringstream query2;
	query2 << "SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(leaderName);
	result = db.storeQuery(query2.str());
	if (!result) {
		return 0;
	}

	uint32_t playerId = result->getNumber<uint32_t>("id");
	std::ostringstream query3;
	query3 << "SELECT `guild_id` FROM `guild_membership` WHERE `player_id` = " << playerId;
	result = db.storeQuery(query3.str());
	if (result) {
		return 0;
	}

	std::ostringstream query4;
	query4 << "INSERT INTO `guilds` (`name`, `ownerid`, `creationdata`, `balance`, `motd`) VALUES (" << db.escapeString(guildName) << ", " << playerId << ", " << time(nullptr) << ", 0, '')";
	if (!db.executeQuery(query4.str())) {
		return 0;
	}

	uint32_t guildId = db.getLastInsertId();
	std::ostringstream query5;
	query5 << "INSERT INTO `guild_ranks` (`guild_id`, `name`, `level`) VALUES (" << guildId << ", 'Leader', 3), "
		   << "(" << guildId << ", 'Vice-Leader', 2), "
		   << "(" << guildId << ", 'Member', 1)";
	if (!db.executeQuery(query5.str())) {
		return 0;
	}

	std::ostringstream query6;
	query6 << "SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " << guildId << " AND `level` = 3 LIMIT 1";
	result = db.storeQuery(query6.str());
	if (!result) {
		return 0;
	}

	uint32_t leaderRankId = result->getNumber<uint32_t>("id");
	std::ostringstream query7;
	query7 << "INSERT INTO `guild_membership` (`player_id`, `guild_id`, `rank_id`, `nick`) VALUES (" << playerId << ", " << guildId << ", " << leaderRankId << ", '')";
	if (!db.executeQuery(query7.str())) {
		return 0;
	}

	return guildId;
}

bool IOGuild::joinGuild(const std::string &guildName, const std::string &playerName) {
	Database &db = Database::getInstance();

	std::ostringstream query1;
	query1 << "SELECT `id` FROM `guilds` WHERE `name` = " << db.escapeString(guildName);
	DBResult_ptr result = db.storeQuery(query1.str());
	if (!result) {
		return false;
	}

	uint32_t guildId = result->getNumber<uint32_t>("id");
	std::ostringstream query2;
	query2 << "SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(playerName);
	result = db.storeQuery(query2.str());
	if (!result) {
		return false;
	}

	uint32_t playerId = result->getNumber<uint32_t>("id");
	std::ostringstream query3;
	query3 << "SELECT `guild_id` FROM `guild_membership` WHERE `player_id` = " << playerId;
	result = db.storeQuery(query3.str());
	if (result) {
		return false;
	}

	std::ostringstream query4;
	query4 << "SELECT `player_id` FROM `guild_invites` WHERE `player_id` = " << playerId << " AND `guild_id` = " << guildId;
	result = db.storeQuery(query4.str());
	if (!result) {
		return false;
	}

	std::ostringstream query5;
	query5 << "SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " << guildId << " AND `level` = 1 LIMIT 1";
	result = db.storeQuery(query5.str());
	if (!result) {
		return false;
	}

	uint32_t memberRankId = result->getNumber<uint32_t>("id");
	std::ostringstream query6;
	query6 << "DELETE FROM `guild_invites` WHERE `player_id` = " << playerId << " AND `guild_id` = " << guildId;
	if (!db.executeQuery(query6.str())) {
		return false;
	}

	std::ostringstream query7;
	query7 << "INSERT INTO `guild_membership` (`player_id`, `guild_id`, `rank_id`, `nick`) VALUES (" << playerId << ", " << guildId << ", " << memberRankId << ", '')";
	if (!db.executeQuery(query7.str())) {
		return false;
	}

	return true;
}
