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

class GuildFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaGuildCreate(lua_State* L);

	static int luaGuildGetId(lua_State* L);
	static int luaGuildGetName(lua_State* L);
	static int luaGuildGetMembersOnline(lua_State* L);

	static int luaGuildGetBankBalance(lua_State* L);
	static int luaGuildSetBankBalance(lua_State* L);

	static int luaGuildAddRank(lua_State* L);
	static int luaGuildGetRankById(lua_State* L);
	static int luaGuildGetRankByLevel(lua_State* L);

	static int luaGuildGetMotd(lua_State* L);
	static int luaGuildSetMotd(lua_State* L);
};
