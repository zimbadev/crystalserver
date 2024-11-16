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

#include "lua/functions/items/item_classification_functions.hpp"

class ItemTypeFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaItemTypeCreate(lua_State* L);

	static int luaItemTypeIsCorpse(lua_State* L);
	static int luaItemTypeIsDoor(lua_State* L);
	static int luaItemTypeIsContainer(lua_State* L);
	static int luaItemTypeIsFluidContainer(lua_State* L);
	static int luaItemTypeIsMovable(lua_State* L);
	static int luaItemTypeIsRune(lua_State* L);
	static int luaItemTypeIsStackable(lua_State* L);
	static int luaItemTypeIsStowable(lua_State* L);
	static int luaItemTypeIsReadable(lua_State* L);
	static int luaItemTypeIsWritable(lua_State* L);
	static int luaItemTypeIsBlocking(lua_State* L);
	static int luaItemTypeIsGroundTile(lua_State* L);
	static int luaItemTypeIsMagicField(lua_State* L);
	static int luaItemTypeIsMultiUse(lua_State* L);
	static int luaItemTypeIsPickupable(lua_State* L);
	static int luaItemTypeIsKey(lua_State* L);
	static int luaItemTypeIsQuiver(lua_State* L);

	static int luaItemTypeIsPodium(lua_State* L);
	static int luaItemTypeGetType(lua_State* L);
	static int luaItemTypeGetId(lua_State* L);
	static int luaItemTypeGetName(lua_State* L);
	static int luaItemTypeGetPluralName(lua_State* L);
	static int luaItemTypeGetArticle(lua_State* L);
	static int luaItemTypeGetDescription(lua_State* L);
	static int luaItemTypeGetSlotPosition(lua_State* L);

	static int luaItemTypeGetCharges(lua_State* L);
	static int luaItemTypeGetFluidSource(lua_State* L);
	static int luaItemTypeGetCapacity(lua_State* L);
	static int luaItemTypeGetWeight(lua_State* L);
	static int luaItemTypeGetStackSize(lua_State* L);

	static int luaItemTypeGetHitChance(lua_State* L);
	static int luaItemTypeGetShootRange(lua_State* L);
	static int luaItemTypeGetAttack(lua_State* L);
	static int luaItemTypeGetDefense(lua_State* L);
	static int luaItemTypeGetExtraDefense(lua_State* L);
	static int luaItemTypeGetImbuementSlot(lua_State* L);
	static int luaItemTypeGetArmor(lua_State* L);
	static int luaItemTypeGetWeaponType(lua_State* L);

	static int luaItemTypeGetElementType(lua_State* L);
	static int luaItemTypeGetElementDamage(lua_State* L);

	static int luaItemTypeGetTransformEquipId(lua_State* L);
	static int luaItemTypeGetTransformDeEquipId(lua_State* L);
	static int luaItemTypeGetDestroyId(lua_State* L);
	static int luaItemTypeGetDecayId(lua_State* L);
	static int luaItemTypeGetRequiredLevel(lua_State* L);
	static int luaItemTypeGetAmmoType(lua_State* L);

	static int luaItemTypeGetSpeed(lua_State* L);
	static int luaItemTypeGetBaseSpeed(lua_State* L);
	static int luaItemTypeGetDecayTime(lua_State* L);
	static int luaItemTypeGetShowDuration(lua_State* L);
	static int luaItemTypeGetWrapableTo(lua_State* L);
	static int luaItemTypeGetVocationString(lua_State* L);

	static int luaItemTypeHasSubType(lua_State* L);
};
