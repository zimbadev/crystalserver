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

#include "account/account_repository.hpp"

enum class CoinType : uint8_t;
enum class CoinTransactionType : uint8_t;

class AccountRepositoryDB final : public AccountRepository {
public:
	AccountRepositoryDB();

	bool loadByID(const uint32_t &id, std::unique_ptr<AccountInfo> &acc) override;
	bool loadByEmailOrName(bool oldProtocol, const std::string &emailOrName, std::unique_ptr<AccountInfo> &acc) override;
	bool loadBySession(const std::string &esseionKey, std::unique_ptr<AccountInfo> &acc) override;
	bool save(const std::unique_ptr<AccountInfo> &accInfo) override;

	bool getCharacterByAccountIdAndName(const uint32_t &id, const std::string &name) override;

	bool getPassword(const uint32_t &id, std::string &password) override;

	bool getCoins(const uint32_t &id, CoinType coinType, uint32_t &coins) override;
	bool setCoins(const uint32_t &id, CoinType coinType, const uint32_t &amount) override;
	bool registerCoinsTransaction(
		const uint32_t &id,
		CoinTransactionType type,
		uint32_t coins,
		CoinType coinType,
		const std::string &description
	) override;

private:
	std::unordered_map<CoinType, std::string> coinTypeToColumn {};

	bool load(const std::string &query, std::unique_ptr<AccountInfo> &acc);
	bool loadAccountPlayers(std::unique_ptr<AccountInfo> &acc) const;
	void setupLoyaltyInfo(std::unique_ptr<AccountInfo> &acc);
};
