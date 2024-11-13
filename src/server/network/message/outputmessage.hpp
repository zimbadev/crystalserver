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
#include "server/network/connection/connection.hpp"

class Protocol;

class OutputMessage : public NetworkMessage {
public:
	OutputMessage() = default;

	// non-copyable
	OutputMessage(const OutputMessage &) = delete;
	OutputMessage &operator=(const OutputMessage &) = delete;

	uint8_t* getOutputBuffer() {
		return buffer.data() + outputBufferStart;
	}

	void writeMessageLength() {
		add_header(info.length);
	}

	void addCryptoHeader(bool addChecksum, uint32_t checksum) {
		if (addChecksum) {
			add_header(checksum);
		}

		writeMessageLength();
	}

	void append(const NetworkMessage &msg) {
		auto msgLen = msg.getLength();
		std::span<const unsigned char> sourceSpan(msg.getBuffer() + INITIAL_BUFFER_POSITION, msgLen);
		std::span<unsigned char> destSpan(buffer.data() + info.position, msgLen);
		std::ranges::copy(sourceSpan, destSpan.begin());
		info.length += msgLen;
		info.position += msgLen;
	}

	void append(const OutputMessage_ptr &msg) {
		auto msgLen = msg->getLength();
		std::span<const unsigned char> sourceSpan(msg->getBuffer() + INITIAL_BUFFER_POSITION, msgLen);
		std::span<unsigned char> destSpan(buffer.data() + info.position, msgLen);
		std::ranges::copy(sourceSpan, destSpan.begin());
		info.length += msgLen;
		info.position += msgLen;
	}

private:
	template <typename T>
	void add_header(T addHeader) {
		if (outputBufferStart < sizeof(T)) {
			g_logger().error("[{}]: Insufficient buffer space for header!", __FUNCTION__);
			return;
		}

		// Ensure at runtime that outputBufferStart >= sizeof(T)
		assert(outputBufferStart >= sizeof(T));
		// Move the buffer position back to make space for the header
		outputBufferStart -= sizeof(T);

		static_assert(std::is_trivially_copyable_v<T>, "Type T must be trivially copyable");

		// Convert the header to an array of unsigned char using std::bit_cast
		auto byteArray = std::bit_cast<std::array<unsigned char, sizeof(T)>>(addHeader);

		std::span<const unsigned char> byteSpan(byteArray);
		// Copy the bytes into the buffer
		std::ranges::copy(byteSpan, buffer.begin() + outputBufferStart);
		// Update the message size
		info.length += sizeof(T);
	}

	MsgSize_t outputBufferStart = INITIAL_BUFFER_POSITION;
};

class OutputMessagePool {
public:
	OutputMessagePool() = default;

	// non-copyable
	OutputMessagePool(const OutputMessagePool &) = delete;
	OutputMessagePool &operator=(const OutputMessagePool &) = delete;

	static OutputMessagePool &getInstance();

	void sendAll();
	void scheduleSendAll();

	static OutputMessage_ptr getOutputMessage();

	void addProtocolToAutosend(const Protocol_ptr &protocol);
	void removeProtocolFromAutosend(const Protocol_ptr &protocol);

private:
	// NOTE: A vector is used here because this container is mostly read
	// and relatively rarely modified (only when a client connects/disconnects)
	std::vector<Protocol_ptr> bufferedProtocols;
};
