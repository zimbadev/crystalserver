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

#include "creatures/players/proficiencies/proficiencies.hpp"
#include "creatures/players/proficiencies/proficiencies_definitions.hpp"

#include "config/configmanager.hpp"
#include "creatures/players/player.hpp"
#include "lib/di/container.hpp"
#include "utils/pugicast.hpp"
#include <utils/tools.hpp>
#include "items/item.hpp"

#include <nlohmann/json.hpp>

using json = nlohmann::json;

Proficiencies &Proficiencies::getInstance() {
	return inject<Proficiencies>();
}

bool Proficiencies::loadFromJson(bool /* reloading */) {
	const auto &jsonFile = g_configManager().getString(CORE_DIRECTORY) + "/json/proficiencies.json";
	std::ifstream ifs(jsonFile);
	if (!ifs.is_open()) {
		g_logger().error("[Proficiencies] Failed to open {}", jsonFile);
		return false;
	}

	json proficiencyJson;
	ifs >> proficiencyJson;

	loaded = true;
	proficienciesMap.clear();

	for (const auto &entry : proficiencyJson) {
		const uint32_t proficiencyId = entry.at("ProficiencyId").get<uint32_t>();
		const uint8_t maxLevel = entry.at("Levels").size();
		WeaponProficiencyStruct proficiencyStruct(proficiencyId, maxLevel);

		const auto &levels = entry.at("Levels");
		uint8_t levelIndex = 1;
		for (const auto &levelObj : levels) {
			const uint8_t maxPerks = levelObj.at("Perks").size();
			ProficiencyLevelStruct levelStruct(levelIndex, maxPerks);

			const auto &perksArray = levelObj.at("Perks");
			for (size_t perkIdx = 0; perkIdx < perksArray.size(); ++perkIdx) {
				const auto &perkJson = perksArray[perkIdx];
				const uint8_t positionSlot = static_cast<uint8_t>(perkIdx + 1);
				const WeaponProficiencyPerkType_t perkType = static_cast<WeaponProficiencyPerkType_t>(perkJson.at("Type").get<uint16_t>());
				// Some perks carry no "Value" (e.g. the on-hit elemental proc, Type 32, which uses
				// ElementId/MissileId/Multiplier/Probability instead). Default to 0 so they still load.
				const float perkValue = perkJson.value("Value", 0.0f);

				ProficiencyPerk perk(positionSlot, perkType, perkValue);

				if (perkJson.contains("SkillId")) {
					perk.skillId = perkJson.at("SkillId").get<int8_t>();
				}

				if (perkJson.contains("ElementId")) {
					perk.damageType = perkJson.at("ElementId").get<int32_t>();
				}

				if (perkJson.contains("Range")) {
					perk.range = perkJson.at("Range").get<uint8_t>();
				}

				if (perkJson.contains("AugmentType")) {
					perk.augmentType = perkJson.at("AugmentType").get<uint8_t>();
				}

				if (perkJson.contains("SpellId")) {
					perk.spellId = perkJson.at("SpellId").get<uint16_t>();
				}

				if (perkJson.contains("BestiaryId")) {
					perk.bestiaryId = perkJson.at("BestiaryId").get<uint8_t>();
				}

				// if (perkJson.contains("BestiaryName")) {
				// perk.bestiaryName = perkJson.at("BestiaryName").get<std::string>();
				//}

				if (perkJson.contains("DamageType")) {
					perk.damageType = perkJson.at("DamageType").get<int32_t>();
				}

				// Type 32 (PROFICIENCY_PERK_ON_HIT_HOMING_MISSILE) fields.
				if (perkJson.contains("MissileId")) {
					perk.missileId = perkJson.at("MissileId").get<uint16_t>();
				}

				if (perkJson.contains("Multiplier")) {
					perk.multiplier = perkJson.value("Multiplier", 0.0f);
				}

				if (perkJson.contains("Probability")) {
					perk.probability = perkJson.value("Probability", 0.0f);
				}

				levelStruct.proficiencyDataPerks.emplace_back(std::move(perk));
			}

			proficiencyStruct.proficiencyDataLevel.emplace_back(std::move(levelStruct));
			++levelIndex;
		}

		if (proficienciesMap.count(proficiencyId)) {
			g_logger().warn("[Proficiencies] proficiencyId {} duplicate in the json!", proficiencyId);
		}

		proficienciesMap[proficiencyId] = std::move(proficiencyStruct);
	}

	return true;
}

bool Proficiencies::reload() {
	proficienciesMap.clear();
	loaded = false;
	return loadFromJson(true);
}

const WeaponProficiencyStruct* Proficiencies::getProficiencyByItemId(uint16_t itemId) const {
	const ItemType &itemType = Item::items[itemId];
	if (!itemType.proficiencyId) {
		g_logger().error("[{}] itemId {} not found proficiencyId", __FUNCTION__, itemId);
		return nullptr;
	}

	auto it = proficienciesMap.find(itemType.proficiencyId);
	if (it == proficienciesMap.end()) {
		g_logger().error("[{}] Proficiency ID {} not found", __FUNCTION__, itemType.proficiencyId);
		return nullptr;
	}
	return &it->second;
}

