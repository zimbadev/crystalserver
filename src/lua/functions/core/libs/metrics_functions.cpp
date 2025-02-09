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

#include "lua/functions/core/libs/metrics_functions.hpp"

#include "lib/metrics/metrics.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void MetricsFunctions::init(lua_State* L) {
	Lua::registerTable(L, "metrics");
	Lua::registerMethod(L, "metrics", "addCounter", MetricsFunctions::luaMetricsAddCounter);
}

// Metrics
int MetricsFunctions::luaMetricsAddCounter(lua_State* L) {
	// metrics.addCounter(name, value, attributes)
	const auto name = Lua::getString(L, 1);
	const auto value = Lua::getNumber<double>(L, 2);
	const auto attributes = getAttributes(L, 3);
	g_metrics().addCounter(name, value, attributes);
	return 1;
}

std::map<std::string, std::string> MetricsFunctions::getAttributes(lua_State* L, int32_t index) {
	std::map<std::string, std::string> attributes;
	if (Lua::isTable(L, index)) {
		lua_pushnil(L);
		while (lua_next(L, index) != 0) {
			attributes[Lua::getString(L, -2)] = Lua::getString(L, -1);
			lua_pop(L, 1);
		}
	}
	return attributes;
}
