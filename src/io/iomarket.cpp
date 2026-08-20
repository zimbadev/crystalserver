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

#include "io/iomarket.hpp"

#include "account/account.hpp"
#include "config/configmanager.hpp"
#include "creatures/players/player.hpp"
#include "database/databasetasks.hpp"
#include "game/game.hpp"
#include "game/scheduling/dispatcher.hpp"
#include "game/scheduling/save_manager.hpp"
#include "io/iologindata.hpp"
#include "items/containers/inbox/inbox.hpp"
#include "items/item.hpp"

uint8_t IOMarket::getTierFromDatabaseTable(const std::string &string) {
	auto tier = static_cast<uint8_t>(std::atoi(string.c_str()));
	if (tier > g_configManager().getNumber(FORGE_MAX_ITEM_TIER)) {
		g_logger().error("{} - Failed to get number value {} for tier table result", __FUNCTION__, tier);
		return 0;
	}

	return tier;
}

MarketOfferList IOMarket::getActiveOffers(MarketAction_t action) {
	MarketOfferList offerList;

	std::string query = fmt::format(
		"SELECT `id`, `itemtype`, `amount`, `price`, `tier`, `created`, `anonymous`, "
		"(SELECT `name` FROM `players` WHERE `id` = `player_id`) AS `player_name` "
		"FROM `market_offers` WHERE `sale` = {} "
		"ORDER BY `id` DESC "
		"LIMIT {}",
		action, MAX_MARKET_OFFERS_RETURNED
	);

	DBResult_ptr result = g_database().storeQuery(query);
	if (!result) {
		return offerList;
	}

	const int32_t marketOfferDuration = g_configManager().getNumber(MARKET_OFFER_DURATION);

	do {
		MarketOffer offer;
		offer.itemId = result->getNumber<uint16_t>("itemtype");
		offer.amount = result->getNumber<uint16_t>("amount");
		offer.price = result->getNumber<uint64_t>("price");
		offer.timestamp = result->getNumber<uint32_t>("created") + marketOfferDuration;
		offer.counter = result->getNumber<uint32_t>("id") & 0xFFFF;
		if (result->getNumber<uint16_t>("anonymous") == 0) {
			offer.playerName = result->getString("player_name");
		} else {
			offer.playerName = "Anonymous";
		}
		offer.tier = getTierFromDatabaseTable(result->getString("tier"));
		offerList.push_back(offer);
	} while (result->next());
	return offerList;
}

MarketOfferList IOMarket::getActiveOffers(MarketAction_t action, uint16_t itemId, uint8_t tier) {
	MarketOfferList offerList;

	std::ostringstream query;
	query << "SELECT `id`, `amount`, `price`, `tier`, `created`, `anonymous`, (SELECT `name` FROM `players` WHERE `id` = `player_id`) AS `player_name` FROM `market_offers` WHERE `sale` = " << action << " AND `itemtype` = " << itemId << " AND `tier` = " << std::to_string(tier) << " ORDER BY `id` DESC LIMIT " << MAX_MARKET_OFFERS_PER_SIDE;

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return offerList;
	}

	const int32_t marketOfferDuration = g_configManager().getNumber(MARKET_OFFER_DURATION);

	do {
		MarketOffer offer;
		offer.itemId = itemId;
		offer.amount = result->getNumber<uint16_t>("amount");
		offer.price = result->getNumber<uint64_t>("price");
		offer.timestamp = result->getNumber<uint32_t>("created") + marketOfferDuration;
		offer.counter = result->getNumber<uint32_t>("id") & 0xFFFF;
		if (result->getNumber<uint16_t>("anonymous") == 0) {
			offer.playerName = result->getString("player_name");
		} else {
			offer.playerName = "Anonymous";
		}
		offer.tier = getTierFromDatabaseTable(result->getString("tier"));
		offerList.push_back(offer);
	} while (result->next());
	return offerList;
}

MarketOfferList IOMarket::getOwnOffers(MarketAction_t action, uint32_t playerId) {
	MarketOfferList offerList;

	const int32_t marketOfferDuration = g_configManager().getNumber(MARKET_OFFER_DURATION);

	std::ostringstream query;
	query << "SELECT `id`, `amount`, `price`, `created`, `itemtype`, `tier` FROM `market_offers` WHERE `player_id` = " << playerId << " AND `sale` = " << action;

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return offerList;
	}

	do {
		MarketOffer offer;
		offer.amount = result->getNumber<uint16_t>("amount");
		offer.price = result->getNumber<uint64_t>("price");
		offer.timestamp = result->getNumber<uint32_t>("created") + marketOfferDuration;
		offer.counter = result->getNumber<uint32_t>("id") & 0xFFFF;
		offer.itemId = result->getNumber<uint16_t>("itemtype");
		offer.tier = getTierFromDatabaseTable(result->getString("tier"));
		offerList.push_back(offer);
	} while (result->next());
	return offerList;
}

