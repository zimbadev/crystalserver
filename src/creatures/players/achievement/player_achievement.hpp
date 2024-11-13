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

struct Achievement {
	Achievement() = default;

	std::string name {};
	std::string description {};

	bool secret = false;

	uint8_t grade = 0;
	uint8_t points = 0;

	uint16_t id = 0;
};

class PlayerAchievement {
public:
	explicit PlayerAchievement(Player &player);
	bool add(uint16_t id, bool message = true, uint32_t timestamp = 0);
	bool remove(uint16_t id);
	[[nodiscard]] bool isUnlocked(uint16_t id) const;
	[[nodiscard]] uint16_t getPoints() const;
	void addPoints(uint16_t toAddPoints) const;
	void removePoints(uint16_t toRemovePoints) const;
	[[nodiscard]] std::vector<std::pair<uint16_t, uint32_t>> getUnlockedAchievements() const;
	void loadUnlockedAchievements();
	void sendUnlockedSecretAchievements() const;
	const std::shared_ptr<KV> &getUnlockedKV();

private:
	// {achievement ID, time when it was unlocked}
	std::shared_ptr<KV> m_unlockedKV;
	std::vector<std::pair<uint16_t, uint32_t>> m_achievementsUnlocked;
	Player &m_player;
};
