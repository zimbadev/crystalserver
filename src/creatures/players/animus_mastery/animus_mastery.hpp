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
class PropStream;
class PropWriteStream;

class AnimusMastery {
public:
	explicit AnimusMastery(Player &player);

	void add(const std::string &addMonsterType);
	void remove(const std::string &removeMonsterType);

	bool has(const std::string &searchMonsterType) const;

	float getExperienceMultiplier() const;

	uint16_t getPoints() const;

	const std::vector<std::string> &getAnimusMasteries() const;

	void serialize(PropWriteStream &propWriteStream) const;
	bool unserialize(PropStream &propStream);

private:
	Player &m_player;

	float maxMonsterXpMultiplier = 4.0;
	float monsterXpMultiplier = 2.0;
	float monstersXpMultiplier = 0.1;
	uint16_t monstersAmountToMultiply = 10;

	std::vector<std::string> animusMasteries;
};
