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

#include "server/server_definitions.hpp"

class OutputMessage;
using OutputMessage_ptr = std::shared_ptr<OutputMessage>;
class Connection;
using Connection_ptr = std::shared_ptr<Connection>;
using ConnectionWeak_ptr = std::weak_ptr<Connection>;

class NetworkMessage;

class Protocol : public std::enable_shared_from_this<Protocol> {
public:
	explicit Protocol(const Connection_ptr &initConnection);

	virtual ~Protocol() = default;

	// non-copyable
	Protocol(const Protocol &) = delete;
	Protocol &operator=(const Protocol &) = delete;

	virtual void parsePacket(NetworkMessage &) { }

	virtual void onSendMessage(const OutputMessage_ptr &msg);
	bool onRecvMessage(NetworkMessage &msg);
	bool sendRecvMessageCallback(NetworkMessage &msg);
	virtual void onRecvFirstMessage(NetworkMessage &msg) = 0;
	virtual void onConnect() { }

	bool isConnectionExpired() const;

	Connection_ptr getConnection() const;

	uint32_t getIP() const;

	// Use this function for autosend messages only
	OutputMessage_ptr getOutputBuffer(int32_t size);

	OutputMessage_ptr &getCurrentBuffer() {
		return outputBuffer;
	}

	void send(OutputMessage_ptr msg) const;

protected:
	void disconnect() const;

	void enableXTEAEncryption() {
		encryptionEnabled = true;
	}
	void setXTEAKey(const uint32_t* newKey) {
		std::ranges::copy(newKey, newKey + 4, this->key.begin());
	}

	void setChecksumMethod(ChecksumMethods_t method) {
		checksumMethod = method;
	}

	static bool RSA_decrypt(NetworkMessage &msg);

	void setRawMessages(bool value) {
		rawMessages = value;
	}

	virtual void release() { }

private:
	struct ZStream {
		ZStream() noexcept;

		~ZStream() {
			deflateEnd(stream.get());
		}

		std::unique_ptr<z_stream> stream;
		std::array<char, NETWORKMESSAGE_MAXSIZE> buffer {};
	};

	void XTEA_transform(uint8_t* buffer, size_t messageLength, bool encrypt) const;
	void XTEA_encrypt(OutputMessage &msg) const;
	bool XTEA_decrypt(NetworkMessage &msg) const;
	bool compression(OutputMessage &msg) const;

	OutputMessage_ptr outputBuffer;

	const ConnectionWeak_ptr connectionPtr;
	std::array<uint32_t, 4> key = {};
	uint32_t serverSequenceNumber = 0;
	uint32_t clientSequenceNumber = 0;
	std::underlying_type_t<ChecksumMethods_t> checksumMethod = CHECKSUM_METHOD_NONE;
	bool encryptionEnabled = false;
	bool rawMessages = false;

	friend class Connection;
};
