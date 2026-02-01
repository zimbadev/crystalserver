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

#include "creatures/appearance/mounts/mounts.hpp"
#include "creatures/combat/condition.hpp"
#include "creatures/creatures_definitions.hpp"
#include "config/configmanager.hpp"
#include "creatures/players/player.hpp"
#include "game/game.hpp"
#include "utils/pugicast.hpp"
#include "utils/tools.hpp"

bool Mounts::reload() {
	mounts.clear();
	return loadFromXml();
}

bool Mounts::loadFromXml() {
	pugi::xml_document doc;
	auto folder = g_configManager().getString(CORE_DIRECTORY) + "/XML/mounts.xml";
	pugi::xml_parse_result result = doc.load_file(folder.c_str());
	if (!result) {
		printXMLError(__FUNCTION__, folder, result);
		return false;
	}

	for (auto mountNode : doc.child("mounts").children()) {
		auto lookType = pugi::cast<uint16_t>(mountNode.attribute("clientid").value());
		if (g_configManager().getBoolean(WARN_UNSAFE_SCRIPTS) && lookType != 0 && !g_game().isLookTypeRegistered(lookType)) {
			g_logger().warn("{} - An unregistered creature mount with id '{}' was blocked to prevent client crash.", __FUNCTION__, lookType);
			continue;
		}

		auto mount = std::make_shared<Mount>(
			static_cast<uint16_t>(pugi::cast<uint16_t>(mountNode.attribute("id").value())),
			lookType,
			mountNode.attribute("name").as_string(),
			pugi::cast<int32_t>(mountNode.attribute("speed").value()),
			mountNode.attribute("premium").as_bool(),
			mountNode.attribute("type").as_string()
		);

		mount->manaShield = mountNode.attribute("manashield").as_bool() || mountNode.attribute("manaShield").as_bool();
		mount->invisible = mountNode.attribute("invisible").as_bool();
		mount->attackSpeed = mountNode.attribute("attackSpeed").as_int() || mountNode.attribute("attackspeed").as_int();

		if (auto healthGainAttr = mountNode.attribute("healthGain")) {
			mount->healthGain = healthGainAttr.as_int();
			mount->regeneration = true;
		}

		if (auto healthTicksAttr = mountNode.attribute("healthTicks")) {
			mount->healthTicks = healthTicksAttr.as_int();
			mount->regeneration = true;
		}

		if (auto manaGainAttr = mountNode.attribute("manaGain")) {
			mount->manaGain = manaGainAttr.as_int();
			mount->regeneration = true;
		}

		if (auto manaTicksAttr = mountNode.attribute("manaTicks")) {
			mount->manaTicks = manaTicksAttr.as_int();
			mount->regeneration = true;
		}

		if (auto skillsNode = mountNode.child("skills")) {
			for (auto skillNode : skillsNode.children()) {
				std::string skillName = skillNode.name();
				int32_t skillValue = skillNode.attribute("value").as_int();

				if (skillName == "fist") {
					mount->skills[SKILL_FIST] += skillValue;
				} else if (skillName == "club") {
					mount->skills[SKILL_CLUB] += skillValue;
				} else if (skillName == "axe") {
					mount->skills[SKILL_AXE] += skillValue;
				} else if (skillName == "sword") {
					mount->skills[SKILL_SWORD] += skillValue;
				} else if (skillName == "distance" || skillName == "dist") {
					mount->skills[SKILL_DISTANCE] += skillValue;
				} else if (skillName == "shielding" || skillName == "shield") {
					mount->skills[SKILL_SHIELD] = skillValue;
				} else if (skillName == "fishing" || skillName == "fish") {
					mount->skills[SKILL_FISHING] += skillValue;
				} else if (skillName == "melee") {
					mount->skills[SKILL_FIST] += skillValue;
					mount->skills[SKILL_CLUB] += skillValue;
					mount->skills[SKILL_SWORD] += skillValue;
					mount->skills[SKILL_AXE] += skillValue;
				} else if (skillName == "weapon" || skillName == "weapons") {
					mount->skills[SKILL_CLUB] += skillValue;
					mount->skills[SKILL_SWORD] += skillValue;
					mount->skills[SKILL_AXE] += skillValue;
					mount->skills[SKILL_DISTANCE] += skillValue;
				}
			}
		}

		if (auto statsNode = mountNode.child("stats")) {
			for (auto statNode : statsNode.children()) {
				std::string statName = statNode.name();
				int32_t statValue = statNode.attribute("value").as_int();

				if (statName == "maxHealth" || statName == "maxhealth") {
					mount->stats[STAT_MAXHITPOINTS] += statValue;
				} else if (statName == "maxMana" || statName == "maxmana") {
					mount->stats[STAT_MAXMANAPOINTS] += statValue;
				} else if (statName == "cap" || statName == "capacity") {
					mount->stats[STAT_CAPACITY] += statValue * 100;
				} else if (statName == "magLevel" || statName == "magicLevel" || statName == "magiclevel" || statName == "ml") {
					mount->stats[STAT_MAGICPOINTS] += statValue;
				}
			}
		}

		if (auto imbuingNode = mountNode.child("imbuing")) {
			for (auto imbuing : imbuingNode.children()) {
				std::string imbuingName = imbuing.name();
				double imbuingValue = imbuing.attribute("value").as_double() * 100.0;

				if (imbuingName == "lifeLeechChance" || imbuingName == "lifeleechchance") {
					mount->lifeLeechChance += imbuingValue;
				} else if (imbuingName == "lifeleechAmount" || imbuingName == "lifeleechamount") {
					mount->lifeLeechAmount += imbuingValue;
				} else if (imbuingName == "manaLeechChance" || imbuingName == "manaleechchance") {
					mount->manaLeechChance += imbuingValue;
				} else if (imbuingName == "manaLeechAmount" || imbuingName == "manaleechamount") {
					mount->manaLeechAmount += imbuingValue;
				} else if (imbuingName == "criticalChance" || imbuingName == "criticalchance") {
					mount->criticalChance += imbuingValue;
				} else if (imbuingName == "criticalDamage" || imbuingName == "criticaldamage") {
					mount->criticalDamage += imbuingValue;
				}
			}
		}

		mounts.insert(mount);
	}
	return true;
}

