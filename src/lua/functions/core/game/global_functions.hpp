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

class GlobalFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaAddEvent(lua_State* L);
	static int luaCleanMap(lua_State* L);
	static int luaCreateCombatArea(lua_State* L);
	static int luaDebugPrint(lua_State* L);
	static int luaDoAddContainerItem(lua_State* L);
	static int luaDoAreaCombatCondition(lua_State* L);
	static int luaDoAreaCombatDispel(lua_State* L);
	static int luaDoAreaCombatHealth(lua_State* L);
	static int luaDoAreaCombatMana(lua_State* L);
	static int luaDoChallengeCreature(lua_State* L);
	static int luaDoPlayerAddItem(lua_State* L);
	static int luaDoTargetCombatCondition(lua_State* L);
	static int luaDoTargetCombatDispel(lua_State* L);
	static int luaDoTargetCombatHealth(lua_State* L);
	static int luaDoTargetCombatMana(lua_State* L);
	static int luaGetDepotId(lua_State* L);
	static int luaGetWaypointPositionByName(lua_State* L);
	static int luaGetWorldLight(lua_State* L);
	static int luaGetWorldTime(lua_State* L);
	static int luaGetWorldUpTime(lua_State* L);
	static int luaIsDepot(lua_State* L);
	static int luaIsInWar(lua_State* L);
	static int luaIsMovable(lua_State* L);
	static int luaIsValidUID(lua_State* L);
	static int luaSaveServer(lua_State* L);
	static int luaSendChannelMessage(lua_State* L);
	static int luaSendGuildChannelMessage(lua_State* L);
	static int luaStopEvent(lua_State* L);
	static int luaIsType(lua_State* L);
	static int luaRawGetMetatable(lua_State* L);
	static int luaCreateTable(lua_State* L);
	static int luaSystemTime(lua_State* L);
	static int luaGetFormattedTimeRemaining(lua_State* L);
	static int luaReportError(lua_State* L);

	static bool getArea(lua_State* L, std::list<uint32_t> &list, uint32_t &rows);
};
