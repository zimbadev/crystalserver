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
class KV;
class Account;

enum class CyclopediaBadge_t : uint8_t;

struct Badge {
	uint8_t m_id = 0;
	CyclopediaBadge_t m_type {};
	std::string m_name {};
	uint16_t m_amount = 0;

	Badge() = default;

	Badge(uint8_t id, CyclopediaBadge_t type, std::string name, uint16_t amount) :
		m_id(id), m_type(type), m_name(std::move(name)), m_amount(amount) { }

	bool operator==(const Badge &other) const {
		return m_id == other.m_id;
	}
};

template <>
struct std::hash<Badge> {
	std::size_t operator()(const Badge &b) const noexcept {
		return hash<uint8_t>()(b.m_id);
	}
};

class PlayerBadge {
public:
	explicit PlayerBadge(Player &player);

	[[nodiscard]] bool hasBadge(uint8_t id) const;
	bool add(uint8_t id, uint32_t timestamp = 0);
	void checkAndUpdateNewBadges();
	void loadUnlockedBadges();
	const std::shared_ptr<KV> &getUnlockedKV();

	// Badge Calculate Functions
	bool accountAge(uint8_t amount) const;
	bool loyalty(uint8_t amount) const;
	std::vector<std::shared_ptr<Player>> getPlayersInfoByAccount(const std::shared_ptr<Account> &acc) const;
	bool accountAllLevel(uint8_t amount) const;
	bool accountAllVocations(uint8_t amount) const;
	[[nodiscard]] bool tournamentParticipation(uint8_t skill) const;
	[[nodiscard]] bool tournamentPoints(uint8_t race) const;

private:
	// {badge ID, time when it was unlocked}
	std::shared_ptr<KV> m_badgeUnlockedKV;
	std::vector<std::pair<Badge, uint32_t>> m_badgesUnlocked;
	Player &m_player;
};
