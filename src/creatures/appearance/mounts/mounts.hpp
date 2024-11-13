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

struct Mount {
	Mount(uint8_t initId, uint16_t initClientId, std::string initName, int32_t initSpeed, bool initPremium, std::string initType) :
		name(std::move(initName)), speed(initSpeed), clientId(initClientId), id(initId), premium(initPremium),
		type(std::move(initType)) { }

	std::string name;
	int32_t speed;
	uint16_t clientId;
	uint8_t id;
	bool premium;
	std::string type;
};

class Mounts {
public:
	bool reload();
	bool loadFromXml();
	std::shared_ptr<Mount> getMountByID(uint8_t id);
	std::shared_ptr<Mount> getMountByName(const std::string &name);
	std::shared_ptr<Mount> getMountByClientID(uint16_t clientId);

	[[nodiscard]] const phmap::parallel_flat_hash_set<std::shared_ptr<Mount>> &getMounts() const {
		return mounts;
	}

private:
	phmap::parallel_flat_hash_set<std::shared_ptr<Mount>> mounts;
};
