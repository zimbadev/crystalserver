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

enum WeaponProficiencyPerkType_t : uint16_t {
	PROFICIENCY_PERK_ATTACK_DAMAGE = 0,
	PROFICIENCY_PERK_DEFENSE = 1,
	PROFICIENCY_PERK_WEAPON_SHIELD_MOD = 2,
	PROFICIENCY_PERK_SKILLID_BONUS = 3,
	PROFICIENCY_PERK_SPECIAL_MAGIC_LEVEL = 4,
	PROFICIENCY_PERK_AUGMENT_TYPE = 5,
	PROFICIENCY_PERK_BESTIARY_DAMAGE = 6,
	PROFICIENCY_PERK_DAMAGE_GAIN_BOSS_AND_SINISTER_EMBRACED = 7,
	PROFICIENCY_PERK_CRITICAL_HIT_CHANCE = 8,
	PROFICIENCY_PERK_CRITICAL_HIT_CHANCE_FOR_ELEMENT_ID_SPELLS_AND_RUNES = 9,
	PROFICIENCY_PERK_CRITICAL_HIT_CHANCE_FOR_OFFENSIVE_RUNES = 10,
	PROFICIENCY_PERK_CRITICAL_HIT_CHANCE_FOR_AUTOATTACK = 11,
	PROFICIENCY_PERK_CRITICAL_EXTRA_DAMAGE = 12,
	PROFICIENCY_PERK_CRITICAL_EXTRA_DAMAGE_FOR_ELEMENT_ID_SPELLS_AND_RUNES = 13,
	PROFICIENCY_PERK_CRITICAL_EXTRA_DAMAGE_FOR_OFFENSIVE_RUNES = 14,
	PROFICIENCY_PERK_CRITICAL_EXTRA_DAMAGE_FOR_AUTOATTACK = 15,
	PROFICIENCY_PERK_MANA_LEECH = 16,
	PROFICIENCY_PERK_LIFE_LEECH = 17,
	PROFICIENCY_PERK_MANA_GAIN_ONHIT = 18,
	PROFICIENCY_PERK_LIFE_GAIN_ONHIT = 19,
	PROFICIENCY_PERK_MANA_GAIN_ONKILL = 20,
	PROFICIENCY_PERK_LIFE_GAIN_ONKILL = 21,
	PROFICIENCY_PERK_GAIN_DAMAGE_AT_RANGE = 22,
	PROFICIENCY_PERK_RANGED_HIT_CHANCE = 23,
	PROFICIENCY_PERK_ATTACK_RANGE = 24,
	PROFICIENCY_PERK_SKILLID_PERCENTAGE_AS_EXTRA_DAMAGE_FOR_AUTOATTACK = 25,
	PROFICIENCY_PERK_SKILLID_PERCENTAGE_AS_EXTRA_DAMAGE_FOR_SPELLS = 26,
	PROFICIENCY_PERK_SKILLID_PERCENTAGE_AS_EXTRA_HEALING_FOR_SPELLS = 27,
	PROFICIENCY_PERK_ALPHA_STRIKE_EXTRA_DAMAGE = 28,
	PROFICIENCY_PERK_OMEGA_STRIKE_EXTRA_DAMAGE = 29,
	PROFICIENCY_PERK_ARMOR_PENETRATION = 30,
	PROFICIENCY_PERK_ELEMENTAL_PIERCE = 31,
	PROFICIENCY_PERK_ON_HIT_HOMING_MISSILE = 32,
};

