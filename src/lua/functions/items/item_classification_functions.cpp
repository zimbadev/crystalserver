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

#include "lua/functions/items/item_classification_functions.hpp"

#include "game/game.hpp"
#include "items/items_classification.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void ItemClassificationFunctions::init(lua_State* L) {
	Lua::registerClass(L, "ItemClassification", "", ItemClassificationFunctions::luaItemClassificationCreate);
	Lua::registerMetaMethod(L, "ItemClassification", "__eq", Lua::luaUserdataCompare);

	Lua::registerMethod(L, "ItemClassification", "addTier", ItemClassificationFunctions::luaItemClassificationAddTier);
}

int ItemClassificationFunctions::luaItemClassificationCreate(lua_State* L) {
	// ItemClassification(id)
	if (Lua::isNumber(L, 2)) {
		const ItemClassification* itemClassification = g_game().getItemsClassification(Lua::getNumber<uint8_t>(L, 2), false);
		if (itemClassification) {
			Lua::pushUserdata<const ItemClassification>(L, itemClassification);
			Lua::setMetatable(L, -1, "ItemClassification");
			Lua::pushBoolean(L, true);
		}
	}

	lua_pushnil(L);
	return 1;
}

int ItemClassificationFunctions::luaItemClassificationAddTier(lua_State* L) {
	// itemClassification:addTier(id, core, regularPrice, convergenceFusionPrice, convergenceTransferPrice)
	auto* itemClassification = Lua::getUserdata<ItemClassification>(L, 1);
	if (itemClassification) {
		itemClassification->addTier(
			Lua::getNumber<uint8_t>(L, 2),
			Lua::getNumber<uint8_t>(L, 3),
			Lua::getNumber<uint64_t>(L, 4),
			Lua::getNumber<uint64_t>(L, 5),
			Lua::getNumber<uint64_t>(L, 6)
		);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}

	return 1;
}
