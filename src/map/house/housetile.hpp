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

#include "items/tile.hpp"

class House;

class HouseTile final : public DynamicTile {
public:
	using Tile::addThing;

	HouseTile(const Position &position, std::shared_ptr<House> house);
	HouseTile(int32_t x, int32_t y, int32_t z, std::shared_ptr<House> house);

	// cylinder implementations
	ReturnValue queryAdd(int32_t index, const std::shared_ptr<Thing> &thing, uint32_t count, uint32_t flags, const std::shared_ptr<Creature> &actor = nullptr) override;

	std::shared_ptr<Cylinder> queryDestination(int32_t &index, const std::shared_ptr<Thing> &thing, std::shared_ptr<Item> &destItem, uint32_t &flags) override;

	ReturnValue queryRemove(const std::shared_ptr<Thing> &thing, uint32_t count, uint32_t flags, const std::shared_ptr<Creature> &actor = nullptr) override;

	void addThing(int32_t index, const std::shared_ptr<Thing> &thing) override;
	void internalAddThing(uint32_t index, const std::shared_ptr<Thing> &thing) override;

	std::shared_ptr<House> getHouse() override {
		return house;
	}

private:
	void updateHouse(const std::shared_ptr<Item> &item) const;

	std::shared_ptr<House> house;
};
