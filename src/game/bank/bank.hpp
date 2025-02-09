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

class Player;
class Guild;

class Bankable {
public:
	virtual void setBankBalance(uint64_t amount) = 0;
	[[nodiscard]] virtual uint64_t getBankBalance() const = 0;
	virtual ~Bankable() = default;
	virtual std::shared_ptr<Player> getPlayer() {
		return nullptr;
	}
	virtual bool isGuild() {
		return false;
	}
	virtual void setOnline(bool online) = 0;
	[[nodiscard]] virtual bool isOnline() const = 0;
};

class Bank : public SharedObject {
public:
	explicit Bank(const std::shared_ptr<Bankable> &bankable);
	~Bank() override;

	// Deleted copy constructor and assignment operator.
	Bank(const Bank &) = delete;
	Bank &operator=(const Bank &) = delete;

	// Bank functions by Bankable pointer; these are the only ones that should actually perform any logic.
	bool credit(uint64_t amount);
	bool debit(uint64_t amount);
	bool balance(uint64_t amount) const;
	uint64_t balance();
	bool hasBalance(uint64_t amount);
	bool transferTo(const std::shared_ptr<Bank> &destination, uint64_t amount);
	bool withdraw(const std::shared_ptr<Player> &player, uint64_t amount);
	bool deposit(const std::shared_ptr<Bank> &destination);
	bool deposit(const std::shared_ptr<Bank> &destination, uint64_t amount);

private:
	std::shared_ptr<Bankable> getBankable() const {
		return m_bankable;
	}
	std::shared_ptr<Bankable> m_bankable;
};
