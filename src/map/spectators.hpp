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

class Creature;
class Player;
class Monster;
class Npc;
struct Position;

// Forward declaration para CreatureVector
using CreatureVector = std::vector<std::shared_ptr<Creature>>;

struct SpectatorsCache {
	struct FloorData {
		std::optional<CreatureVector> floor;
		std::optional<CreatureVector> multiFloor;
	};

	int32_t minRangeX { 0 };
	int32_t maxRangeX { 0 };
	int32_t minRangeY { 0 };
	int32_t maxRangeY { 0 };

	FloorData creatures;
	FloorData monsters;
	FloorData npcs;
	FloorData players;
};

class Spectators {
public:
	static void clearCache();

	template <typename T>
		requires std::is_base_of_v<Creature, T>
	Spectators find(const Position &centerPos, bool multifloor = false, int32_t minRangeX = 0, int32_t maxRangeX = 0, int32_t minRangeY = 0, int32_t maxRangeY = 0, bool useCache = true) {
		constexpr bool onlyPlayers = std::is_same_v<T, Player>;
		constexpr bool onlyMonsters = std::is_same_v<T, Monster>;
		constexpr bool onlyNpcs = std::is_same_v<T, Npc>;
		return find(centerPos, multifloor, onlyPlayers, onlyMonsters, onlyNpcs, minRangeX, maxRangeX, minRangeY, maxRangeY, useCache);
	}

	template <typename T>
		requires std::is_base_of_v<Creature, T>
	Spectators filter() const {
		constexpr bool onlyPlayers = std::is_same_v<T, Player>;
		constexpr bool onlyMonsters = std::is_same_v<T, Monster>;
		constexpr bool onlyNpcs = std::is_same_v<T, Npc>;
		return filter(onlyPlayers, onlyMonsters, onlyNpcs);
	}

	Spectators excludeMaster() const;
	Spectators excludePlayerMaster() const;

	Spectators insert(const std::shared_ptr<Creature> &creature);
	Spectators insertAll(const CreatureVector &list);
	Spectators join(const Spectators &anotherSpectators) {
		return insertAll(anotherSpectators.creatures);
	}

	bool contains(const std::shared_ptr<Creature> &creature) const {
		return std::ranges::find(creatures, creature) != creatures.end();
	}

	bool erase(const std::shared_ptr<Creature> &creature) {
		return std::erase(creatures, creature) > 0;
	}

	bool empty() const noexcept {
		return creatures.empty();
	}

	size_t size() const noexcept {
		return creatures.size();
	}

	auto begin() const noexcept {
		return creatures.begin();
	}

	auto end() const noexcept {
		return creatures.end();
	}

	const auto &data() const noexcept {
		return creatures;
	}

private:
	static phmap::flat_hash_map<Position, SpectatorsCache> spectatorsCache;

	Spectators find(const Position &centerPos, bool multifloor = false, bool onlyPlayers = false, bool onlyMonsters = false, bool onlyNpcs = false, int32_t minRangeX = 0, int32_t maxRangeX = 0, int32_t minRangeY = 0, int32_t maxRangeY = 0, bool useCache = true);
	CreatureVector getSpectators(const Position &centerPos, bool multifloor = false, bool onlyPlayers = false, bool onlyMonsters = false, bool onlyNpcs = false, int32_t minRangeX = 0, int32_t maxRangeX = 0, int32_t minRangeY = 0, int32_t maxRangeY = 0);

	Spectators filter(bool onlyPlayers, bool onlyMonsters, bool onlyNpcs) const;

	bool checkCache(const SpectatorsCache::FloorData &specData, bool onlyPlayers, bool onlyMonsters, bool onlyNpcs, const Position &centerPos, bool checkDistance, bool multifloor, int32_t minRangeX, int32_t maxRangeX, int32_t minRangeY, int32_t maxRangeY);

	CreatureVector creatures;
};
