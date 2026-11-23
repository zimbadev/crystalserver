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

#include "pch.hpp"

#include "game/worlds/gameworlds.hpp"
#include "config/configmanager.hpp"
#include "utils/tools.hpp"

void Worlds::load() {
	const uint8_t id = static_cast<uint8_t>(g_configManager().getNumber(WORLD_ID));
	const std::string name = g_configManager().getString(SERVER_NAME);
	const WorldType_t type = Worlds::getWorldTypeIdByKey(g_configManager().getString(WORLD_TYPE));
	const std::string motd = g_configManager().getString(SERVER_MOTD);
	const std::string locationName = g_configManager().getString(WORLD_LOCATION);
	const Location_t location = Worlds::getWorldLocationByKey(locationName);
	const std::string ip = g_configManager().getString(IP);
	const uint16_t port = static_cast<uint16_t>(g_configManager().getNumber(GAME_PORT));
	const uint32_t portStatus = static_cast<uint32_t>(g_configManager().getNumber(STATUS_PORT));

	auto world = std::make_shared<World>(id, name, type, motd, locationName, location, ip, port, portStatus, 0);
	worlds.push_back(world);
	m_currentWorld = world;

	g_logger().info("World loaded from config: [{}] {} ({})", id, name, g_configManager().getString(WORLD_TYPE));
}

void Worlds::reload() {
	worlds.clear();
	load();
}

[[nodiscard]] std::shared_ptr<World> Worlds::getWorldConfigsById(uint8_t id) const {
	auto it = std::ranges::find_if(worlds, [id](const std::shared_ptr<World> &world) {
		return world->id == id;
	});

	if (it != worlds.end()) {
		return *it;
	}

	g_logger().error(fmt::format("World with the specified ID: {} not found", id));
	return nullptr;
}

void Worlds::setCurrentWorld(const std::shared_ptr<World> &world) {
	m_currentWorld = world;
}

const std::shared_ptr<World> &Worlds::getCurrentWorld() const {
	return m_currentWorld;
}

[[nodiscard]] WorldType_t Worlds::getWorldTypeIdByKey(const std::string &key) {
	const std::string &worldType = asLowerCaseString(key);

	if (worldType == "pvp" || worldType == "open" || worldType == "open-pvp") {
		return WORLDTYPE_OPEN;
	}
	if (worldType == "no-pvp" || worldType == "non-pvp" || worldType == "nopvp" || worldType == "optional") {
		return WORLDTYPE_OPTIONAL;
	}
	if (worldType == "pvp-enforced" || worldType == "hardcore") {
		return WORLDTYPE_HARDCORE;
	}
	if (worldType == "retro-pvp" || worldType == "retropvp") {
		return WORLDTYPE_RETRO_PVP;
	}
	if (worldType == "retro-pvp-enforced" || worldType == "retrohardcore" || worldType == "retro-hardcore") {
		return WORLDTYPE_RETRO_HARDCORE;
	}

	g_logger().error(fmt::format("[Worlds::getWorldTypeIdByKey] - Unable to get world type from string '{}'", worldType));
	return WORLDTYPE_NONE;
}

[[nodiscard]] Location_t Worlds::getWorldLocationByKey(const std::string &key) {
	using enum Location_t;
	const std::string &location = asLowerCaseString(key);

	if (location == "europe") {
		return Europe;
	}
	if (location == "north america") {
		return NorthAmerica;
	}
	if (location == "south america") {
		return SouthAmerica;
	}
	if (location == "oceania") {
		return Oceania;
	}

	g_logger().error(fmt::format("[Worlds::getWorldLocationByKey] - Unable to get world location from string '{}'", location));
	return None;
}
