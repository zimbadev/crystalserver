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
	// 15.30 client perk kinds 33-35 (reachable only through the SHAPE catalogue entries 291-293): a percentage of the
	// player's HIGHEST combat skill as extra auto-attack damage / spell damage / spell healing.
	PROFICIENCY_PERK_HIGHEST_COMBAT_SKILL_PERCENTAGE_AS_EXTRA_DAMAGE_FOR_AUTOATTACK = 33,
	PROFICIENCY_PERK_HIGHEST_COMBAT_SKILL_PERCENTAGE_AS_EXTRA_DAMAGE_FOR_SPELLS = 34,
	PROFICIENCY_PERK_HIGHEST_COMBAT_SKILL_PERCENTAGE_AS_EXTRA_HEALING_FOR_SPELLS = 35,
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

// ---------------------------------------------------------------------------------------------------------------------
// 15.30 SHAPE catalogue. Reverse-engineered from the official 15.30 client (index decoder FUN_140ef6410, the five
// per-vocation option arrays at 0x141d81870.. and the rank curves in FUN_140ef7de0). The perkType carried by a modified
// slot (0xC4) or a reshape offer (0xBB) is an INDEX 1-323 into this catalogue, NOT a WeaponProficiencyPerkType_t.
//   1-250  : five 50-wide VOCATION regions (0 knight, 1 paladin, 2 sorcerer, 3 druid, 4 monk). Inside a region every
//            row of 10 is one augment kind and columns 1-6 are the vocation's six shapeable spells:
//              +1..+6 critical hit chance, +11..+16 critical extra damage, +21..+26 base damage,
//              +31..+36 mana leech, +41..+46 life leech (columns 7-10 are unused by the client).
//   251-271: bestiary damage, 250 + bestiaryId (21 creature classes)
//   281-287: rune crit chance, auto-attack crit chance, rune crit extra damage, auto-attack crit extra damage,
//            life gain on hit, mana gain on kill, life gain on kill
//   291-293: highest combat skill percentage as extra auto-attack damage / spell damage / spell healing
//   321-323: alpha strike, omega strike, armor penetration
// The client shows every vocation exactly the 34 GENERAL entries plus its own 30 augment entries (64 options).
// Rank curves (client value = rank0 + perRank * rank, rank 0..10) live in Proficiencies::decodeShapeIndex.
inline constexpr uint16_t WEAPON_PROFICIENCY_SHAPE_REGION_SIZE = 50;
inline constexpr uint8_t WEAPON_PROFICIENCY_SHAPE_REGION_COUNT = 5;
inline constexpr uint8_t WEAPON_PROFICIENCY_SHAPE_AUGMENT_ROWS = 5;
inline constexpr uint8_t WEAPON_PROFICIENCY_SHAPE_SPELLS_PER_REGION = 6;
inline constexpr uint16_t WEAPON_PROFICIENCY_SHAPE_MAX_INDEX = 323;
inline constexpr uint8_t WEAPON_PROFICIENCY_SHAPE_MAX_RANK = 10;
inline constexpr uint8_t WEAPON_PROFICIENCY_SHAPE_NO_REGION = 0xFF;

// Augment kind of each 10-wide row inside a vocation region (row 0 = +1..+6, row 4 = +41..+46).
inline constexpr WeaponProficiencyPerkAugmentType_t WEAPON_PROFICIENCY_SHAPE_AUGMENT_ROW_TYPES[WEAPON_PROFICIENCY_SHAPE_AUGMENT_ROWS] = {
	PROFICIENCY_AUGMENTTYPE_CRITICAL_HIT_CHANCE,
	PROFICIENCY_AUGMENTTYPE_CRITICAL_EXTRA_DAMAGE,
	PROFICIENCY_AUGMENTTYPE_BASE_DAMAGE,
	PROFICIENCY_AUGMENTTYPE_MANA_LEECH,
	PROFICIENCY_AUGMENTTYPE_LIFE_LEECH,
};

// Client spell ids of the six shapeable spells per vocation region, in catalogue column order.
inline constexpr uint16_t WEAPON_PROFICIENCY_SHAPE_SPELLS[WEAPON_PROFICIENCY_SHAPE_REGION_COUNT][WEAPON_PROFICIENCY_SHAPE_SPELLS_PER_REGION] = {
	{ 80, 105, 106, 59, 316, 261 }, // knight: Berserk, Fierce Berserk, Groundshaker, Front Sweep, Shield Slam, Executioner's Throw
	{ 124, 302, 303, 258, 57, 122 }, // paladin: Divine Caldera, Divine Barrage, Ethereal Barrage, Divine Grenade, Strong Ethereal Spear, Divine Missile
	{ 13, 24, 240, 260, 310, 23 }, // sorcerer: Energy Wave, Hell's Core, Great Fire Wave, Great Death Beam, Death Echo, Great Energy Beam
	{ 43, 120, 263, 262, 317, 318 }, // druid: Strong Ice Wave, Terra Wave, Terra Burst, Ice Burst, Forked Glacier, Forked Thorns
	{ 289, 288, 294, 287, 301, 290 }, // monk: Greater Flurry of Blows, Chained Penance, Sweeping Takedown, Flurry of Blows, Thousand Fist Blows, Mystic Repulse
};

// The 34 vocation-agnostic GENERAL catalogue indices offered to every vocation.
inline constexpr uint16_t WEAPON_PROFICIENCY_SHAPE_GENERAL[] = {
	251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, // bestiary
	281, 282, 283, 284, 285, 286, 287, // crit (runes / auto-attack), life on hit, mana on kill, life on kill
	291, 292, 293, // highest combat skill percentage
	321, 322, 323, // alpha strike, omega strike, armor penetration
};
