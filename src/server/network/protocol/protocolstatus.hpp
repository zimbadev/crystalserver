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

#include "server/network/message/networkmessage.hpp"
#include "server/network/protocol/protocol.hpp"

class ProtocolStatus final : public Protocol {
public:
	// static protocol information
	enum { SERVER_SENDS_FIRST = false };
	enum { PROTOCOL_IDENTIFIER = 0xFF };
	enum { USE_CHECKSUM = false };
	static const char* protocol_name() {
		return "status protocol";
	}

	explicit ProtocolStatus(const Connection_ptr &conn) :
		Protocol(conn) { }

	void onRecvFirstMessage(NetworkMessage &msg) override;

	void sendStatusString();
	void sendInfo(uint16_t requestedInfo, const std::string &characterName) const;

	static const uint64_t start;

private:
	static std::map<uint32_t, int64_t> ipConnectMap;
};
