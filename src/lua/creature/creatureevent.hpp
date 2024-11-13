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

#include "lua/lua_definitions.hpp"

class CreatureEvent;
class LuaScriptInterface;
class Creature;
class Player;
class Item;

struct CombatDamage;

enum skills_t : int8_t;

class CreatureEvent {
public:
	explicit CreatureEvent();

	CreatureEventType_t getEventType() const {
		return type;
	}
	void setEventType(CreatureEventType_t eventType) {
		type = eventType;
	}
	const std::string &getName() const {
		return eventName;
	}
	void setName(const std::string &name) {
		eventName = name;
	}
	bool isLoaded() const {
		return loaded;
	}
	void setLoaded(bool b) {
		loaded = b;
	}

	void clearEvent();
	void copyEvent(const std::shared_ptr<CreatureEvent> &creatureEvent);

	// scripting
	bool executeOnLogin(const std::shared_ptr<Player> &player) const;
	bool executeOnLogout(const std::shared_ptr<Player> &player) const;
	bool executeOnThink(const std::shared_ptr<Creature> &creature, uint32_t interval) const;
	bool executeOnPrepareDeath(const std::shared_ptr<Creature> &creature, const std::shared_ptr<Creature> &killer, int realDamage) const;
	bool executeOnDeath(const std::shared_ptr<Creature> &creature, const std::shared_ptr<Item> &corpse, const std::shared_ptr<Creature> &killer, const std::shared_ptr<Creature> &mostDamageKiller, bool lastHitUnjustified, bool mostDamageUnjustified) const;
	void executeOnKill(const std::shared_ptr<Creature> &creature, const std::shared_ptr<Creature> &target, bool lastHit) const;
	bool executeAdvance(const std::shared_ptr<Player> &player, skills_t, uint32_t, uint32_t) const;
	void executeModalWindow(const std::shared_ptr<Player> &player, uint32_t modalWindowId, uint8_t buttonId, uint8_t choiceId) const;
	bool executeTextEdit(const std::shared_ptr<Player> &player, const std::shared_ptr<Item> &item, const std::string &text) const;
	void executeHealthChange(const std::shared_ptr<Creature> &creature, const std::shared_ptr<Creature> &attacker, CombatDamage &damage) const;
	void executeManaChange(const std::shared_ptr<Creature> &creature, const std::shared_ptr<Creature> &attacker, CombatDamage &damage) const;
	void executeExtendedOpcode(const std::shared_ptr<Player> &player, uint8_t opcode, const std::string &buffer) const;

	std::string getScriptTypeName() const;
	LuaScriptInterface* getScriptInterface() const;
	bool loadScriptId();
	int32_t getScriptId() const;
	void setScriptId(int32_t newScriptId);
	bool isLoadedScriptId() const;

private:
	int32_t m_scriptId {};

	std::string eventName;
	CreatureEventType_t type = CREATURE_EVENT_NONE;
	bool loaded = false;
};

class CreatureEvents {
public:
	CreatureEvents() = default;

	// non-copyable
	CreatureEvents(const CreatureEvents &) = delete;
	CreatureEvents &operator=(const CreatureEvents &) = delete;

	static CreatureEvents &getInstance();

	// global events
	bool playerLogin(const std::shared_ptr<Player> &player) const;
	bool playerLogout(const std::shared_ptr<Player> &player) const;
	bool playerAdvance(const std::shared_ptr<Player> &player, skills_t, uint32_t, uint32_t) const;

	std::shared_ptr<CreatureEvent> getEventByName(const std::string &name, bool forceLoaded = true);

	bool registerLuaEvent(const std::shared_ptr<CreatureEvent> &event);
	void removeInvalidEvents();
	void clear();

private:
	// creature events
	using CreatureEventMap = std::map<std::string, std::shared_ptr<CreatureEvent>>;
	CreatureEventMap creatureEvents;
};

constexpr auto g_creatureEvents = CreatureEvents::getInstance;
