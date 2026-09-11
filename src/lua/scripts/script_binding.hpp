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

#include <memory>
#include <string>
#include <string_view>

/**
 * @brief One Lua script hooked to an item, and how it got hooked.
 *
 * A script can claim an item through its unique id, its action id, its item id
 * or the position the item sits on, and only the first of those to match ever
 * runs. Actions::getScriptBindings() and MoveEvents::getScriptBindings() fill
 * this in so the look description can name the file that answers for an item,
 * instead of leaving that to a datapack grep.
 */
struct ScriptBinding {
	std::string kind; ///< "Action" or "MoveEvent".
	std::string source; ///< "unique id", "action id", "item id" or "position".
	std::string script; ///< Script file, trimmed to the datapack, plus the callback.
	std::string event; ///< Move event type; empty for actions.
	bool shadowed = false; ///< Registered, but something earlier answers first.
};

namespace ScriptBindings {
	/**
	 * @brief Trims an absolute script path down to its datapack-relative part.
	 *
	 * getFileById() hands back the full path the script was loaded from, which is
	 * noise inside a game message. The datapack folders come from the config keys
	 * dataPackDirectory and coreDirectory, so a server that renamed them still
	 * gets a short path; when neither is found the path is returned untouched.
	 * Separators are normalised to forward slashes so the result can be pasted
	 * straight into a search.
	 */
	std::string trimPath(std::string_view path);

	/**
	 * @brief The script file an event was loaded from, or an empty string.
	 *
	 * Action and MoveEvent share no base class, but both expose the same three
	 * script accessors, so one template serves both.
	 */
	template <typename Event>
	std::string fileOf(const std::shared_ptr<Event> &event) {
		if (!event || !event->isLoadedScriptId()) {
			return {};
		}

		// not named "interface": objbase.h defines it as a macro on Windows
		auto* scriptInterface = event->getScriptInterface();
		if (!scriptInterface) {
			return {};
		}

		return trimPath(scriptInterface->getFileById(event->getScriptId()));
	}
} // namespace ScriptBindings
