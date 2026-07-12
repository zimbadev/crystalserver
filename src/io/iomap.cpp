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

#include "io/iomap.hpp"

#include "game/movement/teleport.hpp"
#include "game/game.hpp"
#include "io/filestream.hpp"

/*
    OTBM_ROOTV1
    |
    |--- OTBM_MAP_DATA
    |	|
    |	|--- OTBM_TILE_AREA
    |	|	|--- OTBM_TILE
    |	|	|--- OTBM_TILE_SQUARE (not implemented)
    |	|	|--- OTBM_TILE_REF (not implemented)
    |	|	|--- OTBM_HOUSETILE
    |	|
    |	|--- OTBM_SPAWNS (not implemented)
    |	|	|--- OTBM_SPAWN_AREA (not implemented)
    |	|	|--- OTBM_MONSTER (not implemented)
    |	|
    |	|--- OTBM_TOWNS
    |	|	|--- OTBM_TOWN
    |	|
    |	|--- OTBM_WAYPOINTS
    |		|--- OTBM_WAYPOINT
    |
    |--- OTBM_ITEM_DEF (not implemented)
*/

namespace {
	constexpr OTB::Identifier OTBM_IDENTIFIER { { 'O', 'T', 'B', 'M' } };

	bool isGzipFile(const std::string &path) {
		FILE* file = fopen(path.c_str(), "rb");
		if (!file) {
			return false;
		}

		uint8_t header[2] = { 0, 0 };
		const size_t read = fread(header, 1, sizeof(header), file);
		fclose(file);
		return read == sizeof(header) && header[0] == 0x1f && header[1] == 0x8b;
	}

	bool gzipDecompressFile(const std::string &path, std::vector<uint8_t> &out) {
		gzFile gz = gzopen(path.c_str(), "rb");
		if (!gz) {
			return false;
		}

		out.clear();
		out.reserve(64 * 1024 * 1024);

		uint8_t buffer[64 * 1024];
		while (true) {
			const int bytesRead = gzread(gz, buffer, sizeof(buffer));
			if (bytesRead < 0) {
				gzclose(gz);
				return false;
			}
			if (bytesRead == 0) {
				break;
			}
			out.insert(out.end(), buffer, buffer + bytesRead);
		}

		return gzclose(gz) == Z_OK;
	}

	bool hasValidMapHeader(const std::vector<uint8_t> &data) {
		if (data.size() < OTBM_IDENTIFIER.size() + 1) {
			return false;
		}

		if (std::memcmp(data.data(), OTBM_IDENTIFIER.data(), OTBM_IDENTIFIER.size()) == 0) {
			return true;
		}

		// RME may save maps with a four-byte null identifier instead of "OTBM".
		return data[0] == 0 && data[1] == 0 && data[2] == 0 && data[3] == 0;
	}
} // namespace

void IOMap::loadMap(Map* map, const Position &pos) {
	Benchmark bm_mapLoad;

	const std::string mapPath = map->path.string();
	const bool compressedMapEnabled = g_configManager().getBoolean(TOGGLE_COMPRESSED_MAP);
	const bool gzipMap = isGzipFile(mapPath);

	if (gzipMap && !compressedMapEnabled) {
		throw IOMapException("Map file is compressed. Enable toggleCompressedMap in config.lua to load it.");
	}

	std::vector<uint8_t> decompressedData;
	const char* begin = nullptr;
	const char* end = nullptr;
	mio::mmap_source fileByte;

	if (gzipMap) {
		if (!gzipDecompressFile(mapPath, decompressedData)) {
			throw IOMapException("Could not decompress compressed map file: " + mapPath);
		}
		if (!hasValidMapHeader(decompressedData)) {
			throw IOMapException("Decompressed map file does not contain a valid map header.");
		}

		begin = reinterpret_cast<const char*>(decompressedData.data() + OTBM_IDENTIFIER.size());
		end = reinterpret_cast<const char*>(decompressedData.data() + decompressedData.size());
		g_logger().info("Loaded compressed map {}", map->path.filename().string());
	} else {
		fileByte = mio::mmap_source(mapPath);
		begin = fileByte.begin() + OTBM_IDENTIFIER.size();
		end = fileByte.end();
	}

	FileStream stream { begin, end };

	if (!stream.startNode()) {
		throw IOMapException("Could not read map node.");
	}

	stream.skip(1); // Type Node

	uint32_t version = stream.getU32();
	map->width = stream.getU16();
	map->height = stream.getU16();
	uint32_t majorVersionItems = stream.getU32();
	stream.getU32(); // minorVersionItems

	if (version > 5) {
		throw IOMapException("This map need to be upgraded by using the latest map editor version to be able to load correctly.");
	}

	if (stream.startNode(OTBM_MAP_DATA)) {
		parseMapDataAttributes(stream, map);
		parseTileArea(stream, *map, pos);
		stream.endNode();
	}

	parseTowns(stream, *map);
	parseWaypoints(stream, *map);

	map->flush();

	g_logger().debug("Map Loaded {} ({}x{}) in {} milliseconds", map->path.filename().string(), map->width, map->height, bm_mapLoad.duration());
}

