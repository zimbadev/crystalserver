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

#include "game/movement/position.hpp"

#include "utils/tools.hpp"

double Position::getEuclideanDistance(const Position &p1, const Position &p2) {
	int32_t dx = Position::getDistanceX(p1, p2);
	int32_t dy = Position::getDistanceY(p1, p2);
	return std::sqrt(dx * dx + dy * dy);
}

Direction Position::getRandomDirection() {
	static std::vector<Direction> dirList {
		DIRECTION_NORTH,
		DIRECTION_WEST,
		DIRECTION_EAST,
		DIRECTION_SOUTH
	};
	std::shuffle(dirList.begin(), dirList.end(), getRandomGenerator());

	return dirList.front();
}

std::ostream &operator<<(std::ostream &os, const Position &pos) {
	return os << pos.toString();
}

std::ostream &operator<<(std::ostream &os, const Direction &dir) {
	static const std::map<Direction, std::string> directionStrings = {
		{ DIRECTION_NORTH, "North" },
		{ DIRECTION_EAST, "East" },
		{ DIRECTION_WEST, "West" },
		{ DIRECTION_SOUTH, "South" },
		{ DIRECTION_SOUTHWEST, "South-West" },
		{ DIRECTION_SOUTHEAST, "South-East" },
		{ DIRECTION_NORTHWEST, "North-West" },
		{ DIRECTION_NORTHEAST, "North-East" }
	};

	auto it = directionStrings.find(dir);
	if (it != directionStrings.end()) {
		return os << it->second;
	}

	return os;
}
