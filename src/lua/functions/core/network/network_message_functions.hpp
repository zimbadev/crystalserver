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

class NetworkMessageFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaNetworkMessageCreate(lua_State* L);

	static int luaNetworkMessageGetByte(lua_State* L);
	static int luaNetworkMessageGetU16(lua_State* L);
	static int luaNetworkMessageGetU32(lua_State* L);
	static int luaNetworkMessageGetU64(lua_State* L);
	static int luaNetworkMessageGetString(lua_State* L);
	static int luaNetworkMessageGetPosition(lua_State* L);

	static int luaNetworkMessageAddByte(lua_State* L);
	static int luaNetworkMessageAddU16(lua_State* L);
	static int luaNetworkMessageAddU32(lua_State* L);
	static int luaNetworkMessageAddU64(lua_State* L);
	static int luaNetworkMessageAdd8(lua_State* L);
	static int luaNetworkMessageAdd16(lua_State* L);
	static int luaNetworkMessageAdd32(lua_State* L);
	static int luaNetworkMessageAdd64(lua_State* L);
	static int luaNetworkMessageAddString(lua_State* L);
	static int luaNetworkMessageAddPosition(lua_State* L);
	static int luaNetworkMessageAddDouble(lua_State* L);
	static int luaNetworkMessageAddItem(lua_State* L);

	static int luaNetworkMessageReset(lua_State* L);
	static int luaNetworkMessageSkipBytes(lua_State* L);
	static int luaNetworkMessageSendToPlayer(lua_State* L);
};
