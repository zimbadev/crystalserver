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
#include "lua/functions/events/action_functions.hpp"
#include "lua/functions/events/creature_event_functions.hpp"
#include "lua/functions/events/events_scheduler_functions.hpp"
#include "lua/functions/events/global_event_functions.hpp"
#include "lua/functions/events/move_event_functions.hpp"
#include "lua/functions/events/talk_action_functions.hpp"
#include "lua/functions/events/event_callback_functions.hpp"

class EventFunctions final : LuaScriptInterface {
public:
	explicit EventFunctions(lua_State* L) :
		LuaScriptInterface("EventFunctions") {
		init(L);
	}
	~EventFunctions() override = default;

	static void init(lua_State* L) {
		ActionFunctions::init(L);
		CreatureEventFunctions::init(L);
		EventsSchedulerFunctions::init(L);
		GlobalEventFunctions::init(L);
		MoveEventFunctions::init(L);
		TalkActionFunctions::init(L);
		EventCallbackFunctions::init(L);
		/* Move, Creature, Talk, Global events goes all here */
	}
};