uint8_t Proficiencies::getMaxProficiencyLevelForItem(uint16_t itemId) const {
	const ItemType &itemType = Item::items[itemId];
	if (!itemType.proficiencyId) {
		g_logger().error("[{}] itemId {} not found proficiencyId", __FUNCTION__, itemId);
		return 0;
	}

	const auto* proficiency = getProficiencyByItemId(itemType.proficiencyId);
	if (!proficiency) {
		return 0;
	}

	return proficiency->maxProficiencyLevel;
}

uint8_t Proficiencies::getMaxPerksPerProficiencyLevelForItem(uint16_t itemId, uint8_t level) const {
	const ItemType &itemType = Item::items[itemId];
	if (!itemType.proficiencyId) {
		g_logger().error("[{}] itemId {} not found proficiencyId", __FUNCTION__, itemId);
		return 0;
	}

	const auto* proficiency = getProficiencyByItemId(itemType.proficiencyId);
	if (!proficiency) {
		return 0;
	}

	for (const auto &data : proficiency->proficiencyDataLevel) {
		if (data.proficiencyLevel == level) {
			return data.maxProficiencyPerks;
		}
	}
	return 0;
}

// ---------------------------------------------------------------------------------------------------------------------
// 15.30 SHAPE catalogue helpers. Pure functions over WEAPON_PROFICIENCY_SHAPE_* that mirror the official client:
// the index decoder (client FUN_140ef6410), the per-vocation option arrays and the rank curves (client FUN_140ef7de0).

uint8_t Proficiencies::getShapeRegionForVocation(uint16_t cipVocation) {
	switch (cipVocation) {
		case Vocation_t::VOCATION_KNIGHT_CIP:
			return 0;
		case Vocation_t::VOCATION_PALADIN_CIP:
			return 1;
		case Vocation_t::VOCATION_SORCERER_CIP:
			return 2;
		case Vocation_t::VOCATION_DRUID_CIP:
			return 3;
		case Vocation_t::VOCATION_MONK_CIP:
			return 4;
		default:
			return WEAPON_PROFICIENCY_SHAPE_NO_REGION;
	}
}

std::vector<uint16_t> Proficiencies::getShapeableIndicesForVocation(uint16_t cipVocation) {
	// Same content and order as the client's 64-entry option array: the 34 GENERAL entries followed by the vocation's
	// 30 spell augments (row by row). A player without vocation only gets the GENERAL block.
	std::vector<uint16_t> indices(std::begin(WEAPON_PROFICIENCY_SHAPE_GENERAL), std::end(WEAPON_PROFICIENCY_SHAPE_GENERAL));
	const uint8_t region = getShapeRegionForVocation(cipVocation);
	if (region == WEAPON_PROFICIENCY_SHAPE_NO_REGION) {
		return indices;
	}
	const uint16_t regionBase = static_cast<uint16_t>(region * WEAPON_PROFICIENCY_SHAPE_REGION_SIZE);
	for (uint8_t row = 0; row < WEAPON_PROFICIENCY_SHAPE_AUGMENT_ROWS; ++row) {
		for (uint8_t column = 0; column < WEAPON_PROFICIENCY_SHAPE_SPELLS_PER_REGION; ++column) {
			indices.push_back(static_cast<uint16_t>(regionBase + row * 10 + column + 1));
		}
	}
	return indices;
}

bool Proficiencies::isShapeIndexAllowedForVocation(uint16_t index, uint16_t cipVocation) {
	const auto entry = decodeShapeIndex(index);
	if (!entry.valid) {
		return false;
	}
	if (entry.region == WEAPON_PROFICIENCY_SHAPE_NO_REGION) {
		return true; // GENERAL block: offered to every vocation
	}
	return entry.region == getShapeRegionForVocation(cipVocation);
}

