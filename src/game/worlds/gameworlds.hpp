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

#include "game/game_definitions.hpp"

#pragma once

struct World {
	World() = default;
	World(uint8_t id, std::string name, WorldType_t type, std::string motd, std::string locationName, Location_t location, std::string ip, uint16_t port, uint32_t port_status, uint16_t creation) :
		id(id), name(std::move(name)), type(type), motd(std::move(motd)), locationName(std::move(locationName)), location(location), ip(std::move(ip)), port(port), portStatus(port_status), creation(creation) { }

	uint8_t id = 0;
	std::string name;
	WorldType_t type = WORLDTYPE_OPEN;
	std::string motd;
	std::string locationName;
	Location_t location = Location_t::SouthAmerica;
	std::string ip;
	uint16_t port = 7172;
	uint32_t portStatus = 7173;
	uint16_t creation = 0;

	bool operator==(const World &other) const {
		return id == other.id;
	}
};

namespace std {
	template <>
	struct hash<World> {
		std::size_t operator()(const World &w) const {
			return hash<uint8_t>()(w.id);
		}
	};
}

class Worlds {
public:
	void load();
	void reload();

	[[nodiscard]] std::shared_ptr<World> getWorldConfigsById(uint8_t id) const;
	void setCurrentWorld(const std::shared_ptr<World> &world);
	[[nodiscard]] const std::shared_ptr<World> &getCurrentWorld() const;
	[[nodiscard]] static WorldType_t getWorldTypeIdByKey(const std::string &key);
	[[nodiscard]] static Location_t getWorldLocationByKey(const std::string &key);
	[[nodiscard]] const std::vector<std::shared_ptr<World>> &getWorlds() const noexcept {
		return worlds;
	}

private:
	std::vector<std::shared_ptr<World>> worlds;
	std::shared_ptr<World> m_currentWorld = std::make_shared<World>();
};
