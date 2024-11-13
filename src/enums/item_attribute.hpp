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

enum class ItemAttribute_t : uint64_t {
	NONE = 0,
	ACTIONID = 1,
	UNIQUEID = 2,
	DESCRIPTION = 3,
	TEXT = 4,
	DATE = 5,
	WRITER = 6,
	NAME = 7,
	ARTICLE = 8,
	PLURALNAME = 9,
	WEIGHT = 10,
	ATTACK = 11,
	DEFENSE = 12,
	EXTRADEFENSE = 13,
	ARMOR = 14,
	HITCHANCE = 15,
	SHOOTRANGE = 16,
	OWNER = 17,
	DURATION = 18,
	DECAYSTATE = 19,
	CORPSEOWNER = 20,
	CHARGES = 21,
	FLUIDTYPE = 22,
	DOORID = 23,
	SPECIAL = 24,
	IMBUEMENT_SLOT = 25,
	OPENCONTAINER = 26,
	QUICKLOOTCONTAINER = 27,
	DURATION_TIMESTAMP = 28,
	AMOUNT = 29,
	TIER = 30,
	STORE = 31,
	CUSTOM = 32,
	LOOTMESSAGE_SUFFIX = 33,
	STORE_INBOX_CATEGORY = 34,
	OBTAINCONTAINER = 35,
	AUGMENTS = 36,
};

enum ItemDecayState_t : uint8_t {
	DECAYING_FALSE = 0,
	DECAYING_TRUE,
	DECAYING_PENDING,
	DECAYING_STOPPING,
};

enum ItemAnimation_t : uint8_t {
	ANIMATION_NONE = 0,
	ANIMATION_RANDOM = 1,
	ANIMATION_DESYNC = 2,
};