void IOMap::parseMapDataAttributes(FileStream &stream, Map* map) {
	bool end = false;
	while (!end) {
		const uint8_t attr = stream.getU8();
		switch (attr) {
			case OTBM_ATTR_DESCRIPTION: {
				stream.getString();
			} break;

			case OTBM_ATTR_EXT_SPAWN_MONSTER_FILE: {
				map->monsterfile = map->path.string().substr(0, map->path.string().rfind('/') + 1);
				map->monsterfile += stream.getString();
			} break;

			case OTBM_ATTR_EXT_SPAWN_NPC_FILE: {
				map->npcfile = map->path.string().substr(0, map->path.string().rfind('/') + 1);
				map->npcfile += stream.getString();
			} break;
			case OTBM_ATTR_EXT_HOUSE_FILE: {
				map->housefile = map->path.string().substr(0, map->path.string().rfind('/') + 1);
				map->housefile += stream.getString();
			} break;

			case OTBM_ATTR_EXT_ZONE_FILE: {
				map->zonesfile = map->path.string().substr(0, map->path.string().rfind('/') + 1);
				map->zonesfile += stream.getString();
			} break;

			default:
				stream.back();
				end = true;
				break;
		}
	}
}

void IOMap::parseTileArea(FileStream &stream, Map &map, const Position &pos) {
	while (stream.startNode(OTBM_TILE_AREA)) {
		const uint16_t base_x = stream.getU16();
		const uint16_t base_y = stream.getU16();
		const uint8_t base_z = stream.getU8();

		while (stream.startNode()) {
			const uint8_t tileType = stream.getU8();
			if (tileType != OTBM_HOUSETILE && tileType != OTBM_TILE) {
				throw IOMapException("Could not read tile type node.");
			}

			const auto tile = std::make_shared<BasicTile>();

			const uint8_t tileCoordsX = stream.getU8();
			const uint8_t tileCoordsY = stream.getU8();

			const uint16_t x = base_x + tileCoordsX + pos.x;
			const uint16_t y = base_y + tileCoordsY + pos.y;
			const auto z = static_cast<uint8_t>(base_z + pos.z);

			if (tileType == OTBM_HOUSETILE) {
				tile->houseId = stream.getU32();
				if (!map.houses.addHouse(tile->houseId)) {
					throw IOMapException(fmt::format("[x:{}, y:{}, z:{}] Could not create house id: {}", x, y, z, tile->houseId));
				}
			}

			if (stream.isProp(OTBM_ATTR_TILE_FLAGS)) {
				const uint32_t flags = stream.getU32();
				if ((flags & OTBM_TILEFLAG_PROTECTIONZONE) != 0) {
					tile->flags |= TILESTATE_PROTECTIONZONE;
				} else if ((flags & OTBM_TILEFLAG_NOPVPZONE) != 0) {
					tile->flags |= TILESTATE_NOPVPZONE;
				} else if ((flags & OTBM_TILEFLAG_PVPZONE) != 0) {
					tile->flags |= TILESTATE_PVPZONE;
				}

				if ((flags & OTBM_TILEFLAG_NOLOGOUT) != 0) {
					tile->flags |= TILESTATE_NOLOGOUT;
				}
			}

			if (stream.isProp(OTBM_ATTR_ITEM)) {
				const uint16_t id = stream.getU16();
				const auto &iType = Item::items[id];

				if (!tile->isHouse() || (!iType.isBed())) {

					const auto item = std::make_shared<BasicItem>();
					item->id = id;

					if (tile->isHouse() && iType.movable) {
						g_logger().warn("[IOMap::loadMap] - "
						                "Movable item with ID: {}, in house: {}, "
						                "at position: x {}, y {}, z {}",
						                id, tile->houseId, x, y, z);
					} else if (iType.isGroundTile()) {
						tile->ground = map.tryReplaceItemFromCache(item);
					} else {
						tile->items.emplace_back(map.tryReplaceItemFromCache(item));
					}
				}
			}

			while (stream.startNode()) {
				auto type = stream.getU8();
				switch (type) {
					case OTBM_ITEM: {
						const uint16_t id = stream.getU16();

						const auto &iType = Item::items[id];

						const auto item = std::make_shared<BasicItem>();
						item->id = id;

						if (!item->unserializeItemNode(stream, x, y, z)) {
							throw IOMapException(fmt::format("[x:{}, y:{}, z:{}] Failed to load item {}, Node Type.", x, y, z, id));
						}

						if (tile->isHouse() && (iType.isBed() || iType.isTrashHolder())) {
							// nothing
						} else if (tile->isHouse() && iType.movable) {
							g_logger().warn("[IOMap::loadMap] - "
							                "Movable item with ID: {}, in house: {}, "
							                "at position: x {}, y {}, z {}",
							                id, tile->houseId, x, y, z);
						} else if (iType.isGroundTile()) {
							tile->ground = map.tryReplaceItemFromCache(item);
						} else {
							tile->items.emplace_back(map.tryReplaceItemFromCache(item));
						}
					} break;
					case OTBM_TILE_ZONE: {
						const auto zoneCount = stream.getU16();
						for (uint16_t i = 0; i < zoneCount; ++i) {
							const auto zoneId = stream.getU16();
							if (!zoneId) {
								throw IOMapException(fmt::format("[x:{}, y:{}, z:{}] Invalid zone id.", x, y, z));
							}
							auto zone = Zone::getZone(zoneId);
							zone->addPosition(Position(x, y, z));
						}
					} break;
					default:
						throw IOMapException(fmt::format("[x:{}, y:{}, z:{}] Could not read item/zone node.", x, y, z));
				}

				if (!stream.endNode()) {
					throw IOMapException(fmt::format("[x:{}, y:{}, z:{}] Could not end node.", x, y, z));
				}
			}

			if (!stream.endNode()) {
				throw IOMapException(fmt::format("[x:{}, y:{}, z:{}] Could not end node.", x, y, z));
			}

			if (tile->isEmpty(true)) {
				continue;
			}

			map.setBasicTile(x, y, z, tile);
		}

		if (!stream.endNode()) {
			throw IOMapException("Could not end node.");
		}
	}
}

