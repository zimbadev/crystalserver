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

#include "database/database.hpp"
#include "declarations.hpp"

class Thing;
class Creature;
class Item;
class Container;
class Npc;

class LuaScriptInterface;
class Cylinder;
class Game;

class ScriptEnvironment final {
public:
	ScriptEnvironment();
	~ScriptEnvironment();

	// non-copyable
	ScriptEnvironment(const ScriptEnvironment &) = delete;
	ScriptEnvironment &operator=(const ScriptEnvironment &) = delete;

	void resetEnv();

	void setScriptId(int32_t newScriptId, LuaScriptInterface* newScriptInterface) {
		this->scriptId = newScriptId;
		this->interface = newScriptInterface;
	}
	bool setCallbackId(int32_t callbackId, LuaScriptInterface* scriptInterface);

	int32_t getScriptId() const {
		return scriptId;
	}
	LuaScriptInterface* getScriptInterface() const {
		return interface;
	}

	void setTimerEvent() {
		timerEvent = true;
	}

	void getEventInfo(int32_t &scriptId, LuaScriptInterface*&scriptInterface, int32_t &callbackId, bool &timerEvent) const;

	void addTempItem(const std::shared_ptr<Item> &item);
	static void removeTempItem(const std::shared_ptr<Item> &item);
	uint32_t addThing(const std::shared_ptr<Thing> &thing);
	void insertItem(uint32_t uid, std::shared_ptr<Item> item);

	static DBResult_ptr getResultByID(uint32_t id);
	static uint32_t addResult(DBResult_ptr res);
	static bool removeResult(uint32_t id);

	void setNpc(std::shared_ptr<Npc> npc) {
		curNpc = std::move(npc);
	}
	std::shared_ptr<Npc> getNpc() const {
		return curNpc;
	}

	std::shared_ptr<Thing> getThingByUID(uint32_t uid);
	std::shared_ptr<Item> getItemByUID(uint32_t uid);
	std::shared_ptr<Container> getContainerByUID(uint32_t uid);
	void removeItemByUID(uint32_t uid);

private:
	using StorageMap = std::map<uint32_t, int32_t>;
	using DBResultMap = std::map<uint32_t, DBResult_ptr>;

	LuaScriptInterface* interface {};

	// for npc scripts
	std::shared_ptr<Npc> curNpc = nullptr;

	// temporary item list
	static std::multimap<ScriptEnvironment*, std::shared_ptr<Item>> tempItems;

	// local item map
	phmap::flat_hash_map<uint32_t, std::shared_ptr<Item>> localMap;
	uint32_t lastUID = std::numeric_limits<uint16_t>::max();

	// script file id
	int32_t scriptId {};
	int32_t callbackId {};
	bool timerEvent {};

	// result map
	static uint32_t lastResultId;
	static DBResultMap tempResults;
};
