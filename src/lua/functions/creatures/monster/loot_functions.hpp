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

class LootFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaCreateLoot(lua_State* L);
	static int luaDeleteLoot(lua_State* L);
	static int luaLootSetId(lua_State* L);
	static int luaLootSetIdFromName(lua_State* L);
	static int luaLootSetMinCount(lua_State* L);
	static int luaLootSetMaxCount(lua_State* L);
	static int luaLootSetSubType(lua_State* L);
	static int luaLootSetChance(lua_State* L);
	static int luaLootSetActionId(lua_State* L);
	static int luaLootSetText(lua_State* L);
	static int luaLootSetNameItem(lua_State* L);
	static int luaLootSetArticle(lua_State* L);
	static int luaLootSetAttack(lua_State* L);
	static int luaLootSetDefense(lua_State* L);
	static int luaLootSetExtraDefense(lua_State* L);
	static int luaLootSetArmor(lua_State* L);
	static int luaLootSetShootRange(lua_State* L);
	static int luaLootSetHitChance(lua_State* L);
	static int luaLootSetUnique(lua_State* L);
	static int luaLootAddChildLoot(lua_State* L);
};
