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

struct BanInfo {
	std::string bannedBy {};
	std::string reason {};
	time_t expiresAt {};
};

struct ConnectBlock {
	constexpr ConnectBlock(uint64_t lastAttempt, uint64_t blockTime, uint32_t count) :
		lastAttempt(lastAttempt), blockTime(blockTime), count(count) { }

	uint64_t lastAttempt {};
	uint64_t blockTime {};
	uint32_t count {};
};

using IpConnectMap = std::map<uint32_t, ConnectBlock>;

class Ban {
public:
	bool acceptConnection(uint32_t clientIP);

private:
	IpConnectMap ipConnectMap;
	std::recursive_mutex lock;
};

class IOBan {
public:
	static bool isAccountBanned(uint32_t accountId, BanInfo &banInfo);
	static bool isIpBanned(uint32_t clientIP, BanInfo &banInfo);
	static bool isPlayerNamelocked(uint32_t playerId);
};
