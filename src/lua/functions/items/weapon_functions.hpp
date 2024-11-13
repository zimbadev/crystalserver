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

class WeaponFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaCreateWeapon(lua_State* L);
	static int luaWeaponId(lua_State* L);
	static int luaWeaponLevel(lua_State* L);
	static int luaWeaponMagicLevel(lua_State* L);
	static int luaWeaponMana(lua_State* L);
	static int luaWeaponManaPercent(lua_State* L);
	static int luaWeaponHealth(lua_State* L);
	static int luaWeaponHealthPercent(lua_State* L);
	static int luaWeaponSoul(lua_State* L);
	static int luaWeaponPremium(lua_State* L);
	static int luaWeaponBreakChance(lua_State* L);
	static int luaWeaponAction(lua_State* L);
	static int luaWeaponUnproperly(lua_State* L);
	static int luaWeaponVocation(lua_State* L);
	static int luaWeaponOnUseWeapon(lua_State* L);
	static int luaWeaponRegister(lua_State* L);
	static int luaWeaponElement(lua_State* L);
	static int luaWeaponAttack(lua_State* L);
	static int luaWeaponDefense(lua_State* L);
	static int luaWeaponRange(lua_State* L);
	static int luaWeaponCharges(lua_State* L);
	static int luaWeaponDuration(lua_State* L);
	static int luaWeaponDecayTo(lua_State* L);
	static int luaWeaponTransformEquipTo(lua_State* L);
	static int luaWeaponTransformDeEquipTo(lua_State* L);
	static int luaWeaponSlotType(lua_State* L);
	static int luaWeaponHitChance(lua_State* L);
	static int luaWeaponExtraElement(lua_State* L);

	// exclusively for distance weapons
	static int luaWeaponMaxHitChance(lua_State* L);
	static int luaWeaponAmmoType(lua_State* L);

	// exclusively for wands
	static int luaWeaponWandDamage(lua_State* L);

	// exclusively for wands & distance weapons
	static int luaWeaponShootType(lua_State* L);
};