HistoryMarketOfferList IOMarket::getOwnHistory(MarketAction_t action, uint32_t playerId) {
	HistoryMarketOfferList offerList;

	std::ostringstream query;
	query << "SELECT `itemtype`, `amount`, `price`, `expires_at`, `state`, `tier` FROM `market_history` WHERE `player_id` = " << playerId << " AND `sale` = " << action;

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return offerList;
	}

	do {
		HistoryMarketOffer offer {};
		offer.itemId = result->getNumber<uint16_t>("itemtype");
		offer.amount = result->getNumber<uint16_t>("amount");
		offer.price = result->getNumber<uint64_t>("price");
		offer.timestamp = result->getNumber<uint32_t>("expires_at");
		offer.tier = getTierFromDatabaseTable(result->getString("tier"));

		MarketOfferState_t offerState = static_cast<MarketOfferState_t>(result->getNumber<uint16_t>("state"));
		if (offerState == OFFERSTATE_ACCEPTEDEX) {
			offerState = OFFERSTATE_ACCEPTED;
		}

		offer.state = offerState;

		offerList.push_back(offer);
	} while (result->next());
	return offerList;
}

void IOMarket::processExpiredOffers(const DBResult_ptr &result, bool) {
	if (!result) {
		return;
	}

	do {
		if (!IOMarket::moveOfferToHistory(result->getNumber<uint32_t>("id"), OFFERSTATE_EXPIRED)) {
			continue;
		}

		const auto playerId = result->getNumber<uint32_t>("player_id");
		const auto amount = result->getNumber<uint16_t>("amount");
		auto tier = getTierFromDatabaseTable(result->getString("tier"));
		if (result->getNumber<uint16_t>("sale") == 1) {
			const ItemType &itemType = Item::items[result->getNumber<uint16_t>("itemtype")];
			if (itemType.id == 0) {
				continue;
			}

			const auto &player = g_game().getPlayerByGUID(playerId, true);
			if (!player) {
				continue;
			}

			const auto &playerInbox = player->getInbox();

			if (itemType.stackable) {
				uint16_t tmpAmount = amount;
				while (tmpAmount > 0) {
					uint16_t stackCount = std::min<uint16_t>(100, tmpAmount);
					const auto &item = Item::CreateItem(itemType.id, stackCount);
					if (g_game().internalAddItem(playerInbox, item, INDEX_WHEREEVER, FLAG_NOLIMIT) != RETURNVALUE_NOERROR) {
						g_logger().error("[{}] Ocurred an error to add item with id {} to player {}", __FUNCTION__, itemType.id, player->getName());

						break;
					}

					if (tier != 0) {
						item->setAttribute(ItemAttribute_t::TIER, tier);
					}

					tmpAmount -= stackCount;
				}
			} else {
				int32_t subType;
				if (itemType.charges != 0) {
					subType = itemType.charges;
				} else {
					subType = -1;
				}

				for (uint16_t i = 0; i < amount; ++i) {
					const auto &item = Item::CreateItem(itemType.id, subType);
					if (g_game().internalAddItem(playerInbox, item, INDEX_WHEREEVER, FLAG_NOLIMIT) != RETURNVALUE_NOERROR) {
						break;
					}

					if (tier != 0) {
						item->setAttribute(ItemAttribute_t::TIER, tier);
					}
				}
			}

			if (player->isOffline()) {
				g_saveManager().savePlayer(player);
			}
		} else {
			uint64_t totalPrice = result->getNumber<uint64_t>("price") * amount;

			const auto &player = g_game().getPlayerByGUID(playerId);
			if (player) {
				player->setBankBalance(player->getBankBalance() + totalPrice);
			} else {
				IOLoginData::increaseBankBalance(playerId, totalPrice);
			}
		}
	} while (result->next());
}

