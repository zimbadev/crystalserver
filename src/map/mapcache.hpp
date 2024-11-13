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

#include "items/items_definitions.hpp"
#include "utils/mapsector.hpp"

class Map;
class Tile;
class Item;
struct Position;
class FileStream;

#pragma pack(1)
struct BasicItem {
	std::string text;
	// size_t description { 0 };

	uint16_t id { 0 };

	uint16_t charges { 0 }; // Runecharges and Count Too
	uint16_t actionId { 0 };
	uint16_t uniqueId { 0 };
	uint16_t destX { 0 }, destY { 0 };
	uint16_t doorOrDepotId { 0 };

	uint8_t destZ { 0 };

	std::vector<std::shared_ptr<BasicItem>> items;

	bool unserializeItemNode(FileStream &propStream, uint16_t x, uint16_t y, uint8_t z);
	void readAttr(FileStream &propStream);

	size_t hash() const {
		size_t h = 0;
		hash(h);
		return h;
	}

private:
	void hash(size_t &h) const;

	friend struct BasicTile;
};

struct BasicTile {
	std::shared_ptr<BasicItem> ground { nullptr };
	std::vector<std::shared_ptr<BasicItem>> items;

	uint32_t flags { 0 }, houseId { 0 };
	uint8_t type { TILESTATE_NONE };

	bool isStatic { false };

	bool isEmpty(bool ignoreFlag = false) const {
		return (ignoreFlag || flags == 0) && ground == nullptr && items.empty();
	}

	bool isHouse() const {
		return houseId != 0;
	}

	size_t hash() const {
		size_t h = 0;
		hash(h);
		return h;
	}

private:
	void hash(size_t &h) const;
};

#pragma pack()

class MapCache {
public:
	virtual ~MapCache() = default;

	void setBasicTile(uint16_t x, uint16_t y, uint8_t z, const std::shared_ptr<BasicTile> &BasicTile);

	std::shared_ptr<BasicItem> tryReplaceItemFromCache(const std::shared_ptr<BasicItem> &ref) const;

	void flush() const;

	/**
	 * Creates a map sector.
	 * \returns A pointer to that map sector.
	 */
	MapSector* createMapSector(uint32_t x, uint32_t y);
	MapSector* getBestMapSector(uint32_t x, uint32_t y);

	/**
	 * Gets a map sector.
	 * \returns A pointer to that map sector.
	 */
	MapSector* getMapSector(const uint32_t x, const uint32_t y) {
		const auto it = mapSectors.find(x / SECTOR_SIZE | y / SECTOR_SIZE << 16);
		return it != mapSectors.end() ? &it->second : nullptr;
	}

	const MapSector* getMapSector(const uint32_t x, const uint32_t y) const {
		const auto it = mapSectors.find(x / SECTOR_SIZE | y / SECTOR_SIZE << 16);
		return it != mapSectors.end() ? &it->second : nullptr;
	}

protected:
	std::shared_ptr<Tile> getOrCreateTileFromCache(const std::shared_ptr<Floor> &floor, uint16_t x, uint16_t y);

	std::unordered_map<uint32_t, MapSector> mapSectors;

private:
	void parseItemAttr(const std::shared_ptr<BasicItem> &BasicItem, const std::shared_ptr<Item> &item) const;
	std::shared_ptr<Item> createItem(const std::shared_ptr<BasicItem> &BasicItem, Position position);
};
