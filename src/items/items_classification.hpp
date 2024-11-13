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

struct TierInfo {
	uint8_t corePrice = 0;
	uint64_t regularPrice = 0;
	uint64_t convergenceFusionPrice = 0;
	uint64_t convergenceTransferPrice = 0;
};

// Classification class for forging system and market.
class ItemClassification final {
public:
	ItemClassification() = default;
	explicit ItemClassification(uint8_t id) :
		id(id) { }
	virtual ~ItemClassification() = default;

	void addTier(uint8_t tierId, uint8_t corePrice, uint64_t regularPrice, uint64_t convergenceFusionPrice, uint64_t convergenceTransferPrice) {
		auto &table = tiers[tierId];
		table.corePrice = corePrice;
		table.regularPrice = regularPrice;
		table.convergenceFusionPrice = convergenceFusionPrice;
		table.convergenceTransferPrice = convergenceTransferPrice;
	}

	uint8_t id {};
	std::map<uint8_t, TierInfo> tiers {};
};
