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
	const auto &jsonFile = g_configManager().getString(CORE_DIRECTORY) + "/items/proficiencies.json";
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
				const float perkValue = perkJson.at("Value").get<float>();

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
