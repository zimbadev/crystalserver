//
// Created by majem on 13.10.2025.
//

#include "kos_task_functions.h"

#include "creatures/players/player.hpp"
#include "kosots/kostasks.h"
#include "lua/creature/creatureevent.hpp"
#include "lua/functions/lua_functions_loader.hpp"
#include "utils/tools.hpp"

#include <absl/strings/internal/str_format/extension.h>

int KosTaskFunctions::luaPlayerGetKosTask(lua_State* L) {
	// player:getKosTask()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (!player) {
		lua_pushnil(L);
		return 1;
	}

	if (const auto &task = player->getKosTask()) {
		Lua::pushUserdata<KosTask>(L, task);
		Lua::setMetatable(L, -1, "KosTask");
	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaPlayerGetKosTaskPoints(lua_State* L) {
	// player:getKosTaskPoints()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		lua_pushnumber(L, player->getKosTaskPoints());
	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaPlayerGetKosTaskStage(lua_State* L) {
	// player:getKosTaskStage()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		lua_pushnumber(L, player->getKosTaskStage());
	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaPlayerGetKosTaskKills(lua_State* L) {
	// player:getKosTaskKills()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		lua_pushnumber(L, player->getKosTaskKills());
	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaKosTaskGetRequiredKills(lua_State* L) {
	const auto &task = Lua::getUserdataShared<KosTask>(L, 1);

	if (task) {
		lua_pushnumber(L, task->getRequiredKills());

	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaKosTaskGetRequiredKillsByStage(lua_State* L) {
	const auto &task = Lua::getUserdataShared<KosTask>(L, 1);

	if (task) {
		const uint16_t stage = Lua::getNumber<uint16_t>(L, 2);

		if (stage) {
			Lua::pushNumber(L, task->getRequiredKillsByStage(stage));
		} else {
			lua_pushnil(L);
		}

	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaPlayerCompleteKosTask(lua_State* L) {
	// player:getKosTaskStage()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		const auto &task = player->getKosTask();

		if (task) {
			lua_pushboolean(L, player->completeKosTask());
		} else {
			lua_pushboolean(L, false);
		}
	} else {
		lua_pushboolean(L, false);
	}

	return 1;
}
int KosTaskFunctions::luaKosTaskGetXpRewardByStage(lua_State* L) {
	const auto &task = Lua::getUserdataShared<KosTask>(L, 1);

	if (task) {
		const uint16_t stage = Lua::getNumber<uint16_t>(L, 2);
		Lua::pushNumber(L, task->getXpRewardByStage(stage));
	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaKosTaskGetMoneyRewardByStage(lua_State* L) {
	const auto &task = Lua::getUserdataShared<KosTask>(L, 1);

	if (task) {
		const uint16_t stage = Lua::getNumber<uint16_t>(L, 2);
		Lua::pushNumber(L, task->getMoneyRewardByStage(stage));
	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaKosTaskGetItemsRewardByStage(lua_State* L) {
	const auto &task = Lua::getUserdataShared<KosTask>(L, 1);

	if (task) {
		int index = 0;
		std::vector<KosTaskReward> rewards = task->getRewardItems();
		const uint16_t stage = Lua::getNumber<uint16_t>(L, 2);
		lua_createtable(L, rewards.size(), 0);

		for (const auto &reward : rewards) {
			lua_createtable(L, 0, 6);
			Lua::setField(L, "id", reward.id);
			Lua::setField(L, "amount", reward.amount);
			lua_rawseti(L, -2, ++index);
		}

	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaKosTaskGetMonsters(lua_State* L) {
	const auto &task = Lua::getUserdataShared<KosTask>(L, 1);

	if (task) {
		int index = 0;
		std::unordered_set<std::string> monsters = task->getMonsters();
		lua_createtable(L, static_cast<int>(monsters.size()), 0);
		for (const auto &monster : monsters) {
			Lua::pushString(L, monster);
			lua_rawseti(L, -2, ++index);
		}

	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaPlayerIsKosTaskCompleted(lua_State* L) {
	// player:getKosTaskKills()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		lua_pushboolean(L, player->isKosTaskCompleted());
	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaCreatureEventOnKosTaskProgress(lua_State* L) {
	// creatureevent:onLogin / logout / etc. (callback)
	const auto &creatureEvent = Lua::getUserdataShared<CreatureEvent>(L, 1);
	if (creatureEvent) {
		if (!creatureEvent->loadScriptId()) {
			Lua::pushBoolean(L, false);
			return 1;
		}
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaKosTaskGetId(lua_State* L) {
	// task:getId()
	const auto* task = Lua::getUserdata<const KosTask>(L, 1);
	if (task) {
		lua_pushnumber(L, task->getId());
	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaPlayerGetAvailableKosTasks(lua_State* L) {
	// player:getKosTaskKills()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		std::map<int16_t, std::shared_ptr<KosTask>> tasks = KosTasks::getInstance().getTasks();
		lua_createtable(L, tasks.size(), 0);

		int index = 0;
		for (auto &task : tasks) {
			Lua::pushUserdata<KosTask>(L, task.second);
			Lua::setMetatable(L, -1, "KosTask");
			lua_rawseti(L, -2, ++index);
		}

	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaPlayerCanPickupTask(lua_State* L) {
	// player:canPickupTask()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		const std::string taskName = Lua::getString(L, 2);

		if (auto task = KosTasks::getInstance().getTaskByName(asLowerCaseString(taskName))) {
			Lua::pushUserdata<KosTask>(L, task);
			Lua::setMetatable(L, -1, "KosTask");
		} else {
			Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_KOSTASK_NOT_FOUND));
			Lua::pushBoolean(L, false);
		}

	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaPlayerSetTask(lua_State* L) {
	// player:canPickupTask()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		const auto &task = Lua::getUserdataShared<KosTask>(L, 2);

		if (task) {
			const auto stage = Lua::getNumber<uint16_t>(L, 3);

			if (!stage || stage < 1 || stage > 10) {
				Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_KOSTASK_INVALID_STAGE));
				Lua::pushBoolean(L, false);
			}
			player->setKosTask(task);
			player->setKosTaskStage(stage);
			player->setKosTaskKills(0);
			lua_pushboolean(L, true);
		} else {
			Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_KOSTASK_NOT_FOUND));
			Lua::pushBoolean(L, false);
		}

	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaPlayerCancelTask(lua_State* L) {
	// player:cancelKosTask()
	const auto &player = Lua::getUserdataShared<Player>(L, 1);
	if (player) {
		if (auto task = player->getKosTask()) {
			player->cancelKosTask();
			Lua::pushBoolean(L, true);
		} else {
			Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_KOSTASK_NOT_FOUND));
			Lua::pushBoolean(L, false);
		}

	} else {
		lua_pushnil(L);
	}

	return 1;
}
int KosTaskFunctions::luaKosTaskGetName(lua_State* L) {
	// task:getName()
	const auto* task = Lua::getUserdata<const KosTask>(L, 1);
	if (task) {
		lua_pushstring(L, task->getName().c_str());
	} else {
		lua_pushnil(L);
	}
	return 1;
}
int KosTaskFunctions::luaCreateKosTask(lua_State* L) {
	// KosTask() will create a new KosTask item
	auto loot = std::make_shared<KosTask>();
	Lua::pushUserdata<KosTask>(L, loot);

	Lua::setMetatable(L, -1, "KosTask");
	return 1;
}

void KosTaskFunctions::init(lua_State* L) {
	Lua::registerMethod(L, "CreatureEvent", "onKosTaskProgress", KosTaskFunctions::luaCreatureEventOnKosTaskProgress);

	Lua::registerMethod(L, "Player", "getKosTask", KosTaskFunctions::luaPlayerGetKosTask);
	Lua::registerMethod(L, "Player", "getKosTaskPoints", KosTaskFunctions::luaPlayerGetKosTaskPoints);
	Lua::registerMethod(L, "Player", "getKosTaskStage", KosTaskFunctions::luaPlayerGetKosTaskStage);
	Lua::registerMethod(L, "Player", "getKosTaskKills", KosTaskFunctions::luaPlayerGetKosTaskKills);
	Lua::registerMethod(L, "Player", "isKosTaskCompleted", KosTaskFunctions::luaPlayerIsKosTaskCompleted);
	Lua::registerMethod(L, "Player", "getAvailableKosTasks", KosTaskFunctions::luaPlayerGetAvailableKosTasks);
	Lua::registerMethod(L, "Player", "canPickupTask", KosTaskFunctions::luaPlayerCanPickupTask);
	Lua::registerMethod(L, "Player", "canPickupTask", KosTaskFunctions::luaPlayerCanPickupTask);
	Lua::registerMethod(L, "Player", "setTask", KosTaskFunctions::luaPlayerSetTask);
	Lua::registerMethod(L, "Player", "cancelKosTask", KosTaskFunctions::luaPlayerCancelTask);
	Lua::registerMethod(L, "Player", "cancelKosTask", KosTaskFunctions::luaPlayerCancelTask);
	Lua::registerMethod(L, "Player", "completeKosTask", KosTaskFunctions::luaPlayerCompleteKosTask);

	Lua::registerClass(L, "KosTask", "", KosTaskFunctions::luaCreateKosTask);
	Lua::registerMethod(L, "KosTask", "getName", KosTaskFunctions::luaKosTaskGetName);
	Lua::registerMethod(L, "KosTask", "getId", KosTaskFunctions::luaKosTaskGetId);
	Lua::registerMethod(L, "KosTask", "getRequiredKillsByStage", KosTaskFunctions::luaKosTaskGetRequiredKillsByStage);
	Lua::registerMethod(L, "KosTask", "getRequiredKills", KosTaskFunctions::luaKosTaskGetRequiredKills);
	Lua::registerMethod(L, "KosTask", "getXpRewardByStage", KosTaskFunctions::luaKosTaskGetXpRewardByStage);
	Lua::registerMethod(L, "KosTask", "getMoneyRewardByStage", KosTaskFunctions::luaKosTaskGetMoneyRewardByStage);
	Lua::registerMethod(L, "KosTask", "getMonsters", KosTaskFunctions::luaKosTaskGetMonsters);
	Lua::registerMethod(L, "KosTask", "getItemsRewardByStage", KosTaskFunctions::luaKosTaskGetItemsRewardByStage);
}
