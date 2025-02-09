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

class Storages {
public:
	Storages() = default;

	// Singleton - ensures we don't accidentally copy it
	Storages(const Storages &) = delete;
	void operator=(const Storages &) = delete;

	static Storages &getInstance();

	bool loadFromXML();

	const std::map<std::string, uint32_t> &getStorageMap() const;

private:
	std::map<std::string, uint32_t> m_storageMap;
};

constexpr auto g_storages = Storages::getInstance;
