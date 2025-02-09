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

enum class Reload_t : uint8_t {
	RELOAD_TYPE_NONE,
	RELOAD_TYPE_ALL,
	RELOAD_TYPE_CHAT,
	RELOAD_TYPE_CONFIG,
	RELOAD_TYPE_EVENTS,
	RELOAD_TYPE_MODULES,
	RELOAD_TYPE_OUTFITS,
	RELOAD_TYPE_MOUNTS,
	RELOAD_TYPE_FAMILIARS,
	RELOAD_TYPE_IMBUEMENTS,
	RELOAD_TYPE_VOCATIONS,
	RELOAD_TYPE_CORE,
	RELOAD_TYPE_GROUPS,
	RELOAD_TYPE_SCRIPTS,
	RELOAD_TYPE_ITEMS,
	RELOAD_TYPE_MONSTERS,
	RELOAD_TYPE_NPCS,
	RELOAD_TYPE_RAIDS,

	// Every is last
	RELOAD_TYPE_LAST
};

class GameReload {
public:
	GameReload();
	~GameReload();

	// non-copyable
	GameReload(const GameReload &) = delete;
	GameReload &operator=(const GameReload &) = delete;

	static GameReload &getInstance();

	static bool init(Reload_t reloadType);
	static uint8_t getReloadNumber(Reload_t reloadTypes);

private:
	static bool reloadAll();
	static bool reloadChat();
	static bool reloadConfig();
	static bool reloadEvents();
	static bool reloadModules();
	static bool reloadOutfits();
	static bool reloadMounts();
	static bool reloadFamiliars();
	static bool reloadImbuements();
	static bool reloadVocations();
	static bool reloadCore();
	static bool reloadGroups();
	static bool reloadScripts();
	static bool reloadItems();
	static bool reloadMonsters();
	static bool reloadNpcs();
	static bool reloadRaids();
};

constexpr auto g_gameReload = GameReload::getInstance;
