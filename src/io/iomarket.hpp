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

#include "database/database.hpp"
#include "declarations.hpp"
#include "lib/di/container.hpp"

class IOMarket {
public:
	IOMarket() = default;

	static IOMarket &getInstance() {
		return inject<IOMarket>();
	}

	static MarketOfferList getActiveOffers(MarketAction_t action);
	static MarketOfferList getActiveOffers(MarketAction_t action, uint16_t itemId, uint8_t tier);
	static MarketOfferList getOwnOffers(MarketAction_t action, uint32_t playerId);
	static HistoryMarketOfferList getOwnHistory(MarketAction_t action, uint32_t playerId);

	static void processExpiredOffers(const DBResult_ptr &result, bool);
	static void checkExpiredOffers();

	static uint32_t getPlayerOfferCount(uint32_t playerId);
	static MarketOfferEx getOfferByCounter(uint32_t timestamp, uint16_t counter);

	static void createOffer(uint32_t playerId, MarketAction_t action, uint32_t itemId, uint16_t amount, uint64_t price, uint8_t tier, bool anonymous);
	static void acceptOffer(uint32_t offerId, uint16_t amount);
	static void deleteOffer(uint32_t offerId);

	static void appendHistory(uint32_t playerId, MarketAction_t type, uint16_t itemId, uint16_t amount, uint64_t price, time_t timestamp, uint8_t tier, MarketOfferState_t state);
	static bool moveOfferToHistory(uint32_t offerId, MarketOfferState_t state);

	void updateStatistics();

	using StatisticsMap = std::map<uint16_t, std::map<uint8_t, MarketStatistics>>;
	const StatisticsMap &getPurchaseStatistics() const {
		return purchaseStatistics;
	}
	const StatisticsMap &getSaleStatistics() const {
		return saleStatistics;
	}

	static uint8_t getTierFromDatabaseTable(const std::string &string);

private:
	// [uint16_t = item id, [uint8_t = item tier, MarketStatistics = structure of the statistics]]
	StatisticsMap purchaseStatistics;
	StatisticsMap saleStatistics;
};
