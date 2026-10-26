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

class ConditionFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaConditionCreate(lua_State* L);
	static int luaConditionDelete(lua_State* L);

	static int luaConditionGetId(lua_State* L);
	static int luaConditionGetSubId(lua_State* L);
	static int luaConditionGetType(lua_State* L);
	static int luaConditionGetIcons(lua_State* L);
	static int luaConditionGetEndTime(lua_State* L);

	static int luaConditionClone(lua_State* L);

	static int luaConditionGetTicks(lua_State* L);
	static int luaConditionSetTicks(lua_State* L);

	static int luaConditionSetParameter(lua_State* L);
	static int luaConditionSetFormula(lua_State* L);
	static int luaConditionSetOutfit(lua_State* L);

	static int luaConditionAddDamage(lua_State* L);
};
