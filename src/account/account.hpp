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

struct AccountInfo;
#include "account/account_info.hpp"

class Account {
public:
	explicit Account(const uint32_t &id);
	explicit Account(std::string descriptor);

	/** Coins
	 * @brief Get the amount of coins that the account has from database.
	 *
	 * @param type Type of the coin
	 *
	 * @return uint32_t Number of coins
	 * @return AccountErrors_t AccountErrors_t::Ok(0) Success, otherwise Fail.
	 */
	[[nodiscard]] std::tuple<uint32_t, uint8_t> getCoins(const uint8_t &type) const;

	/**
	 * @brief Add coins to the account.
	 *
	 * @param type Type of the coin
	 * @param amount Amount of coins to be added
	 * @return AccountErrors_t AccountErrors_t::Ok(0) Success, otherwise Fail.
	 */
	uint8_t addCoins(const uint8_t &type, const uint32_t &amount, const std::string &detail = "ADD Coins");

	/**
	 * @brief Removes coins from the account.
	 *
	 * @param type Type of the coin
	 * @param amount Amount of coins to be removed
	 * @return AccountErrors_t AccountErrors_t::Ok(0) Success, otherwise Fail.
	 */
	uint8_t removeCoins(const uint8_t &type, const uint32_t &amount, const std::string &detail = "REMOVE Coins");

	/**
	 * @brief Registers a coin transaction.
	 *
	 * @param type Type of the coin
	 * @param amount Amount of coins to be added
	 * @param detail Detail of the transaction
	 */
	void registerCoinTransaction(const uint8_t &transactionType, const uint8_t &type, const uint32_t &amount, const std::string &detail);

	/***************************************************************************
	 * Account Load/Save
	 **************************************************************************/

	/**
	 * @brief Save Account.
	 *
	 * @return AccountErrors_t AccountErrors_t::Ok(0) Success, otherwise Fail.
	 */
	uint8_t save();

	/**
	 * @brief Load Account Information.
	 *
	 * @return AccountErrors_t AccountErrors_t::Ok(0) Success, otherwise Fail.
	 */
	uint8_t load();

	/**
	 * @brief Re-Load Account Information to get update information(mainly the
	 * players list).
	 *
	 * @return AccountErrors_t AccountErrors_t::Ok(0) Success, otherwise Fail.
	 */
	uint8_t reload();

	/***************************************************************************
	 * Setters and Getters
	 **************************************************************************/

	[[nodiscard]] uint32_t getID() const;

	/**
	 * @brief Get the Descriptor object
	 * @warning Descriptors are credentials that may be used to login into the account. DO NOT BPUBLISH THIS INFORMATION.
	 *
	 * @return std::string
	 */
	std::string getDescriptor() const;

	std::string getPassword();

	void addPremiumDays(const int32_t &days);
	void setPremiumDays(const int32_t &days);
	[[nodiscard]] uint32_t getPremiumRemainingDays() const;

	[[nodiscard]] uint32_t getPremiumDaysPurchased() const;

	[[nodiscard]] uint32_t getAccountAgeInDays() const;

	[[nodiscard]] time_t getPremiumLastDay() const;

	uint8_t setAccountType(const uint8_t &accountType);
	[[nodiscard]] uint8_t getAccountType() const;

	void updatePremiumTime();

	void setHouseBidId(uint32_t houseId);

	uint32_t getHouseBidId() const;

	std::tuple<phmap::flat_hash_map<std::string, uint64_t>, uint8_t> getAccountPlayers() const;

	// Old protocol compat
	void setProtocolCompat(bool toggle);

	bool getProtocolCompat() const;

	bool authenticate();
	bool authenticate(const std::string &secret);

	bool authenticateSession();

	bool authenticatePassword(const std::string &password);

private:
	std::string m_descriptor;
	AccountInfo m_account;
	bool m_accLoaded = false;
};
