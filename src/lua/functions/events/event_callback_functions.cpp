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

#include "lua/functions/events/event_callback_functions.hpp"

#include "lua/callbacks/event_callback.hpp"
#include "lua/callbacks/events_callbacks.hpp"
#include "utils/tools.hpp"
#include "items/item.hpp"
#include "creatures/players/player.hpp"
#include "lua/functions/lua_functions_loader.hpp"

/**
 * @class EventCallbackFunctions
 * @brief Class providing Lua functions for manipulating event callbacks.
 *
 * @note This class is derived from LuaScriptInterface and defines several static functions that are exposed to the Lua environment.
 * @details It allows Lua scripts to create, configure, and register event callbacks.
 *
 * @see LuaScriptInterface
 */

void EventCallbackFunctions::init(lua_State* luaState) {
	Lua::registerSharedClass(luaState, "EventCallback", "", EventCallbackFunctions::luaEventCallbackCreate);
	Lua::registerMethod(luaState, "EventCallback", "type", EventCallbackFunctions::luaEventCallbackType);
	Lua::registerMethod(luaState, "EventCallback", "register", EventCallbackFunctions::luaEventCallbackRegister);
}

int EventCallbackFunctions::luaEventCallbackCreate(lua_State* luaState) {
	const auto &callbackName = Lua::getString(luaState, 2);
	if (callbackName.empty()) {
		Lua::reportErrorFunc("Invalid callback name");
		return 1;
	}

	bool skipDuplicationCheck = Lua::getBoolean(luaState, 3, false);
	const auto eventCallback = std::make_shared<EventCallback>(callbackName, skipDuplicationCheck);
	Lua::pushUserdata<EventCallback>(luaState, eventCallback);
	Lua::setMetatable(luaState, -1, "EventCallback");
	return 1;
}

int EventCallbackFunctions::luaEventCallbackType(lua_State* luaState) {
	const auto &callback = Lua::getUserdataShared<EventCallback>(luaState, 1);
	if (!callback) {
		Lua::reportErrorFunc("EventCallback is nil");
		return 0;
	}

	auto typeName = Lua::getString(luaState, 2);
	auto lowerTypeName = asLowerCaseString(typeName);
	bool found = false;
	for (auto enumValue : magic_enum::enum_values<EventCallback_t>()) {
		std::string enumName = std::string(magic_enum::enum_name(enumValue));
		auto lowerEnumTypeName = asLowerCaseString(enumName);

		if (lowerEnumTypeName == lowerTypeName) {
			callback->setType(enumValue);
			callback->setScriptTypeName(typeName);
			found = true;
			break;
		}
	}

	if (!found) {
		g_logger().error("[{}] No valid event name: {}", __func__, typeName);
		Lua::pushBoolean(luaState, false);
	}

	Lua::pushBoolean(luaState, true);
	return 1;
}

int EventCallbackFunctions::luaEventCallbackRegister(lua_State* luaState) {
	const auto &callback = Lua::getUserdataShared<EventCallback>(luaState, 1);
	if (!callback) {
		return 0;
	}

	if (!callback->isLoadedScriptId()) {
		return 0;
	}

	if (g_callbacks().isCallbackRegistered(callback)) {
		Lua::reportErrorFunc(fmt::format("EventCallback is duplicated for event with name: {}", callback->getName()));
		return 0;
	}

	g_callbacks().addCallback(callback);
	Lua::pushBoolean(luaState, true);
	return 1;
}

// Callback functions
int EventCallbackFunctions::luaEventCallbackLoad(lua_State* luaState) {
	const auto &callback = Lua::getUserdataShared<EventCallback>(luaState, 1);
	if (!callback) {
		return 1;
	}

	if (!callback->loadScriptId()) {
		Lua::reportErrorFunc("Cannot load callback");
		return 1;
	}

	Lua::pushBoolean(luaState, true);
	return 1;
}