// 15.25 (sommerrelease26) SHAPE system: the perkType sent in a modified slot / reshape offer (0xC4/0xBB) is an
// INDEX into the client's shaping catalogue (1-323), NOT this server enum. UNIVERSAL = the per-vocation spell
// augment OFFSETS (added to region*50 in rollWeaponProficiencyPerk): {1-5 crit-chance, 11-15 crit-extra,
// 21-25 base-damage}. GENERAL = the vocation-agnostic 251-323 block (bestiary / leech-on-hit-on-kill /
// alpha-omega / skill% / armor-pen / elemental-pierce / powerful-foe). See CLIENT_15.25_e2a4a1_PORT.md §8.1.
inline constexpr WeaponProficiencyPerkType_t WEAPON_PROFICIENCY_UNIVERSAL_SHAPEABLE_PERKS[] = {
	static_cast<WeaponProficiencyPerkType_t>(1),
	static_cast<WeaponProficiencyPerkType_t>(2),
	static_cast<WeaponProficiencyPerkType_t>(3),
	static_cast<WeaponProficiencyPerkType_t>(4),
	static_cast<WeaponProficiencyPerkType_t>(5),
	static_cast<WeaponProficiencyPerkType_t>(11),
	static_cast<WeaponProficiencyPerkType_t>(12),
	static_cast<WeaponProficiencyPerkType_t>(13),
	static_cast<WeaponProficiencyPerkType_t>(14),
	static_cast<WeaponProficiencyPerkType_t>(15),
	static_cast<WeaponProficiencyPerkType_t>(21),
	static_cast<WeaponProficiencyPerkType_t>(22),
	static_cast<WeaponProficiencyPerkType_t>(23),
	static_cast<WeaponProficiencyPerkType_t>(24),
	static_cast<WeaponProficiencyPerkType_t>(25),
};

// 15.25 (sommerrelease26): the GENERAL (vocation-agnostic) shapeable catalogue indices in the 251-323 block.
//   251-271 = bestiary damage (250 + bestiaryId, 21 races)
//   281-288 = mana/life leech, mana/life on-hit, mana/life on-kill, alpha strike, omega strike
//   291-297 = skill% of auto-attacks (290 + skillSlot 1-7); 301-307 = skill% of spells; 311-317 = skill% of healing (313 omitted)
//   321-323 = armor penetration, elemental pierce, powerful foe
inline constexpr WeaponProficiencyPerkType_t WEAPON_PROFICIENCY_GENERAL_SHAPEABLE_PERKS[] = {
	static_cast<WeaponProficiencyPerkType_t>(251),
	static_cast<WeaponProficiencyPerkType_t>(252),
	static_cast<WeaponProficiencyPerkType_t>(253),
	static_cast<WeaponProficiencyPerkType_t>(254),
	static_cast<WeaponProficiencyPerkType_t>(255),
	static_cast<WeaponProficiencyPerkType_t>(256),
	static_cast<WeaponProficiencyPerkType_t>(257),
	static_cast<WeaponProficiencyPerkType_t>(258),
	static_cast<WeaponProficiencyPerkType_t>(259),
	static_cast<WeaponProficiencyPerkType_t>(260),
	static_cast<WeaponProficiencyPerkType_t>(261),
	static_cast<WeaponProficiencyPerkType_t>(262),
	static_cast<WeaponProficiencyPerkType_t>(263),
	static_cast<WeaponProficiencyPerkType_t>(264),
	static_cast<WeaponProficiencyPerkType_t>(265),
	static_cast<WeaponProficiencyPerkType_t>(266),
	static_cast<WeaponProficiencyPerkType_t>(267),
	static_cast<WeaponProficiencyPerkType_t>(268),
	static_cast<WeaponProficiencyPerkType_t>(269),
	static_cast<WeaponProficiencyPerkType_t>(270),
	static_cast<WeaponProficiencyPerkType_t>(271),
	static_cast<WeaponProficiencyPerkType_t>(281),
	static_cast<WeaponProficiencyPerkType_t>(282),
	static_cast<WeaponProficiencyPerkType_t>(283),
	static_cast<WeaponProficiencyPerkType_t>(284),
	static_cast<WeaponProficiencyPerkType_t>(285),
	static_cast<WeaponProficiencyPerkType_t>(286),
	static_cast<WeaponProficiencyPerkType_t>(287),
	static_cast<WeaponProficiencyPerkType_t>(288),
	static_cast<WeaponProficiencyPerkType_t>(291),
	static_cast<WeaponProficiencyPerkType_t>(292),
	static_cast<WeaponProficiencyPerkType_t>(293),
	static_cast<WeaponProficiencyPerkType_t>(294),
	static_cast<WeaponProficiencyPerkType_t>(295),
	static_cast<WeaponProficiencyPerkType_t>(296),
	static_cast<WeaponProficiencyPerkType_t>(297),
	static_cast<WeaponProficiencyPerkType_t>(301),
	static_cast<WeaponProficiencyPerkType_t>(302),
	static_cast<WeaponProficiencyPerkType_t>(303),
	static_cast<WeaponProficiencyPerkType_t>(304),
	static_cast<WeaponProficiencyPerkType_t>(305),
	static_cast<WeaponProficiencyPerkType_t>(306),
	static_cast<WeaponProficiencyPerkType_t>(307),
	static_cast<WeaponProficiencyPerkType_t>(311),
	static_cast<WeaponProficiencyPerkType_t>(312),
	static_cast<WeaponProficiencyPerkType_t>(314),
	static_cast<WeaponProficiencyPerkType_t>(315),
	static_cast<WeaponProficiencyPerkType_t>(316),
	static_cast<WeaponProficiencyPerkType_t>(317),
	static_cast<WeaponProficiencyPerkType_t>(321),
	static_cast<WeaponProficiencyPerkType_t>(322),
	static_cast<WeaponProficiencyPerkType_t>(323),
};

