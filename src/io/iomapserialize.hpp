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

#include "map/map.hpp"

class IOMapSerialize {
public:
	static void loadHouseItems(Map* map);
	static bool saveHouseItems();
	static bool loadHouseInfo();
	static bool saveHouseInfo();

private:
	static bool SaveHouseInfoGuard();
	static bool SaveHouseItemsGuard();
	static void saveItem(PropWriteStream &stream, const std::shared_ptr<Item> &item);
	static void saveTile(PropWriteStream &stream, const std::shared_ptr<Tile> &tile);

	static bool loadContainer(PropStream &propStream, const std::shared_ptr<Container> &container);
	static bool loadItem(PropStream &propStream, const std::shared_ptr<Cylinder> &parent, bool isHouseItem = false);
};