std::shared_ptr<Mount> Mounts::getMountByID(uint16_t id) {
	auto it = std::find_if(mounts.begin(), mounts.end(), [id](const std::shared_ptr<Mount> &mount) {
		return mount->id == id;
	});

	return it != mounts.end() ? *it : nullptr;
}

std::shared_ptr<Mount> Mounts::getMountByName(const std::string &name) {
	auto mountName = name.c_str();
	auto it = std::find_if(mounts.begin(), mounts.end(), [mountName](const std::shared_ptr<Mount> &mount) {
		return strcasecmp(mountName, mount->name.c_str()) == 0;
	});

	return it != mounts.end() ? *it : nullptr;
}

std::shared_ptr<Mount> Mounts::getMountByClientID(uint16_t clientId) {
	auto it = std::find_if(mounts.begin(), mounts.end(), [clientId](const std::shared_ptr<Mount> &mount) {
		return mount->clientId == clientId;
	});

	return it != mounts.end() ? *it : nullptr;
}

bool Mounts::addAttributes(uint32_t playerId, uint8_t mountId) {
	const auto &player = g_game().getPlayerByID(playerId);
	if (!player) {
		return false;
	}

	auto mount = getMountByID(mountId);
	if (!mount) {
		g_logger().warn("[Mounts::addAttributes] Mount with ID {} not found.", mountId);
		return false;
	}

	// Apply Conditions
	if (mount->manaShield) {
		auto condition = Condition::createCondition(CONDITIONID_MOUNT, CONDITION_MANASHIELD, -1, 0);
		player->addCondition(condition);
	}

	if (mount->invisible) {
		auto condition = Condition::createCondition(CONDITIONID_MOUNT, CONDITION_INVISIBLE, -1, 0);
		player->addCondition(condition);
	}

	if (mount->regeneration) {
		auto condition = Condition::createCondition(CONDITIONID_MOUNT, CONDITION_REGENERATION, -1, 0);
		if (mount->healthGain) {
			condition->setParam(CONDITION_PARAM_HEALTHGAIN, mount->healthGain);
		}

		if (mount->healthTicks) {
			condition->setParam(CONDITION_PARAM_HEALTHTICKS, mount->healthTicks);
		}

		if (mount->manaGain) {
			condition->setParam(CONDITION_PARAM_MANAGAIN, mount->manaGain);
		}

		if (mount->manaTicks) {
			condition->setParam(CONDITION_PARAM_MANATICKS, mount->manaTicks);
		}

		player->addCondition(condition);
	}

	// Apply skills
	for (uint32_t i = SKILL_FIRST; i <= SKILL_LAST; ++i) {
		if (mount->skills[i]) {
			player->setVarSkill(static_cast<skills_t>(i), mount->skills[i]);
		}
	}

	// Apply life leech
	if (mount->lifeLeechChance > 0) {
		player->setVarSkill(SKILL_LIFE_LEECH_CHANCE, mount->lifeLeechChance);
	}

	if (mount->lifeLeechAmount > 0) {
		player->setVarSkill(SKILL_LIFE_LEECH_AMOUNT, mount->lifeLeechAmount);
	}

	// Apply mana leech
	if (mount->manaLeechChance > 0) {
		player->setVarSkill(SKILL_MANA_LEECH_CHANCE, mount->manaLeechChance);
	}

	if (mount->manaLeechAmount > 0) {
		player->setVarSkill(SKILL_MANA_LEECH_AMOUNT, mount->manaLeechAmount);
	}

	// Apply critical hit
	if (mount->criticalChance > 0) {
		player->setVarSkill(SKILL_CRITICAL_HIT_CHANCE, mount->criticalChance);
	}

	if (mount->criticalDamage > 0) {
		player->setVarSkill(SKILL_CRITICAL_HIT_DAMAGE, mount->criticalDamage);
	}

	// Apply stats
	for (uint32_t s = STAT_FIRST; s <= STAT_LAST; ++s) {
		if (mount->stats[s]) {
			player->setVarStats(static_cast<stats_t>(s), mount->stats[s]);
		}
	}

	player->addScheduledUpdates((PlayerUpdate_Stats | PlayerUpdate_Skills));
	return true;
}

