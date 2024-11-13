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

#include "lua/functions/events/events_scheduler_functions.hpp"

#include "game/scheduling/events_scheduler.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void EventsSchedulerFunctions::init(lua_State* L) {
	Lua::registerTable(L, "EventsScheduler");

	Lua::registerMethod(L, "EventsScheduler", "getEventSLoot", EventsSchedulerFunctions::luaEventsSchedulergetEventSLoot);
	Lua::registerMethod(L, "EventsScheduler", "getEventSBossLoot", EventsSchedulerFunctions::luaEventsSchedulergetEventSBossLoot);
	Lua::registerMethod(L, "EventsScheduler", "getEventSSkill", EventsSchedulerFunctions::luaEventsSchedulergetEventSSkill);
	Lua::registerMethod(L, "EventsScheduler", "getEventSExp", EventsSchedulerFunctions::luaEventsSchedulergetEventSExp);
	Lua::registerMethod(L, "EventsScheduler", "getSpawnMonsterSchedule", EventsSchedulerFunctions::luaEventsSchedulergetSpawnMonsterSchedule);
}

int EventsSchedulerFunctions::luaEventsSchedulergetEventSLoot(lua_State* L) {
	// EventsScheduler.getEventSLoot
	lua_pushnumber(L, g_eventsScheduler().getLootSchedule());
	return 1;
}

int EventsSchedulerFunctions::luaEventsSchedulergetEventSBossLoot(lua_State* L) {
	// EventsScheduler.getEventSLoot
	lua_pushnumber(L, g_eventsScheduler().getBossLootSchedule());
	return 1;
}

int EventsSchedulerFunctions::luaEventsSchedulergetEventSSkill(lua_State* L) {
	// EventsScheduler.getEventSSkill
	lua_pushnumber(L, g_eventsScheduler().getSkillSchedule());
	return 1;
}

int EventsSchedulerFunctions::luaEventsSchedulergetEventSExp(lua_State* L) {
	// EventsScheduler.getEventSExp
	lua_pushnumber(L, g_eventsScheduler().getExpSchedule());
	return 1;
}

int EventsSchedulerFunctions::luaEventsSchedulergetSpawnMonsterSchedule(lua_State* L) {
	// EventsScheduler.getSpawnMonsterSchedule
	lua_pushnumber(L, g_eventsScheduler().getSpawnMonsterSchedule());
	return 1;
}
