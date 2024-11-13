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

struct FamiliarEntry {
	constexpr explicit FamiliarEntry(uint16_t initLookType) :
		lookType(initLookType) { }
	uint16_t lookType;
};

struct Familiar {
	Familiar(std::string initName, uint16_t initLookType, bool initPremium, bool initUnlocked, std::string initType) :
		name(std::move(initName)), lookType(initLookType),
		premium(initPremium), unlocked(initUnlocked),
		type(std::move(initType)) { }

	std::string name;
	uint16_t lookType;
	bool premium;
	bool unlocked;
	std::string type;
};

class Familiars {
public:
	static Familiars &getInstance();

	bool loadFromXml();
	bool reload();

	std::vector<std::shared_ptr<Familiar>> &getFamiliars(uint16_t vocation);

	[[nodiscard]] std::shared_ptr<Familiar> getFamiliarByLookType(uint16_t vocation, uint16_t lookType) const;
};
