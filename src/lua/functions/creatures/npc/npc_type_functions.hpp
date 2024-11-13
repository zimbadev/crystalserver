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

struct ShopBlock;

class NpcTypeFunctions {
public:
	static void init(lua_State* L);

private:
	static void createNpcTypeShopLuaTable(lua_State* L, const std::vector<ShopBlock> &shopVector);
	static int luaNpcTypeCreate(lua_State* L);
	static int luaNpcTypeIsPushable(lua_State* L);
	static int luaNpcTypeFloorChange(lua_State* L);

	static int luaNpcTypeCanSpawn(lua_State* L);

	static int luaNpcTypeCanPushItems(lua_State* L);
	static int luaNpcTypeCanPushCreatures(lua_State* L);

	static int luaNpcTypeName(lua_State* L);
	static int luaNpcTypeNameDescription(lua_State* L);

	static int luaNpcTypeHealth(lua_State* L);
	static int luaNpcTypeMaxHealth(lua_State* L);

	static int luaNpcTypeGetVoices(lua_State* L);
	static int luaNpcTypeAddVoice(lua_State* L);

	static int luaNpcTypeGetCreatureEvents(lua_State* L);
	static int luaNpcTypeRegisterEvent(lua_State* L);

	static int luaNpcTypeEventOnCallback(lua_State* L);
	static int luaNpcTypeEventType(lua_State* L);

	static int luaNpcTypeOutfit(lua_State* L);
	static int luaNpcTypeBaseSpeed(lua_State* L);
	static int luaNpcTypeWalkInterval(lua_State* L);
	static int luaNpcTypeWalkRadius(lua_State* L);
	static int luaNpcTypeLight(lua_State* L);

	static int luaNpcTypeYellChance(lua_State* L);
	static int luaNpcTypeYellSpeedTicks(lua_State* L);

	static int luaNpcTypeRespawnTypePeriod(lua_State* L);
	static int luaNpcTypeRespawnTypeIsUnderground(lua_State* L);

	static int luaNpcTypeSpeechBubble(lua_State* L);

	static int luaNpcTypeCurrency(lua_State* L);

	static int luaNpcTypeAddShopItem(lua_State* L);

	static int luaNpcTypeSoundChance(lua_State* L);
	static int luaNpcTypeSoundSpeedTicks(lua_State* L);
	static int luaNpcTypeAddSound(lua_State* L);
	static int luaNpcTypeGetSounds(lua_State* L);

	friend class GameFunctions;
};
