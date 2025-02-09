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

#ifndef USE_PRECOMPILED_HEADERS
	#include <cstdint>
#endif

enum class PlayerIcon : uint8_t {
	Poison = 0,
	Burn = 1,
	Energy = 2,
	Drunk = 3,
	ManaShield = 4,
	Paralyze = 5,
	Haste = 6,
	Swords = 7,
	Drowning = 8,
	Freezing = 9,
	Dazzled = 10,
	Cursed = 11,
	PartyBuff = 12,
	RedSwords = 13,
	Pigeon = 14,
	Bleeding = 15,
	LesserHex = 16,
	IntenseHex = 17,
	GreaterHex = 18,
	Rooted = 19,
	Feared = 20,
	GoshnarTaint1 = 21,
	GoshnarTaint2 = 22,
	GoshnarTaint3 = 23,
	GoshnarTaint4 = 24,
	GoshnarTaint5 = 25,
	NewManaShield = 26,
	Agony = 27,
	Powerless = 28,

	// Must always be the last
	Count
};

enum class IconBakragore : uint8_t {
	None = 0,
	Taint1 = 1,
	Taint2 = 2,
	Taint3 = 3,
	Taint4 = 4,
	Taint5 = 5,
	Taint6 = 6,
	Taint7 = 7,
	Taint8 = 8,
	Taint9 = 9,
};
