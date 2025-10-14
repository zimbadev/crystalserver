//
// Created by majem on 13.10.2025.
//

#ifndef KOS_TASK_FUNCTIONS_H
#define KOS_TASK_FUNCTIONS_H
#include <lua.h>

class KosTaskFunctions {
public:

	static int luaPlayerGetKosTask(lua_State* L);

	static int luaKosTaskGetName(lua_State* L);
	static int luaCreateKosTask(lua_State* L);
	static int luaPlayerGetKosTaskPoints(lua_State* L);
	static int luaPlayerGetKosTaskStage(lua_State* L);
	static int luaPlayerGetKosTaskKills(lua_State* L);
	static int luaKosTaskGetRequiredKills(lua_State* L);
	static int luaKosTaskGetXpRewardByStage(lua_State* L);
	static int luaKosTaskGetMoneyRewardByStage(lua_State* L);
	static int luaKosTaskGetItemsRewardByStage(lua_State* L);
	static int luaKosTaskGetMonsters(lua_State* L);
	static int luaPlayerIsKosTaskCompleted(lua_State* L);
	static int luaCreatureEventOnKosTaskProgress(lua_State* L);
	static int luaKosTaskGetId(lua_State* L);
	static int luaPlayerGetAvailableKosTasks(lua_State* L);
	static int luaPlayerCanPickupTask(lua_State* L);
	static int luaPlayerSetTask(lua_State* L);
	static int luaPlayerCancelTask(lua_State* L);
	static int luaKosTaskGetRequiredKillsByStage(lua_State* L);
	static int luaPlayerCompleteKosTask(lua_State* L);
	static void init(lua_State* L);

private:

};



#endif //KOS_TASK_FUNCTIONS_H