void IOMarket::checkExpiredOffers() {
	const time_t lastExpireDate = getTimeNow() - g_configManager().getNumber(MARKET_OFFER_DURATION);

	std::ostringstream query;
	query << "SELECT `id`, `amount`, `price`, `itemtype`, `player_id`, `sale`, `tier` FROM `market_offers` WHERE `created` <= " << lastExpireDate;
	g_databaseTasks().store(query.str(), IOMarket::processExpiredOffers);

	int32_t checkExpiredMarketOffersEachMinutes = g_configManager().getNumber(CHECK_EXPIRED_MARKET_OFFERS_EACH_MINUTES);
	if (checkExpiredMarketOffersEachMinutes <= 0) {
		return;
	}

	g_dispatcher().scheduleEvent(checkExpiredMarketOffersEachMinutes * 60 * 1000, IOMarket::checkExpiredOffers, __FUNCTION__);
}

void IOMarket::checkWebOrders() {
	if (!g_configManager().getBoolean(TOGGLE_WEB_MARKET_ORDERS)) {
		return;
	}

	int32_t worldId = g_configManager().getNumber(WORLD_ID);

	std::ostringstream query;
	query << "SELECT `id`, `offer_id`, `buyer_id`, `buyer_account_id`, `seller_id`, `seller_account_id`, `itemtype`, `amount`, `price`, `tier`, `currency_type` "
		  << "FROM `market_web_orders` WHERE `status` = 'PENDING' AND `world_id` = " << worldId << " ORDER BY `id` ASC LIMIT 20";
	g_databaseTasks().store(query.str(), IOMarket::processWebOrders);

	int32_t interval = g_configManager().getNumber(WEB_MARKET_ORDERS_INTERVAL);
	if (interval <= 0) {
		return;
	}

	g_dispatcher().scheduleEvent(interval, IOMarket::checkWebOrders, __FUNCTION__);
}

