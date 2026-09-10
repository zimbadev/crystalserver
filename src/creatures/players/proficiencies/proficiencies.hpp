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
#include "creatures/players/proficiencies/proficiencies_definitions.hpp"

class Player;
class Item;
class ItemType;

struct ProficiencyPerk {
	ProficiencyPerk(uint8_t positionSlot, WeaponProficiencyPerkType_t id, float value) :
		positionSlot(positionSlot), perkType(id), perkValue(value) { }

	uint8_t positionSlot;
	WeaponProficiencyPerkType_t perkType;
	float perkValue;

	int8_t skillId = 0;
	uint8_t augmentType = 0;
	uint16_t spellId = 0;
	uint8_t bestiaryId = 0;
	int32_t damageType = 0;
	uint8_t range = 0;
	// Type 32 (PROFICIENCY_PERK_ON_HIT_HOMING_MISSILE): on weapon hit, roll `probability`; on success fire a
	// homing missile (`missileId` shoot effect) dealing `multiplier` * playerLevel damage of the combat type
	// derived from `damageType` (parsed from ElementId).
	uint16_t missileId = 0;
	float multiplier = 0.0f;
	float probability = 0.0f;
	// std::string bestiaryName = "";
};

struct ProficiencyLevelStruct {
	ProficiencyLevelStruct(uint8_t level, uint8_t maxPerks) :
		proficiencyLevel(level), maxProficiencyPerks(maxPerks) { }

	uint8_t proficiencyLevel;
	uint8_t maxProficiencyPerks;
	std::vector<ProficiencyPerk> proficiencyDataPerks;
};

struct WeaponProficiencyStruct {
	WeaponProficiencyStruct() :
		proficiencyId(0), maxProficiencyLevel(0) { }
	WeaponProficiencyStruct(uint32_t id, uint8_t maxLevel) :
		proficiencyId(id), maxProficiencyLevel(maxLevel) { }

	uint32_t proficiencyId;
	uint8_t maxProficiencyLevel;
	std::vector<ProficiencyLevelStruct> proficiencyDataLevel;
};

// One decoded entry of the 15.30 SHAPE catalogue (see WEAPON_PROFICIENCY_SHAPE_* in proficiencies_definitions.hpp).
struct WeaponProficiencyShapeEntry {
	bool valid = false;
	WeaponProficiencyPerkType_t perkType = PROFICIENCY_PERK_ATTACK_DAMAGE;
	WeaponProficiencyPerkAugmentType_t augmentType = PROFICIENCY_AUGMENTTYPE_NONE;
	uint16_t spellId = 0; // client spell id (augment entries)
	uint8_t bestiaryId = 0; // bestiary entries
	uint8_t region = WEAPON_PROFICIENCY_SHAPE_NO_REGION; // vocation region of augment entries, else NO_REGION
	float rank0 = 0.0f; // magnitude at rank 0 (fractions for percentages, whole points for on-hit/on-kill gains)
	float perRank = 0.0f; // magnitude added per rank; the client computes rank0 + perRank * rank

	float valueAtRank(uint8_t rank) const {
		if (rank > WEAPON_PROFICIENCY_SHAPE_MAX_RANK) {
			rank = WEAPON_PROFICIENCY_SHAPE_MAX_RANK;
		}
		return rank0 + perRank * static_cast<float>(rank);
	}
};

class Proficiencies {
public:
	Proficiencies() = default;

	// non-copyable
	Proficiencies(const Proficiencies &) = delete;
	Proficiencies &operator=(const Proficiencies &) = delete;

	static Proficiencies &getInstance();

	bool loadFromJson(bool reloading = false);
	bool reload();
	const WeaponProficiencyStruct* getProficiencyByItemId(uint16_t itemId) const;
	uint8_t getMaxProficiencyLevelForItem(uint16_t itemId) const;
	uint8_t getMaxPerksPerProficiencyLevelForItem(uint16_t itemId, uint8_t level) const;

	// 15.30 SHAPE catalogue helpers (pure functions over the constant tables, mirror the official client).
	// cipVocation = Vocation_t client id (1 knight, 2 paladin, 3 sorcerer, 4 druid, 5 monk; promotions already folded).
	static uint8_t getShapeRegionForVocation(uint16_t cipVocation);
	static std::vector<uint16_t> getShapeableIndicesForVocation(uint16_t cipVocation);
	static bool isShapeIndexAllowedForVocation(uint16_t index, uint16_t cipVocation);
	static WeaponProficiencyShapeEntry decodeShapeIndex(uint16_t index);

protected:
	bool loaded = false;

private:
	std::unordered_map<uint32_t, WeaponProficiencyStruct> proficienciesMap; // proficiencyId - WeaponProficiencyStruct
};

constexpr auto g_proficiencies = Proficiencies::getInstance;
