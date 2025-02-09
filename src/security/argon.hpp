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

class Argon2 {
public:
	Argon2();
	~Argon2() = default;

	void updateConstants();

	// Singleton - ensures we don't accidentally copy it
	Argon2(const Argon2 &) = delete;
	void operator=(const Argon2 &) = delete;

	bool argon(const std::string &password_attempt, const std::string &hashed_password) const;

private:
	uint32_t parseBitShift(const std::string &bitShiftStr) const;
	bool verifyPassword(const std::string &password, const std::string &phash) const;
	static std::vector<uint8_t> base64_decode(const std::string &input);

	static const std::regex re;
	static const std::string base64_chars;
	std::string m_const_str;
	uint32_t m_cost {};
	uint32_t t_cost {};
	uint32_t parallelism {};
};