void IOMarket::processWebOrders(const DBResult_ptr &result, bool) {
	if (!result) {
		return;
	}

	Database &db = Database::getInstance();

	do {
		uint64_t orderId = result->getNumber<uint64_t>("id");
		uint32_t offerId = result->getNumber<uint32_t>("offer_id");
		uint32_t buyerId = result->getNumber<uint32_t>("buyer_id");
		uint32_t buyerAccountId = result->getNumber<uint32_t>("buyer_account_id");
		uint32_t sellerId = result->getNumber<uint32_t>("seller_id");
		uint32_t sellerAccountId = result->getNumber<uint32_t>("seller_account_id");
		uint16_t itemId = result->getNumber<uint16_t>("itemtype");
		uint16_t amount = result->getNumber<uint16_t>("amount");
		uint64_t totalPrice = result->getNumber<uint64_t>("price");
		uint8_t tier = result->getNumber<uint8_t>("tier");
		std::string currencyType = result->getString("currency_type");

		// Claim order atomically
		std::ostringstream lockQuery;
		lockQuery << "UPDATE `market_web_orders` SET `status` = 'PROCESSING' WHERE `id` = " << orderId << " AND `status` = 'PENDING'";
		if (!db.executeQuery(lockQuery.str())) {
			continue;
		}

		auto failOrder = [&](const std::string &reason) {
			std::ostringstream failQuery;
			failQuery << "UPDATE `market_web_orders` SET `status` = 'FAILED', `fail_reason` = " << db.escapeString(reason)
					  << ", `processed_at` = UNIX_TIMESTAMP() WHERE `id` = " << orderId;
			db.executeQuery(failQuery.str());
		};

		const ItemType &it = Item::items[itemId];
		if (it.id == 0) {
			failOrder("Invalid item type id");
			continue;
		}

		// Validate offer exists in database and matches requested item/tier/amount
		std::ostringstream offerQuery;
		offerQuery << "SELECT `id`, `amount`, `price`, `tier`, `itemtype` FROM `market_offers` WHERE `id` = " << offerId;
		DBResult_ptr offerRes = db.storeQuery(offerQuery.str());
		if (!offerRes) {
			failOrder("Market offer no longer available on market");
			continue;
		}

		uint16_t offerAmount = offerRes->getNumber<uint16_t>("amount");
		uint16_t offerItemType = offerRes->getNumber<uint16_t>("itemtype");
		uint8_t offerTier = offerRes->getNumber<uint8_t>("tier");

		if (offerItemType != itemId || offerTier != tier || offerAmount < amount) {
			failOrder("Market offer quantity, item or tier mismatch");
			continue;
		}

		const auto &buyer = g_game().getPlayerByGUID(buyerId, true);
		if (!buyer) {
			failOrder("Buyer character not found");
			continue;
		}

		bool buyerCharged = false;

		if (currencyType == "tibia_coin") {
			if (buyer->getAccount() && buyer->getAccount()->removeCoins(enumToValue(CoinType::Transferable), totalPrice, "Web Market Purchase") == enumToValue(AccountErrors_t::Ok)) {
				buyerCharged = true;
			} else {
				std::ostringstream coinCheck;
				coinCheck << "SELECT `coins` FROM `accounts` WHERE `id` = " << buyerAccountId;
				DBResult_ptr coinRes = db.storeQuery(coinCheck.str());
				if (coinRes && coinRes->getNumber<uint64_t>("coins") >= totalPrice) {
					std::ostringstream chargeCoins;
					chargeCoins << "UPDATE `accounts` SET `coins` = `coins` - " << totalPrice << " WHERE `id` = " << buyerAccountId;
					if (db.executeQuery(chargeCoins.str())) {
						buyerCharged = true;
					}
				}
			}
		} else if (currencyType == "gold") {
			if (buyer->isOffline()) {
				std::ostringstream balQuery;
				balQuery << "SELECT `balance` FROM `players` WHERE `id` = " << buyerId;
				DBResult_ptr balRes = db.storeQuery(balQuery.str());
				if (balRes && balRes->getNumber<uint64_t>("balance") >= totalPrice) {
					std::ostringstream chargeBal;
					chargeBal << "UPDATE `players` SET `balance` = `balance` - " << totalPrice << " WHERE `id` = " << buyerId;
					if (db.executeQuery(chargeBal.str())) {
						buyer->setBankBalance(balRes->getNumber<uint64_t>("balance") - totalPrice);
						buyerCharged = true;
					}
				}
			} else {
				if (buyer->getBankBalance() >= totalPrice) {
					buyer->setBankBalance(buyer->getBankBalance() - totalPrice);
					buyerCharged = true;
				}
			}
		} else {
			failOrder("Unsupported currency type: " + currencyType);
			continue;
		}

		if (!buyerCharged) {
			failOrder("Buyer has insufficient balance/coins");
			continue;
		}

		// Deliver item to buyer inbox (SET ATTRIBUTES BEFORE internalAddItem TO PREVENT USE-AFTER-FREE)
		const auto &playerInbox = buyer->getInbox();
		bool deliverySuccess = true;

		if (it.stackable) {
			uint16_t tmpAmount = amount;
			while (tmpAmount > 0) {
				uint16_t stackCount = std::min<uint16_t>(100, tmpAmount);
				const auto &item = Item::CreateItem(it.id, stackCount);
				if (!item) {
					deliverySuccess = false;
					break;
				}
				if (tier != 0) {
					item->setAttribute(ItemAttribute_t::TIER, tier);
				}
				if (g_game().internalAddItem(playerInbox, item, INDEX_WHEREEVER, FLAG_NOLIMIT) != RETURNVALUE_NOERROR) {
					deliverySuccess = false;
					break;
				}
				tmpAmount -= stackCount;
			}
		} else {
			int32_t subType = (it.charges != 0) ? it.charges : -1;
			for (uint16_t i = 0; i < amount; ++i) {
				const auto &item = Item::CreateItem(it.id, subType);
				if (!item) {
					deliverySuccess = false;
					break;
				}
				if (tier != 0) {
					item->setAttribute(ItemAttribute_t::TIER, tier);
				}
				if (g_game().internalAddItem(playerInbox, item, INDEX_WHEREEVER, FLAG_NOLIMIT) != RETURNVALUE_NOERROR) {
					deliverySuccess = false;
					break;
				}
			}
		}

		if (!deliverySuccess) {
			// Rollback buyer funds
			if (currencyType == "tibia_coin") {
				if (buyer->getAccount()) {
					buyer->getAccount()->addCoins(enumToValue(CoinType::Transferable), totalPrice, "Web Market Purchase Refund");
				} else {
					std::ostringstream refundCoins;
					refundCoins << "UPDATE `accounts` SET `coins` = `coins` + " << totalPrice << " WHERE `id` = " << buyerAccountId;
					db.executeQuery(refundCoins.str());
				}
			} else {
				if (buyer->isOffline()) {
					std::ostringstream refundBal;
					refundBal << "UPDATE `players` SET `balance` = `balance` + " << totalPrice << " WHERE `id` = " << buyerId;
					db.executeQuery(refundBal.str());
				} else {
					buyer->setBankBalance(buyer->getBankBalance() + totalPrice);
				}
			}
			failOrder("Failed to deliver items to buyer inbox");
			continue;
		}

		if (buyer->isOffline()) {
			g_saveManager().savePlayer(buyer);
		} else {
			buyer->sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your purchase on the Web Market was completed! The item has been delivered to your Inbox.");
		}

		// Pay seller
		if (currencyType == "tibia_coin") {
			const auto &seller = g_game().getPlayerByGUID(sellerId, false);
			if (seller && seller->getAccount()) {
				seller->getAccount()->addCoins(enumToValue(CoinType::Transferable), totalPrice, "Web Market Sale");
			} else {
				std::ostringstream creditCoins;
				creditCoins << "UPDATE `accounts` SET `coins` = `coins` + " << totalPrice << " WHERE `id` = " << sellerAccountId;
				db.executeQuery(creditCoins.str());
			}
		} else {
			const auto &seller = g_game().getPlayerByGUID(sellerId, false);
			if (seller) {
				seller->setBankBalance(seller->getBankBalance() + totalPrice);
				seller->sendTextMessage(MESSAGE_EVENT_ADVANCE, "You sold an item on the Web Market! Gold has been credited to your bank account.");
			} else {
				IOLoginData::increaseBankBalance(sellerId, totalPrice);
			}
		}

		// Consume or deduct market offer
		if (offerAmount == amount) {
			deleteOffer(offerId);
		} else {
			acceptOffer(offerId, amount);
		}

		appendHistory(buyerId, MARKETACTION_BUY, itemId, amount, totalPrice, getTimeNow(), tier, OFFERSTATE_ACCEPTEDEX);
		appendHistory(sellerId, MARKETACTION_SELL, itemId, amount, totalPrice, getTimeNow(), tier, OFFERSTATE_ACCEPTED);

		std::ostringstream compQuery;
		compQuery << "UPDATE `market_web_orders` SET `status` = 'COMPLETED', `processed_at` = UNIX_TIMESTAMP() WHERE `id` = " << orderId;
		db.executeQuery(compQuery.str());

	} while (result->next());
}

