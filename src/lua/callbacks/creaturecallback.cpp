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

#include "lua/callbacks/creaturecallback.hpp"

#include "creatures/creature.hpp"
#include "lua/scripts/luascript.hpp"

bool CreatureCallback::startScriptInterface(int32_t scriptId) {
	if (scriptId == -1) {
		return false;
	}

	if (!LuaScriptInterface::reserveScriptEnv()) {
		const auto targetCreature = m_targetCreature.lock();
		g_logger().error(
			"[CreatureCallback::startScriptInterface] - {} {} Call stack overflow. Too many lua script calls being nested.",
			getCreatureClass(targetCreature),
			targetCreature->getName()
		);
		return false;
	}

	LuaScriptInterface::getScriptEnv()
		->setScriptId(scriptId, scriptInterface);

	L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);

	return true;
}

void CreatureCallback::pushSpecificCreature(const std::shared_ptr<Creature> &creature) {
	if (const auto &npc = creature->getNpc()) {
		LuaScriptInterface::pushUserdata<Npc>(L, npc);
	} else if (const auto &monster = creature->getMonster()) {
		LuaScriptInterface::pushUserdata<Monster>(L, monster);
	} else if (const auto &player = creature->getPlayer()) {
		LuaScriptInterface::pushUserdata<Player>(L, player);
	} else {
		return;
	}

	params++;
	LuaScriptInterface::setMetatable(L, -1, getCreatureClass(creature));
}

bool CreatureCallback::persistLuaState() const {
	return params > 0 && scriptInterface->callFunction(params);
}

void CreatureCallback::pushCreature(const std::shared_ptr<Creature> &creature) {
	params++;
	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);
}

void CreatureCallback::pushPosition(const Position &position, int32_t stackpos) {
	params++;
	LuaScriptInterface::pushPosition(L, position, stackpos);
}

void CreatureCallback::pushNumber(int32_t number) {
	params++;
	lua_pushnumber(L, number);
}

void CreatureCallback::pushString(const std::string &str) {
	params++;
	LuaScriptInterface::pushString(L, str);
}

void CreatureCallback::pushBoolean(const bool str) {
	params++;
	LuaScriptInterface::pushBoolean(L, str);
}

std::string CreatureCallback::getCreatureClass(const std::shared_ptr<Creature> &creature) {
	if (!creature) {
		return "";
	}
	if (creature->getNpc()) {
		return "Npc";
	}
	if (creature->getMonster()) {
		return "Monster";
	}
	if (creature->getPlayer()) {
		return "Player";
	}

	return "";
}
