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

class AccountRepositoryDB final : public AccountRepository {
public:
	AccountRepositoryDB();

	bool loadByID(const uint32_t &id, AccountInfo &acc) override;
	bool loadByEmailOrName(bool oldProtocol, const std::string &emailOrName, AccountInfo &acc) override;
	bool loadBySession(const std::string &esseionKey, AccountInfo &acc) override;
	bool save(const AccountInfo &accInfo) override;

	bool getCharacterByAccountIdAndName(const uint32_t &id, const std::string &name) override;

	bool getPassword(const uint32_t &id, std::string &password) override;

	bool getCoins(const uint32_t &id, const uint8_t &type, uint32_t &coins) override;
	bool setCoins(const uint32_t &id, const uint8_t &type, const uint32_t &amount) override;
	bool registerCoinsTransaction(
		const uint32_t &id,
		uint8_t type,
		uint32_t coins,
		const uint8_t &coinType,
		const std::string &description
	) override;

private:
	const std::map<uint8_t, std::string> coinTypeToColumn;
	bool load(const std::string &query, AccountInfo &acc);
	bool loadAccountPlayers(AccountInfo &acc);
	void setupLoyaltyInfo(AccountInfo &acc);
};