enum WeaponProficiencyPerkSkills_t : int8_t {
	PROFICIENCY_SKILL_MAGIC = 1,
	PROFICIENCY_SKILL_SHIELD = 6,
	PROFICIENCY_SKILL_DISTANCE = 7,
	PROFICIENCY_SKILL_SWORD = 8,
	PROFICIENCY_SKILL_CLUB = 9,
	PROFICIENCY_SKILL_AXE = 10,
	PROFICIENCY_SKILL_FIST = 11,
	PROFICIENCY_SKILL_FISHING = 13,
};

enum WeaponProficiencyPerkAugmentType_t : uint8_t {
	PROFICIENCY_AUGMENTTYPE_NONE = 0,
	PROFICIENCY_AUGMENTTYPE_MANA_COST = 1, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_BASE_DAMAGE = 2,
	PROFICIENCY_AUGMENTTYPE_HEALING = 3, // falta esse
	PROFICIENCY_AUGMENTTYPE_DURATION = 4, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_ADDITIONAL_TARGETS = 5, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_COOLDOWN = 6,
	PROFICIENCY_AUGMENTTYPE_SECONDARY_GROUP_COOLDOWN = 7, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_AREA_ENLARGED = 8, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_INCREASED_DAMAGE = 9, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_ENHANCED_EFFECT = 10, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_AREA_ENLARGED_2 = 11, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_ENHANCED_EFFECT_2 = 12, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_INCREASED_SKILL = 13, // UNKNOWN
	PROFICIENCY_AUGMENTTYPE_LIFE_LEECH = 14,
	PROFICIENCY_AUGMENTTYPE_MANA_LEECH = 15,
	PROFICIENCY_AUGMENTTYPE_CRITICAL_EXTRA_DAMAGE = 16,
	PROFICIENCY_AUGMENTTYPE_CRITICAL_HIT_CHANCE = 17,
};

enum WeaponProficiencyPerkDamageType_t : int32_t {
	PROFICIENCY_DAMAGETYPE_NONE = 0,
	PROFICIENCY_DAMAGETYPE_PHYSICAL = 1, // COMBAT_PHYSICALDAMAGE
	PROFICIENCY_DAMAGETYPE_FIRE = 8, // COMBAT_FIREDAMAGE
	PROFICIENCY_DAMAGETYPE_EARTH = 16, // COMBAT_EARTHDAMAGE
	PROFICIENCY_DAMAGETYPE_ENERGY = 32, // COMBAT_ENERGYDAMAGE
	PROFICIENCY_DAMAGETYPE_ICE = 64, // COMBAT_ICEDAMAGE
	PROFICIENCY_DAMAGETYPE_HOLY = 128, // COMBAT_HOLYDAMAGE
	PROFICIENCY_DAMAGETYPE_DEATH = 256, // COMBAT_DEATHDAMAGE
	PROFICIENCY_DAMAGETYPE_HEALING = 1048576, // COMBAT_HEALING
};