uint32_t IOMarket::getPlayerOfferCount(uint32_t playerId) {
	std::ostringstream query;
	query << "SELECT COUNT(*) AS `count` FROM `market_offers` WHERE `player_id` = " << playerId;

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return 0;
	}
	return result->getNumber<int32_t>("count");
}

uint32_t IOMarket::getPlayerOfferCountPerSide(uint32_t playerId, MarketAction_t action) {
	std::ostringstream query;
	query << "SELECT COUNT(*) AS `count` FROM `market_offers` WHERE `player_id` = " << playerId << " AND `sale` = " << action;

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return 0;
	}
	return result->getNumber<int32_t>("count");
}

uint32_t IOMarket::getItemOfferCountPerSide(uint16_t itemId, uint8_t tier, MarketAction_t action) {
	std::ostringstream query;
	query << "SELECT COUNT(*) AS `count` FROM `market_offers` WHERE `itemtype` = " << itemId << " AND `tier` = " << std::to_string(tier) << " AND `sale` = " << action;

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		return 0;
	}
	return result->getNumber<int32_t>("count");
}

MarketOfferEx IOMarket::getOfferByCounter(uint32_t timestamp, uint16_t counter) {
	MarketOfferEx offer;

	const int32_t created = timestamp - g_configManager().getNumber(MARKET_OFFER_DURATION);

	std::ostringstream query;
	query << "SELECT `id`, `sale`, `itemtype`, `amount`, `created`, `price`, `player_id`, `anonymous`, `tier`, (SELECT `name` FROM `players` WHERE `id` = `player_id`) AS `player_name` FROM `market_offers` WHERE `created` = " << created << " AND (`id` & 65535) = " << counter << " LIMIT 1";

	DBResult_ptr result = Database::getInstance().storeQuery(query.str());
	if (!result) {
		offer.id = 0;
		return offer;
	}

	offer.id = result->getNumber<uint32_t>("id");
	offer.type = static_cast<MarketAction_t>(result->getNumber<uint16_t>("sale"));
	offer.amount = result->getNumber<uint16_t>("amount");
	offer.counter = result->getNumber<uint32_t>("id") & 0xFFFF;
	offer.timestamp = result->getNumber<uint32_t>("created");
	offer.price = result->getNumber<uint64_t>("price");
	offer.itemId = result->getNumber<uint16_t>("itemtype");
	offer.playerId = result->getNumber<uint32_t>("player_id");
	offer.tier = getTierFromDatabaseTable(result->getString("tier"));
	if (result->getNumber<uint16_t>("anonymous") == 0) {
		offer.playerName = result->getString("player_name");
	} else {
		offer.playerName = "Anonymous";
	}
	return offer;
}

