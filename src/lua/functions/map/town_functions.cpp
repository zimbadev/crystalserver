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

#include "lua/functions/map/town_functions.hpp"

#include "game/game.hpp"
#include "map/town.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void TownFunctions::init(lua_State* L) {
	Lua::registerSharedClass(L, "Town", "", TownFunctions::luaTownCreate);
	Lua::registerMetaMethod(L, "Town", "__eq", Lua::luaUserdataCompare);

	Lua::registerMethod(L, "Town", "getId", TownFunctions::luaTownGetId);
	Lua::registerMethod(L, "Town", "getName", TownFunctions::luaTownGetName);
	Lua::registerMethod(L, "Town", "getTemplePosition", TownFunctions::luaTownGetTemplePosition);
}

int TownFunctions::luaTownCreate(lua_State* L) {
	// Town(id or name)
	std::shared_ptr<Town> town;
	if (Lua::isNumber(L, 2)) {
		town = g_game().map.towns.getTown(Lua::getNumber<uint32_t>(L, 2));
	} else if (Lua::isString(L, 2)) {
		town = g_game().map.towns.getTown(Lua::getString(L, 2));
	} else {
		town = nullptr;
	}

	if (town) {
		Lua::pushUserdata<Town>(L, town);
		Lua::setMetatable(L, -1, "Town");
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int TownFunctions::luaTownGetId(lua_State* L) {
	// town:getId()
	if (const auto &town = Lua::getUserdataShared<Town>(L, 1)) {
		lua_pushnumber(L, town->getID());
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int TownFunctions::luaTownGetName(lua_State* L) {
	// town:getName()
	if (const auto &town = Lua::getUserdataShared<Town>(L, 1)) {
		Lua::pushString(L, town->getName());
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int TownFunctions::luaTownGetTemplePosition(lua_State* L) {
	// town:getTemplePosition()
	if (const auto &town = Lua::getUserdataShared<Town>(L, 1)) {
		Lua::pushPosition(L, town->getTemplePosition());
	} else {
		lua_pushnil(L);
	}
	return 1;
}