void IOMap::parseTowns(FileStream &stream, Map &map) {
	if (!stream.startNode(OTBM_TOWNS)) {
		throw IOMapException("Could not read towns node.");
	}

	while (stream.startNode(OTBM_TOWN)) {
		const uint32_t townId = stream.getU32();
		const auto &townName = stream.getString();
		const uint16_t x = stream.getU16();
		const uint16_t y = stream.getU16();
		const uint8_t z = stream.getU8();

		auto town = map.towns.getOrCreateTown(townId);
		town->setName(townName);
		town->setTemplePos(Position(x, y, z));

		if (!stream.endNode()) {
			throw IOMapException("Could not end node.");
		}
	}

	if (!stream.endNode()) {
		throw IOMapException("Could not end node.");
	}
}

void IOMap::parseWaypoints(FileStream &stream, Map &map) {
	if (!stream.startNode(OTBM_WAYPOINTS)) {
		throw IOMapException("Could not read waypoints node.");
	}

	while (stream.startNode(OTBM_WAYPOINT)) {
		const auto &name = stream.getString();
		const uint16_t x = stream.getU16();
		const uint16_t y = stream.getU16();
		const uint8_t z = stream.getU8();

		map.waypoints[name] = Position(x, y, z);

		if (!stream.endNode()) {
			throw IOMapException("Could not end node.");
		}
	}

	if (!stream.endNode()) {
		throw IOMapException("Could not end node.");
	}
}
