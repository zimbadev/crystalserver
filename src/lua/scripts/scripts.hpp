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

class Scripts {
public:
	// non-copyable
	Scripts(const Scripts &) = delete;
	Scripts &operator=(const Scripts &) = delete;

	static Scripts &getInstance();

	void clearAllScripts() const;

	bool loadEventSchedulerScripts(const std::string &fileName);
	bool loadScripts(std::string_view folderName, bool isLib, bool reload);
	LuaScriptInterface &getScriptInterface() {
		return scriptInterface;
	}

private:
	LuaScriptInterface scriptInterface;
	Scripts();
};

constexpr auto g_scripts = Scripts::getInstance;
