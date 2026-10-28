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
#include "io/iologindata.hpp"
#include "utils/tools.hpp"

void Worlds::load() {
	IOLoginData::createFirstWorld();
	worlds = IOLoginData::loadWorlds();
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
