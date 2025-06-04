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
#include "creatures/creatures_definitions.hpp"

struct Mount {
	Mount(uint8_t initId, uint16_t initClientId, std::string initName, int32_t initSpeed, bool initPremium, std::string initType) :
		name(std::move(initName)), type(std::move(initType)), clientId(initClientId), id(initId), premium(initPremium),
		speed(initSpeed) {
		std::memset(skills, 0, sizeof(skills));
		std::memset(stats, 0, sizeof(stats));
	}

	std::string name = "";
	std::string type = "";

	uint16_t clientId = 0;
	uint8_t id = 0;

	bool premium = false;
	bool regeneration = false;
	bool manaShield = false;
	bool invisible = false;

	int32_t speed = 0;
	int32_t attackSpeed = 0;
	int32_t healthGain = 0;
	int32_t healthTicks = 0;
	int32_t manaGain = 0;
	int32_t manaTicks = 0;

	double lifeLeechChance = 0;
	double lifeLeechAmount = 0;
	double manaLeechChance = 0;
	double manaLeechAmount = 0;
	double criticalChance = 0;
	double criticalDamage = 0;

	int32_t skills[SKILL_LAST + 1] = { 0 };
	int32_t stats[STAT_LAST + 1] = { 0 };
};

class Mounts {
public:
	bool reload();
	bool loadFromXml();

	std::shared_ptr<Mount> getMountByID(uint8_t id);
	std::shared_ptr<Mount> getMountByName(const std::string &name);
	std::shared_ptr<Mount> getMountByClientID(uint16_t clientId);

	bool addAttributes(uint32_t playerId, uint8_t mountId);
	bool removeAttributes(uint32_t playerId, uint8_t mountId);

	[[nodiscard]] const phmap::parallel_flat_hash_set<std::shared_ptr<Mount>> &getMounts() const {
		return mounts;
	}

private:
	phmap::parallel_flat_hash_set<std::shared_ptr<Mount>> mounts;
};
