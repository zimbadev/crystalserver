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

#include "enums/player_cyclopedia.hpp"

enum PlayerSex_t : uint8_t;

class Player;
class KV;

struct Title {
	uint8_t m_id = 0;
	CyclopediaTitle_t m_type = CyclopediaTitle_t::NOTHING;
	std::string m_maleName;
	std::string m_femaleName;
	std::string m_description;
	uint32_t m_amount = 0;
	bool m_permanent = false;
	uint8_t m_skill = 0;
	uint16_t m_race = 0;

	Title() = default;

	Title(uint8_t id, CyclopediaTitle_t type, std::string maleName, std::string description, uint32_t amount, bool permanent) :
		m_id(id), m_type(type), m_maleName(std::move(maleName)), m_femaleName(), m_description(std::move(description)),
		m_amount(amount), m_permanent(permanent), m_skill(0), m_race(0) { }

	Title(uint8_t id, CyclopediaTitle_t type, std::string maleName, std::string description, uint32_t amount, bool permanent, std::string femaleName) :
		m_id(id), m_type(type), m_maleName(std::move(maleName)), m_femaleName(std::move(femaleName)), m_description(std::move(description)),
		m_amount(amount), m_permanent(permanent), m_skill(0), m_race(0) { }

	Title(uint8_t id, CyclopediaTitle_t type, std::string maleName, std::string femaleName, std::string description, uint8_t skill) :
		m_id(id), m_type(type), m_maleName(std::move(maleName)), m_femaleName(std::move(femaleName)), m_description(std::move(description)),
		m_amount(0), m_permanent(false), m_skill(skill), m_race(0) { }

	Title(uint8_t id, CyclopediaTitle_t type, uint16_t race, std::string maleName, std::string femaleName, std::string description) :
		m_id(id), m_type(type), m_maleName(std::move(maleName)), m_femaleName(std::move(femaleName)), m_description(std::move(description)),
		m_amount(0), m_permanent(false), m_skill(0), m_race(race) { }

	Title(uint8_t id, CyclopediaTitle_t type, uint16_t race, std::string maleName, std::string femaleName, std::string description, uint32_t amount, bool permanent) :
		m_id(id), m_type(type), m_maleName(std::move(maleName)), m_femaleName(std::move(femaleName)), m_description(std::move(description)),
		m_amount(amount), m_permanent(permanent), m_skill(0), m_race(race) { }

	Title(uint8_t id, CyclopediaTitle_t type, std::string maleName, std::string description, bool permanent) :
		m_id(id), m_type(type), m_maleName(std::move(maleName)), m_femaleName(), m_description(std::move(description)),
		m_amount(0), m_permanent(permanent), m_skill(0), m_race(0) { }

	bool operator==(const Title &other) const {
		return m_id == other.m_id;
	}
};

template <>
struct std::hash<Title> {
	std::size_t operator()(const Title &t) const noexcept {
		return hash<uint8_t>()(t.m_id);
	}
};

class PlayerTitle {
public:
	explicit PlayerTitle(Player &player);

	[[nodiscard]] bool isTitleUnlocked(uint8_t id) const;
	bool manage(bool canAdd, uint8_t id, uint32_t timestamp = 0);
	void remove(const Title &title);
	const std::vector<std::pair<Title, uint32_t>> &getUnlockedTitles();
	[[nodiscard]] uint8_t getCurrentTitle() const;
	void setCurrentTitle(uint8_t id) const;
	std::string getCurrentTitleName() const;
	static const std::string &getNameBySex(PlayerSex_t sex, const std::string &male, const std::string &female);
	void checkAndUpdateNewTitles();
	void loadUnlockedTitles();
	const std::shared_ptr<KV> &getUnlockedKV();

	// Title Calculate Functions
	bool checkGold(uint32_t amount) const;
	bool checkMount(uint32_t amount) const;
	bool checkOutfit(uint32_t amount) const;
	bool checkLevel(uint32_t amount) const;
	bool checkHighscore(uint8_t skill) const;
	bool checkBestiary(const std::string &name, uint16_t race, bool isBoss = false, uint32_t amount = 0) const;
	bool checkLoginStreak(uint32_t amount) const;
	bool checkTask(uint32_t amount) const;
	bool checkMap(uint32_t amount) const;
	bool checkOther(const std::string &name) const;

private:
	// {title ID, time when it was unlocked}
	std::shared_ptr<KV> m_titleUnlockedKV;
	std::vector<std::pair<Title, uint32_t>> m_titlesUnlocked;
	Player &m_player;
};
