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

#include "items/item.hpp"

class House;
class Player;

class BedItem final : public Item {
public:
	explicit BedItem(uint16_t id);

	std::shared_ptr<BedItem> getBed() override {
		return static_self_cast<BedItem>();
	}

	Attr_ReadValue readAttr(AttrTypes_t attr, PropStream &propStream) override;
	void serializeAttr(PropWriteStream &propWriteStream) const override;

	bool canRemove() const override {
		return true;
	}

	uint32_t getSleeper() const {
		return sleeperGUID;
	}

	void setHouse(const std::shared_ptr<House> &h) {
		house = h;
	}

	bool canUse(const std::shared_ptr<Player> &player);

	bool isBedComplete(const std::shared_ptr<BedItem> &nextBedItem) const;

	bool trySleep(const std::shared_ptr<Player> &player);
	bool sleep(const std::shared_ptr<Player> &player);
	void wakeUp(const std::shared_ptr<Player> &player);

	std::shared_ptr<BedItem> getNextBedItem();

	friend class MapCache;

private:
	void updateAppearance(const std::shared_ptr<Player> &player);
	void regeneratePlayer(const std::shared_ptr<Player> &player) const;
	void internalSetSleeper(const std::shared_ptr<Player> &player);
	void internalRemoveSleeper();

	std::shared_ptr<House> house;
	uint64_t sleepStart {};
	uint32_t sleeperGUID {};
};
