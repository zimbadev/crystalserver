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

class ContainerFunctions {
private:
	static void init(lua_State* L);

	static int luaContainerCreate(lua_State* L);

	static int luaContainerGetSize(lua_State* L);
	static int luaContainerGetMaxCapacity(lua_State* L);
	static int luaContainerGetCapacity(lua_State* L);
	static int luaContainerGetEmptySlots(lua_State* L);

	static int luaContainerGetContentDescription(lua_State* L);
	static int luaContainerGetItems(lua_State* L);
	static int luaContainerGetItemHoldingCount(lua_State* L);
	static int luaContainerGetItemCountById(lua_State* L);

	static int luaContainerGetItem(lua_State* L);
	static int luaContainerHasItem(lua_State* L);
	static int luaContainerAddItem(lua_State* L);
	static int luaContainerAddItemEx(lua_State* L);

	static int luaContainerGetCorpseOwner(lua_State* L);
	static int luaContainerRegisterReward(lua_State* L);

	friend class ItemFunctions;
};
