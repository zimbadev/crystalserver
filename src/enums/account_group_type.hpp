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

enum GroupType : uint8_t {
	GROUP_TYPE_NONE = 0,
	GROUP_TYPE_NORMAL = 1,
	GROUP_TYPE_TUTOR = 2,
	GROUP_TYPE_SENIORTUTOR = 3,
	GROUP_TYPE_GAMEMASTER = 4,
	GROUP_TYPE_COMMUNITYMANAGER = 5,
	GROUP_TYPE_GOD = 6,
	GROUP_TYPE_TESTER = 7
};
