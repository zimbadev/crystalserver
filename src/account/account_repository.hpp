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

enum class CoinType : uint8_t;
enum class CoinTransactionType : uint8_t;

class AccountRepository {
public:
	AccountRepository() = default;
	virtual ~AccountRepository() = default;

	// Singleton - ensures we don't accidentally copy it
	AccountRepository(const AccountRepository &) = delete;
	void operator=(const AccountRepository &) = delete;

	static AccountRepository &getInstance();

	virtual bool loadByID(const uint32_t &id, std::unique_ptr<AccountInfo> &acc) = 0;
	virtual bool loadByEmailOrName(bool oldProtocol, const std::string &emailOrName, std::unique_ptr<AccountInfo> &acc) = 0;
	virtual bool loadBySession(const std::string &email, std::unique_ptr<AccountInfo> &acc) = 0;
	virtual bool save(const std::unique_ptr<AccountInfo> &accInfo) = 0;

	virtual bool getCharacterByAccountIdAndName(const uint32_t &id, const std::string &name) = 0;

	virtual bool getPassword(const uint32_t &id, std::string &password) = 0;

	virtual bool getCoins(const uint32_t &id, CoinType coinType, uint32_t &coins) = 0;
	virtual bool setCoins(const uint32_t &id, CoinType coinType, const uint32_t &amount) = 0;
	virtual bool registerCoinsTransaction(
		const uint32_t &id,
		CoinTransactionType type,
		uint32_t coins,
		CoinType coinType,
		const std::string &description
	) = 0;
};

constexpr auto g_accountRepository = AccountRepository::getInstance;
