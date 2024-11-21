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

#include "lua/functions/core/game/config_functions.hpp"

#include "config/configmanager.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void ConfigFunctions::init(lua_State* L) {
	Lua::registerTable(L, "configManager");
	Lua::registerMethod(L, "configManager", "getString", luaConfigManagerGetString);
	Lua::registerMethod(L, "configManager", "getNumber", luaConfigManagerGetNumber);
	Lua::registerMethod(L, "configManager", "getBoolean", luaConfigManagerGetBoolean);
	Lua::registerMethod(L, "configManager", "getFloat", luaConfigManagerGetFloat);

#define registerMagicEnumIn(L, tableName, enumValue)         \
	do {                                                     \
		auto name = magic_enum::enum_name(enumValue).data(); \
		Lua::registerVariable(L, tableName, name, value);    \
	} while (0)
	Lua::registerTable(L, "configKeys");
	for (auto value : magic_enum::enum_values<ConfigKey_t>()) {
		auto enumName = magic_enum::enum_name(value).data();
		if (enumName) {
			registerMagicEnumIn(L, "configKeys", value);
			g_logger().debug("Registering ConfigManager enum name '{}' value '{}' to lua", enumName, fmt::underlying(value));
		}
	}
#undef registerMagicEnumIn
}

int ConfigFunctions::luaConfigManagerGetString(lua_State* L) {
	const auto key = Lua::getNumber<ConfigKey_t>(L, -1);
	if (!key) {
		Lua::reportErrorFunc("Wrong enum");
		return 1;
	}

	Lua::pushString(L, g_configManager().getString(Lua::getNumber<ConfigKey_t>(L, -1)));
	return 1;
}

int ConfigFunctions::luaConfigManagerGetNumber(lua_State* L) {
	const auto key = Lua::getNumber<ConfigKey_t>(L, -1);
	if (!key) {
		Lua::reportErrorFunc("Wrong enum");
		return 1;
	}

	lua_pushnumber(L, g_configManager().getNumber(Lua::getNumber<ConfigKey_t>(L, -1)));
	return 1;
}

int ConfigFunctions::luaConfigManagerGetBoolean(lua_State* L) {
	const auto key = Lua::getNumber<ConfigKey_t>(L, -1);
	if (!key) {
		Lua::reportErrorFunc("Wrong enum");
		return 1;
	}

	Lua::pushBoolean(L, g_configManager().getBoolean(Lua::getNumber<ConfigKey_t>(L, -1)));
	return 1;
}

int ConfigFunctions::luaConfigManagerGetFloat(lua_State* L) {
	// configManager.getFloat(key, shouldRound = true)

	// Ensure the first argument (key) is provided and is a valid enum
	const auto key = Lua::getNumber<ConfigKey_t>(L, 1);
	if (!key) {
		Lua::reportErrorFunc("Wrong enum");
		return 1;
	}

	// Check if the second argument (shouldRound) is provided and is a boolean; default to true if not provided
	bool shouldRound = Lua::getBoolean(L, 2, true);
	float value = g_configManager().getFloat(key);
	double finalValue = shouldRound ? static_cast<double>(std::round(value * 100.0) / 100.0) : value;

	g_logger().debug("[{}] key: {}, finalValue: {}, shouldRound: {}", __FUNCTION__, magic_enum::enum_name(key), finalValue, shouldRound);
	lua_pushnumber(L, finalValue);
	return 1;
}
