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

class ValueWrapper;

#ifndef USE_PRECOMPILED_HEADERS
	#include <string>
	#include <optional>
	#include <vector>
	#include <memory>
	#include <parallel_hashmap/phmap.h>
#endif

using MapType = phmap::flat_hash_map<std::string, std::shared_ptr<ValueWrapper>>;

struct lua_State;

class KVFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaKVScoped(lua_State* L);
	static int luaKVSet(lua_State* L);
	static int luaKVGet(lua_State* L);
	static int luaKVKeys(lua_State* L);
	static int luaKVRemove(lua_State* L);

	static std::optional<ValueWrapper> getValueWrapper(lua_State* L);
	static void pushStringValue(lua_State* L, const std::string &value);
	static void pushIntValue(lua_State* L, const int &value);
	static void pushDoubleValue(lua_State* L, const double &value);
	static void pushArrayValue(lua_State* L, const std::vector<ValueWrapper> &value);
	static void pushMapValue(lua_State* L, const MapType &value);
	static void pushValueWrapper(lua_State* L, const ValueWrapper &valueWrapper);
};