void IOMarket::createOffer(uint32_t playerId, MarketAction_t action, uint32_t itemId, uint16_t amount, uint64_t price, uint8_t tier, bool anonymous) {
	std::ostringstream query;
	query << "INSERT INTO `market_offers` (`player_id`, `sale`, `itemtype`, `amount`, `created`, `anonymous`, `price`, `tier`) VALUES (" << playerId << ',' << action << ',' << itemId << ',' << amount << ',' << getTimeNow() << ',' << anonymous << ',' << price << ',' << std::to_string(tier) << ')';
	(void)Database::getInstance().insertAndGetId(query.str());
}

void IOMarket::acceptOffer(uint32_t offerId, uint16_t amount) {
	std::ostringstream query;
	query << "UPDATE `market_offers` SET `amount` = `amount` - " << amount << " WHERE `id` = " << offerId;
	Database::getInstance().executeQuery(query.str());
}

void IOMarket::deleteOffer(uint32_t offerId) {
	std::ostringstream query;
	query << "DELETE FROM `market_offers` WHERE `id` = " << offerId;
	Database::getInstance().executeQuery(query.str());
}

void IOMarket::appendHistory(uint32_t playerId, MarketAction_t type, uint16_t itemId, uint16_t amount, uint64_t price, time_t timestamp, uint8_t tier, MarketOfferState_t state) {
	std::ostringstream query;
	query << "INSERT INTO `market_history` (`player_id`, `sale`, `itemtype`, `amount`, `price`, `expires_at`, `inserted`, `state`, `tier`) VALUES ("
		  << playerId << ',' << type << ',' << itemId << ',' << amount << ',' << price << ','
		  << timestamp << ',' << getTimeNow() << ',' << state << ',' << std::to_string(tier) << ')';
	g_databaseTasks().execute(query.str());
}

bool IOMarket::moveOfferToHistory(uint32_t offerId, MarketOfferState_t state) {
	Database &db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `player_id`, `sale`, `itemtype`, `amount`, `price`, `created`, `tier` FROM `market_offers` WHERE `id` = " << offerId;

	DBResult_ptr result = db.storeQuery(query.str());
	if (!result) {
		return false;
	}

	query.str(std::string());
	query << "DELETE FROM `market_offers` WHERE `id` = " << offerId;
	if (!db.executeQuery(query.str())) {
		return false;
	}

	appendHistory(
		result->getNumber<uint32_t>("player_id"),
		static_cast<MarketAction_t>(result->getNumber<uint16_t>("sale")),
		result->getNumber<uint16_t>("itemtype"),
		result->getNumber<uint16_t>("amount"),
		result->getNumber<uint64_t>("price"),
		getTimeNow(),
		getTierFromDatabaseTable(result->getString("tier")), state
	);
	return true;
}

void IOMarket::updateStatistics() {
	auto query = fmt::format(
		"SELECT sale, itemtype, COUNT(price) AS num, MIN(price) AS min, MAX(price) AS max, SUM(price) AS sum, tier "
		"FROM market_history "
		"WHERE state = '{}' "
		"GROUP BY itemtype, sale, tier",
		OFFERSTATE_ACCEPTED
	);

	DBResult_ptr result = g_database().storeQuery(query);
	if (!result) {
		return;
	}

	do {
		MarketStatistics* statistics = nullptr;
		const auto tier = getTierFromDatabaseTable(result->getString("tier"));
		auto itemId = result->getNumber<uint16_t>("itemtype");
		if (result->getNumber<uint16_t>("sale") == MARKETACTION_BUY) {
			statistics = &purchaseStatistics[itemId][tier];
		} else {
			statistics = &saleStatistics[itemId][tier];
		}

		statistics->numTransactions = result->getNumber<uint32_t>("num");
		statistics->lowestPrice = result->getNumber<uint64_t>("min");
		statistics->totalPrice = result->getNumber<uint64_t>("sum");
		statistics->highestPrice = result->getNumber<uint64_t>("max");
	} while (result->next());
}
