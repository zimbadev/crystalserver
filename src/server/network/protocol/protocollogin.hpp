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

#include "server/network/protocol/protocol.hpp"

class NetworkMessage;
class OutputMessage;

class ProtocolLogin final : public Protocol {
public:
	// static protocol information
	enum { SERVER_SENDS_FIRST = false };
	enum { PROTOCOL_IDENTIFIER = 0x01 };
	enum { USE_CHECKSUM = true };
	static const char* protocol_name() {
		return "login protocol";
	}

	explicit ProtocolLogin(const Connection_ptr &loginConnection) :
		Protocol(loginConnection) { }

	void onRecvFirstMessage(NetworkMessage &msg) override;

private:
	void disconnectClient(const std::string &message) const;

	void getCharacterList(const std::string &accountDescriptor, const std::string &password) const;

	bool oldProtocol = false;
};
