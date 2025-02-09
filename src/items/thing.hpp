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

#include "game/movement/position.hpp"

class Tile;
class Cylinder;
class Item;
class Creature;
class Container;
class Player;

class Thing {
public:
	constexpr Thing() = default;
	virtual ~Thing() = default;

	// non-copyable
	Thing(const Thing &) = delete;
	Thing &operator=(const Thing &) = delete;

	virtual std::string getDescription(int32_t lookDistance) = 0;

	virtual std::shared_ptr<Cylinder> getParent() {
		return nullptr;
	}
	virtual std::shared_ptr<Cylinder> getRealParent() {
		return getParent();
	}

	virtual void setParent(std::weak_ptr<Cylinder>) {
		//
	}

	virtual std::shared_ptr<Tile> getTile() {
		return nullptr;
	}

	virtual const Position &getPosition();
	virtual int32_t getThrowRange() const = 0;
	virtual bool isPushable() = 0;

	virtual std::shared_ptr<Player> getPlayer() {
		return nullptr;
	}
	virtual std::shared_ptr<Container> getContainer() {
		return nullptr;
	}
	virtual std::shared_ptr<const Container> getContainer() const {
		return nullptr;
	}
	virtual std::shared_ptr<Item> getItem() {
		return nullptr;
	}
	virtual std::shared_ptr<const Item> getItem() const {
		return nullptr;
	}
	virtual std::shared_ptr<Creature> getCreature() {
		return nullptr;
	}
	virtual std::shared_ptr<const Creature> getCreature() const {
		return nullptr;
	}
	virtual std::shared_ptr<Cylinder> getCylinder() {
		return nullptr;
	}

	virtual bool isRemoved() {
		return true;
	}
};
