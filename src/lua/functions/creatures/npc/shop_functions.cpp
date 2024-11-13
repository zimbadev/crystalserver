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

#include "lua/functions/creatures/npc/shop_functions.hpp"

#include "creatures/npcs/npcs.hpp"

#include "items/item.hpp"
#include "utils/tools.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void ShopFunctions::init(lua_State* L) {
	Lua::registerSharedClass(L, "Shop", "", ShopFunctions::luaCreateShop);
	Lua::registerMethod(L, "Shop", "setId", ShopFunctions::luaShopSetId);
	Lua::registerMethod(L, "Shop", "setIdFromName", ShopFunctions::luaShopSetIdFromName);
	Lua::registerMethod(L, "Shop", "setNameItem", ShopFunctions::luaShopSetNameItem);
	Lua::registerMethod(L, "Shop", "setCount", ShopFunctions::luaShopSetCount);
	Lua::registerMethod(L, "Shop", "setBuyPrice", ShopFunctions::luaShopSetBuyPrice);
	Lua::registerMethod(L, "Shop", "setSellPrice", ShopFunctions::luaShopSetSellPrice);
	Lua::registerMethod(L, "Shop", "setStorageKey", ShopFunctions::luaShopSetStorageKey);
	Lua::registerMethod(L, "Shop", "setStorageValue", ShopFunctions::luaShopSetStorageValue);
	Lua::registerMethod(L, "Shop", "addChildShop", ShopFunctions::luaShopAddChildShop);
}

int ShopFunctions::luaCreateShop(lua_State* L) {
	// Shop() will create a new shop item
	Lua::pushUserdata<Shop>(L, std::make_shared<Shop>());
	Lua::setMetatable(L, -1, "Shop");
	return 1;
}

int ShopFunctions::luaShopSetId(lua_State* L) {
	// shop:setId(id)

	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		if (Lua::isNumber(L, 2)) {
			shop->shopBlock.itemId = Lua::getNumber<uint16_t>(L, 2);
			Lua::pushBoolean(L, true);
		} else {
			g_logger().warn("[ShopFunctions::luaShopSetId] - "
			                "Unknown shop item shop, int value expected");
			lua_pushnil(L);
		}
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetIdFromName(lua_State* L) {
	// shop:setIdFromName(name)
	const auto &shop = Lua::getUserdataShared<Shop>(L, 1);
	if (shop && Lua::isString(L, 2)) {
		auto name = Lua::getString(L, 2);
		const auto ids = Item::items.nameToItems.equal_range(asLowerCaseString(name));

		if (ids.first == Item::items.nameToItems.cend()) {
			g_logger().warn("[ShopFunctions::luaShopSetIdFromName] - "
			                "Unknown shop item {}",
			                name);
			lua_pushnil(L);
			return 1;
		}

		if (std::next(ids.first) != ids.second) {
			g_logger().warn("[ShopFunctions::luaShopSetIdFromName] - "
			                "Non-unique shop item {}",
			                name);
			lua_pushnil(L);
			return 1;
		}

		shop->shopBlock.itemId = ids.first->second;
		Lua::pushBoolean(L, true);
	} else {
		g_logger().warn("[ShopFunctions::luaShopSetIdFromName] - "
		                "Unknown shop item shop, string value expected");
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetNameItem(lua_State* L) {
	// shop:setNameItem(name)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.itemName = Lua::getString(L, 2);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetCount(lua_State* L) {
	// shop:setCount(count)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.itemSubType = Lua::getNumber<uint32_t>(L, 2);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetBuyPrice(lua_State* L) {
	// shop:setBuyPrice(price)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.itemBuyPrice = Lua::getNumber<uint32_t>(L, 2);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetSellPrice(lua_State* L) {
	// shop:setSellPrice(chance)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.itemSellPrice = Lua::getNumber<uint32_t>(L, 2);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetStorageKey(lua_State* L) {
	// shop:setStorageKey(storage)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.itemStorageKey = Lua::getNumber<uint32_t>(L, 2);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopSetStorageValue(lua_State* L) {
	// shop:setStorageValue(value)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.itemStorageValue = Lua::getNumber<uint32_t>(L, 2);
		Lua::pushBoolean(L, true);
	} else {
		lua_pushnil(L);
	}
	return 1;
}

int ShopFunctions::luaShopAddChildShop(lua_State* L) {
	// shop:addChildShop(shop)
	if (const auto &shop = Lua::getUserdataShared<Shop>(L, 1)) {
		shop->shopBlock.childShop.push_back(Lua::getUserdataShared<Shop>(L, 2)->shopBlock);
	} else {
		lua_pushnil(L);
	}
	return 1;
}
