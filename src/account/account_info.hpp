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
	#include <parallel_hashmap/phmap.h>
	#include <cstdint>
#endif

#include "enums/account_type.hpp"

struct AccountInfo {
	~AccountInfo() = default;

	uint32_t id = 0;
	uint32_t premiumRemainingDays = 0;
	time_t premiumLastDay = 0;
	AccountType accountType = ACCOUNT_TYPE_NONE;
	phmap::flat_hash_map<std::string, uint64_t> players;
	bool oldProtocol = false;
	time_t sessionExpires = 0;
	uint32_t premiumDaysPurchased = 0;
	uint32_t creationTime = 0;
	uint32_t houseBidId = 0;
};
