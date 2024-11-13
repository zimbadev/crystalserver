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

class Creature;
class LuaScriptInterface;

struct Position;

class CreatureCallback {
public:
	CreatureCallback(LuaScriptInterface* scriptInterface, const std::shared_ptr<Creature> &targetCreature) :
		scriptInterface(scriptInterface), m_targetCreature(targetCreature) {};
	~CreatureCallback() = default;

	bool startScriptInterface(int32_t scriptId);

	void pushSpecificCreature(const std::shared_ptr<Creature> &creature);

	bool persistLuaState() const;

	void pushCreature(const std::shared_ptr<Creature> &creature);

	void pushPosition(const Position &position, int32_t stackpos = 0);

	void pushNumber(int32_t number);

	void pushString(const std::string &str);

	void pushBoolean(const bool str);

protected:
	static std::string getCreatureClass(const std::shared_ptr<Creature> &creature);

private:
	LuaScriptInterface* scriptInterface;
	std::weak_ptr<Creature> m_targetCreature;
	uint32_t params = 0;
	lua_State* L = nullptr;
};
