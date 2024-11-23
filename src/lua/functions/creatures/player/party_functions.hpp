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

class PartyFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaPartyCreate(lua_State* L);
	static int luaPartyDisband(lua_State* L);
	static int luaPartyGetLeader(lua_State* L);
	static int luaPartySetLeader(lua_State* L);
	static int luaPartyGetMembers(lua_State* L);
	static int luaPartyGetMemberCount(lua_State* L);
	static int luaPartyGetInvitees(lua_State* L);
	static int luaPartyGetInviteeCount(lua_State* L);
	static int luaPartyGetUniqueVocationsCount(lua_State* L);
	static int luaPartyAddInvite(lua_State* L);
	static int luaPartyRemoveInvite(lua_State* L);
	static int luaPartyAddMember(lua_State* L);
	static int luaPartyRemoveMember(lua_State* L);
	static int luaPartyIsSharedExperienceActive(lua_State* L);
	static int luaPartyIsSharedExperienceEnabled(lua_State* L);
	static int luaPartyShareExperience(lua_State* L);
	static int luaPartySetSharedExperience(lua_State* L);
};
