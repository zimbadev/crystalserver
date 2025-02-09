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

enum ObjectCategory_t : uint8_t {
	OBJECTCATEGORY_NONE = 0,
	OBJECTCATEGORY_ARMORS = 1,
	OBJECTCATEGORY_NECKLACES = 2,
	OBJECTCATEGORY_BOOTS = 3,
	OBJECTCATEGORY_CONTAINERS = 4,
	OBJECTCATEGORY_DECORATION = 5,
	OBJECTCATEGORY_FOOD = 6,
	OBJECTCATEGORY_HELMETS = 7,
	OBJECTCATEGORY_LEGS = 8,
	OBJECTCATEGORY_OTHERS = 9,
	OBJECTCATEGORY_POTIONS = 10,
	OBJECTCATEGORY_RINGS = 11,
	OBJECTCATEGORY_RUNES = 12,
	OBJECTCATEGORY_SHIELDS = 13,
	OBJECTCATEGORY_TOOLS = 14,
	OBJECTCATEGORY_VALUABLES = 15,
	OBJECTCATEGORY_AMMO = 16,
	OBJECTCATEGORY_AXES = 17,
	OBJECTCATEGORY_CLUBS = 18,
	OBJECTCATEGORY_DISTANCEWEAPONS = 19,
	OBJECTCATEGORY_SWORDS = 20,
	OBJECTCATEGORY_WANDS = 21,
	OBJECTCATEGORY_PREMIUMSCROLLS = 22, // not used in quickloot
	OBJECTCATEGORY_TIBIACOINS = 23, // not used in quickloot
	OBJECTCATEGORY_CREATUREPRODUCTS = 24,
	OBJECTCATEGORY_GOLD = 30,
	OBJECTCATEGORY_DEFAULT = 31, // unassigned loot

	OBJECTCATEGORY_FIRST = OBJECTCATEGORY_ARMORS,
	OBJECTCATEGORY_LAST = OBJECTCATEGORY_DEFAULT,
};