WeaponProficiencyShapeEntry Proficiencies::decodeShapeIndex(uint16_t index) {
	WeaponProficiencyShapeEntry entry;
	if (index == 0 || index > WEAPON_PROFICIENCY_SHAPE_MAX_INDEX) {
		return entry;
	}
	const auto setCurve = [&entry](WeaponProficiencyPerkType_t perkType, float rank0, float perRank) {
		entry.valid = true;
		entry.perkType = perkType;
		entry.rank0 = rank0;
		entry.perRank = perRank;
	};

	// 1-250: vocation regions of 50, rows of 10 = augment kind, columns 1-6 = the vocation's shapeable spells.
	if (index <= WEAPON_PROFICIENCY_SHAPE_REGION_SIZE * WEAPON_PROFICIENCY_SHAPE_REGION_COUNT) {
		const uint16_t zeroBased = index - 1;
		const auto region = static_cast<uint8_t>(zeroBased / WEAPON_PROFICIENCY_SHAPE_REGION_SIZE);
		const auto offset = static_cast<uint8_t>(zeroBased % WEAPON_PROFICIENCY_SHAPE_REGION_SIZE);
		const auto row = static_cast<uint8_t>(offset / 10);
		const auto column = static_cast<uint8_t>(offset % 10);
		if (row >= WEAPON_PROFICIENCY_SHAPE_AUGMENT_ROWS || column >= WEAPON_PROFICIENCY_SHAPE_SPELLS_PER_REGION) {
			return entry; // columns 7-10 of a row are unused by the client
		}
		entry.region = region;
		entry.augmentType = WEAPON_PROFICIENCY_SHAPE_AUGMENT_ROW_TYPES[row];
		entry.spellId = WEAPON_PROFICIENCY_SHAPE_SPELLS[region][column];
		switch (entry.augmentType) {
			case PROFICIENCY_AUGMENTTYPE_CRITICAL_HIT_CHANCE:
			case PROFICIENCY_AUGMENTTYPE_BASE_DAMAGE:
				setCurve(PROFICIENCY_PERK_AUGMENT_TYPE, 0.01f, 0.002f); // 1% -> 3%
				break;
			case PROFICIENCY_AUGMENTTYPE_CRITICAL_EXTRA_DAMAGE:
				setCurve(PROFICIENCY_PERK_AUGMENT_TYPE, 0.05f, 0.015f); // 5% -> 20%
				break;
			case PROFICIENCY_AUGMENTTYPE_MANA_LEECH:
				setCurve(PROFICIENCY_PERK_AUGMENT_TYPE, 0.01f, 0.005f); // 1% -> 6%
				break;
			case PROFICIENCY_AUGMENTTYPE_LIFE_LEECH:
				setCurve(PROFICIENCY_PERK_AUGMENT_TYPE, 0.01f, 0.011f); // 1% -> 12%
				break;
			default:
				break;
		}
		return entry;
	}

	// 251-271: bestiary damage against one creature class.
	if (index >= 251 && index <= 271) {
		entry.bestiaryId = static_cast<uint8_t>(index - 250);
		setCurve(PROFICIENCY_PERK_BESTIARY_DAMAGE, 0.005f, 0.002f); // 0.5% -> 2.5%
		return entry;
	}

	switch (index) {
		case 281:
			setCurve(PROFICIENCY_PERK_CRITICAL_HIT_CHANCE_FOR_OFFENSIVE_RUNES, 0.005f, 0.001f); // 0.5% -> 1.5%
			break;
		case 282:
			setCurve(PROFICIENCY_PERK_CRITICAL_HIT_CHANCE_FOR_AUTOATTACK, 0.005f, 0.002f); // 0.5% -> 2.5%
			break;
		case 283:
			setCurve(PROFICIENCY_PERK_CRITICAL_EXTRA_DAMAGE_FOR_OFFENSIVE_RUNES, 0.02f, 0.013f); // 2% -> 15%
			break;
		case 284:
			setCurve(PROFICIENCY_PERK_CRITICAL_EXTRA_DAMAGE_FOR_AUTOATTACK, 0.03f, 0.017f); // 3% -> 20%
			break;
		case 285:
			setCurve(PROFICIENCY_PERK_LIFE_GAIN_ONHIT, 2.0f, 1.0f); // +2 -> +12 hit points
			break;
		case 286:
			setCurve(PROFICIENCY_PERK_MANA_GAIN_ONKILL, 4.0f, 2.0f); // +4 -> +24 mana
			break;
		case 287:
			setCurve(PROFICIENCY_PERK_LIFE_GAIN_ONKILL, 10.0f, 4.0f); // +10 -> +50 hit points
			break;
		case 291:
			setCurve(PROFICIENCY_PERK_HIGHEST_COMBAT_SKILL_PERCENTAGE_AS_EXTRA_DAMAGE_FOR_AUTOATTACK, 0.02f, 0.008f); // 2% -> 10%
			break;
		case 292:
			setCurve(PROFICIENCY_PERK_HIGHEST_COMBAT_SKILL_PERCENTAGE_AS_EXTRA_DAMAGE_FOR_SPELLS, 0.01f, 0.007f); // 1% -> 8%
			break;
		case 293:
			setCurve(PROFICIENCY_PERK_HIGHEST_COMBAT_SKILL_PERCENTAGE_AS_EXTRA_HEALING_FOR_SPELLS, 0.02f, 0.008f); // 2% -> 10%
			break;
		case 321:
			setCurve(PROFICIENCY_PERK_ALPHA_STRIKE_EXTRA_DAMAGE, 0.02f, 0.008f); // 2% -> 10%
			break;
		case 322:
			setCurve(PROFICIENCY_PERK_OMEGA_STRIKE_EXTRA_DAMAGE, 0.005f, 0.002f); // 0.5% -> 2.5%
			break;
		case 323:
			setCurve(PROFICIENCY_PERK_ARMOR_PENETRATION, 0.04f, 0.006f); // 4% -> 10%
			break;
		default:
			break; // every other index (272-280, 288-290, 294-320) is a hole the client renders as unknown
	}
	return entry;
}
