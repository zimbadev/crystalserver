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

#include "items/cylinder.hpp"
#include "items/item.hpp"

class Tile;

class Teleport final : public Item, public Cylinder {
public:
	explicit Teleport(uint16_t type) :
		Item(type) {};

	std::shared_ptr<Teleport> getTeleport() override {
		return static_self_cast<Teleport>();
	}

	std::shared_ptr<Cylinder> getCylinder() override {
		return getTeleport();
	}

	// serialization
	Attr_ReadValue readAttr(AttrTypes_t attr, PropStream &propStream) override;
	void serializeAttr(PropWriteStream &propWriteStream) const override;

	const Position &getDestPos() const {
		return destPos;
	}
	void setDestPos(Position pos) {
		destPos = pos;
	}

	bool checkInfinityLoop(const std::shared_ptr<Tile> &destTile);

	// cylinder implementations
	ReturnValue queryAdd(int32_t index, const std::shared_ptr<Thing> &thing, uint32_t count, uint32_t flags, const std::shared_ptr<Creature> &actor = nullptr) override;
	ReturnValue queryMaxCount(int32_t index, const std::shared_ptr<Thing> &thing, uint32_t count, uint32_t &maxQueryCount, uint32_t flags) override;
	ReturnValue queryRemove(const std::shared_ptr<Thing> &thing, uint32_t count, uint32_t flags, const std::shared_ptr<Creature> &actor = nullptr) override;
	std::shared_ptr<Cylinder> queryDestination(int32_t &index, const std::shared_ptr<Thing> &thing, std::shared_ptr<Item> &destItem, uint32_t &flags) override;

	void addThing(const std::shared_ptr<Thing> &thing) override;
	void addThing(int32_t index, const std::shared_ptr<Thing> &thing) override;

	void updateThing(const std::shared_ptr<Thing> &thing, uint16_t itemId, uint32_t count) override;
	void replaceThing(uint32_t index, const std::shared_ptr<Thing> &thing) override;

	void removeThing(const std::shared_ptr<Thing> &thing, uint32_t count) override;

	void postAddNotification(const std::shared_ptr<Thing> &thing, const std::shared_ptr<Cylinder> &oldParent, int32_t index, CylinderLink_t link = LINK_OWNER) override;
	void postRemoveNotification(const std::shared_ptr<Thing> &thing, const std::shared_ptr<Cylinder> &newParent, int32_t index, CylinderLink_t link = LINK_OWNER) override;

private:
	Position destPos;
};
