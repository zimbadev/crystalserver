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

#include "lua/functions/map/teleport_functions.hpp"

#include "game/movement/teleport.hpp"
#include "items/item.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void TeleportFunctions::init(lua_State* L) {
	Lua::registerSharedClass(L, "Teleport", "Item", TeleportFunctions::luaTeleportCreate);
	Lua::registerMetaMethod(L, "Teleport", "__eq", Lua::luaUserdataCompare);

	Lua::registerMethod(L, "Teleport", "getDestination", TeleportFunctions::luaTeleportGetDestination);
	Lua::registerMethod(L, "Teleport", "setDestination", TeleportFunctions::luaTeleportSetDestination);
}

// Teleport
int TeleportFunctions::luaTeleportCreate(lua_State* L) {
	// Teleport(uid)
	const uint32_t id = Lua::getNumber<uint32_t>(L, 2);

	const auto &item = Lua::getScriptEnv()->getItemByUID(id);
	if (item && item->getTeleport()) {
		Lua::pushUserdata(L, item);
		Lua::setMetatable(L, -1, "Teleport");
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int TeleportFunctions::luaTeleportGetDestination(lua_State* L) {
	// teleport:getDestination()
	const auto &teleport = Lua::getUserdataShared<Teleport>(L, 1);
	if (teleport) {
		Lua::pushPosition(L, teleport->getDestPos());
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int TeleportFunctions::luaTeleportSetDestination(lua_State* L) {
	// teleport:setDestination(position)
	const auto &teleport = Lua::getUserdataShared<Teleport>(L, 1);
	if (teleport) {
		teleport->setDestPos(Lua::getPosition(L, 2));
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}
