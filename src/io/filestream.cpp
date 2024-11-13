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

#include "io/filestream.hpp"

#include "io/fileloader.hpp"

uint32_t FileStream::tell() const {
	return m_pos;
}

void FileStream::seek(uint32_t pos) {
	if (pos > m_data.size()) {
		g_logger().error("Seek failed");
		return;
	}
	m_pos = pos;
}

void FileStream::skip(uint32_t len) {
	seek(tell() + len);
}

uint32_t FileStream::size() const {
	std::size_t size = m_data.size();
	if (size > std::numeric_limits<uint32_t>::max()) {
		g_logger().error("File size exceeds uint32_t range");
		return {};
	}

	return static_cast<uint32_t>(size);
}

template <typename T>
bool FileStream::read(T &ret, bool escape) {
	static_assert(std::is_trivially_copyable_v<T>, "Type T must be trivially copyable");

	const auto size = sizeof(T);

	if (m_pos + size > m_data.size()) {
		g_logger().error("Read failed");
		return false;
	}

	std::array<uint8_t, sizeof(T)> array;
	if (escape) {
		for (int_fast8_t i = 0; i < size; ++i) {
			if (m_data[m_pos] == OTB::Node::ESCAPE) {
				++m_pos;
			}
			array[i] = m_data[m_pos];
			++m_pos;
		}
	} else {
		std::span<const uint8_t> sourceSpan(m_data.data() + m_pos, size);
		std::ranges::copy(sourceSpan, array.begin());
		m_pos += size;
	}

	ret = std::bit_cast<T>(array);
	return true;
}

uint8_t FileStream::getU8() {
	uint8_t v = 0;

	if (m_pos + 1 > m_data.size()) {
		g_logger().error("Failed to getU8");
		return {};
	}

	// Fast Escape Val
	if (m_nodes > 0 && m_data[m_pos] == OTB::Node::ESCAPE) {
		++m_pos;
	}

	v = m_data[m_pos];
	++m_pos;

	return v;
}

uint16_t FileStream::getU16() {
	uint16_t v = 0;
	read(v, m_nodes > 0);
	return v;
}

uint32_t FileStream::getU32() {
	uint32_t v = 0;
	read(v, m_nodes > 0);
	return v;
}

uint64_t FileStream::getU64() {
	uint64_t v = 0;
	read(v, m_nodes > 0);
	return v;
}

std::string FileStream::getString() {
	std::string str;
	if (const uint16_t len = getU16(); len > 0 && len < 8192) {
		if (m_pos + len > m_data.size()) {
			g_logger().error("[FileStream::getString] - Read failed");
			return {};
		}

		str = { (char*)&m_data[m_pos], len };
		m_pos += len;
	} else if (len != 0) {
		g_logger().error("[FileStream::getString] - Read failed because string is too big");
	}
	return str;
}

void FileStream::back(uint32_t pos) {
	m_pos -= pos;
}

bool FileStream::isProp(uint8_t prop, bool toNext) {
	if (getU8() == prop) {
		if (!toNext) {
			back();
		}
		return true;
	}

	back();
	return false;
}

bool FileStream::startNode(uint8_t type) {
	if (getU8() == OTB::Node::START) {
		if (type == 0 || getU8() == type) {
			++m_nodes;
			return true;
		}

		back();
	}

	back();
	return false;
}

bool FileStream::endNode() {
	if (getU8() == OTB::Node::END) {
		--m_nodes;
		return true;
	}

	back();
	return false;
}
