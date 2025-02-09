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

#include "lua/scripts/luascript.hpp"
#include "lua/functions/core/game/core_game_functions.hpp"
#include "lua/functions/core/libs/core_libs_functions.hpp"
#include "lua/functions/core/network/core_network_functions.hpp"

class CoreFunctions final : LuaScriptInterface {
public:
	explicit CoreFunctions(lua_State* L) :
		LuaScriptInterface("CoreFunctions") {
		init(L);
	}
	~CoreFunctions() override = default;

	static void init(lua_State* L) {
		CoreGameFunctions::init(L);
		CoreLibsFunctions::init(L);
		CoreNetworkFunctions::init(L);
	}

private:
};