bool Mounts::removeAttributes(uint32_t playerId, uint8_t mountId) {
	const auto &player = g_game().getPlayerByID(playerId);
	if (!player) {
		return false;
	}

	auto it = std::find_if(mounts.begin(), mounts.end(), [mountId](const std::shared_ptr<Mount> &mount) {
		return mount->id == mountId;
	});

	if (it == mounts.end()) {
		g_logger().warn("[Mounts::removeAttributes] Mount with ID {} not found.", mountId);
		return false;
	}

	auto mount = *it;

	// Remove conditions
	if (mount->manaShield) {
		player->removeCondition(CONDITION_MANASHIELD, CONDITIONID_MOUNT);
	}

	if (mount->invisible) {
		player->removeCondition(CONDITION_INVISIBLE, CONDITIONID_MOUNT);
	}

	if (mount->regeneration) {
		player->removeCondition(CONDITION_REGENERATION, CONDITIONID_MOUNT);
	}

	// Revert Skills
	for (uint32_t i = SKILL_FIRST; i <= SKILL_LAST; ++i) {
		if (mount->skills[i]) {
			player->setVarSkill(static_cast<skills_t>(i), -mount->skills[i]);
		}
	}

	// Revert Life Leech
	if (mount->lifeLeechChance > 0) {
		player->setVarSkill(SKILL_LIFE_LEECH_CHANCE, -mount->lifeLeechChance);
	}

	if (mount->lifeLeechAmount > 0) {
		player->setVarSkill(SKILL_LIFE_LEECH_AMOUNT, -mount->lifeLeechAmount);
	}

	// Revert Mana Leech
	if (mount->manaLeechChance > 0) {
		player->setVarSkill(SKILL_MANA_LEECH_CHANCE, -mount->manaLeechChance);
	}

	if (mount->manaLeechAmount > 0) {
		player->setVarSkill(SKILL_MANA_LEECH_AMOUNT, -mount->manaLeechAmount);
	}

	// Revert Critical Hit
	if (mount->criticalChance > 0) {
		player->setVarSkill(SKILL_CRITICAL_HIT_CHANCE, -mount->criticalChance);
	}

	if (mount->criticalDamage > 0) {
		player->setVarSkill(SKILL_CRITICAL_HIT_DAMAGE, -mount->criticalDamage);
	}

	// Revert Stats
	for (uint32_t s = STAT_FIRST; s <= STAT_LAST; ++s) {
		if (mount->stats[s]) {
			player->setVarStats(static_cast<stats_t>(s), -mount->stats[s]);
		}
	}

	player->addScheduledUpdates((PlayerUpdate_Stats | PlayerUpdate_Skills));
	return true;
}
