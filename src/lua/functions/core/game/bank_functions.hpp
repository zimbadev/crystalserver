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

class Bank;

class BankFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaBankCredit(lua_State* L);
	static int luaBankDebit(lua_State* L);
	static int luaBankBalance(lua_State* L);
	static int luaBankHasBalance(lua_State* L);
	static int luaBankTransfer(lua_State* L);
	static int luaBankTransferToGuild(lua_State* L);
	static int luaBankWithdraw(lua_State* L);
	static int luaBankDeposit(lua_State* L);

	static std::shared_ptr<Bank> getBank(lua_State* L, int32_t arg, bool isGuild = false);
};
