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

enum class ContainerSpecial_t : uint8_t {
	None = 0,
	LootContainer = 1,
	ContentCounter = 2,
	LootHighlight = 4,
	Obtain = 8,
	Manager = 9,
	QuiverLoot = 11,
};
