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

class FileStream {
public:
	FileStream(const char* begin, const char* end) {
		m_data.insert(m_data.end(), begin, end);
	}

	explicit FileStream(mio::mmap_source source) {
		m_data.insert(m_data.end(), source.begin(), source.end());
	}

	void back(uint32_t pos = 1);
	void seek(uint32_t pos);
	void skip(uint32_t len);
	uint32_t size() const;
	uint32_t tell() const;

	bool startNode(uint8_t type = 0);
	bool endNode();
	bool isProp(uint8_t prop, bool toNext = true);

	uint8_t getU8();
	uint16_t getU16();
	uint32_t getU32();
	uint64_t getU64();
	std::string getString();

private:
	template <typename T>
	bool read(T &ret, bool escape = false);
	uint32_t m_nodes { 0 };
	uint32_t m_pos { 0 };

	std::vector<uint8_t> m_data;
};
