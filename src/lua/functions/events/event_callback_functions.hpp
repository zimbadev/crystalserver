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

/**
 * @class EventCallbackFunctions
 * @brief Provides a set of static functions for working with Event Callbacks in Lua.
 *
 * @details This class encapsulates the Lua binding functions related to event callbacks,
 * allowing for interaction between the C++ codebase and Lua scripts.
 */
class EventCallbackFunctions {
public:
	/**
	 * @brief Initializes the Lua state with the event callback functions.
	 *
	 * This function registers the event callback-related functions with the given Lua state,
	 * making them accessible to Lua scripts.
	 *
	 * @param luaState The Lua state to initialize.
	 */
	static void init(lua_State* luaState);

	/**
	 * @brief Send the load of callbacks to lua
	 * @param luaState The Lua state to initialize.
	 */
	static int luaEventCallbackLoad(lua_State* luaState);

private:
	/**
	 * @brief Creates a new EventCallback object in Lua.
	 *
	 * This function is called from Lua to create a new EventCallback object,
	 * which can then be used to register various event handlers.
	 *
	 * @param luaState The Lua state.
	 * @return Number of return values on the Lua stack.
	 */
	static int luaEventCallbackCreate(lua_State* luaState);

	/**
	 * @brief Sets or gets the type of an EventCallback object in Lua.
	 *
	 * This function is called from Lua to set or get the type of an EventCallback object.
	 *
	 * @param luaState The Lua state.
	 * @return Number of return values on the Lua stack.
	 */
	static int luaEventCallbackType(lua_State* luaState);

	/**
	 * @brief Registers an EventCallback object in Lua.
	 *
	 * This function is called from Lua to register an EventCallback object,
	 * allowing it to be triggered by specific events in the game.
	 *
	 * @param luaState The Lua state.
	 * @return Number of return values on the Lua stack.
	 */
	static int luaEventCallbackRegister(lua_State* luaState);

	/**
	 * @note here end the lua binder functions }
	 */
};
