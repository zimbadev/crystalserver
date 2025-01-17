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
#include "creatures/creatures_definitions.hpp"

enum PlayerSex_t : uint8_t;
class Player;

struct OutfitEntry {
	constexpr explicit OutfitEntry(uint16_t initLookType, uint8_t initAddons) :
		lookType(initLookType), addons(initAddons) { }

	uint16_t lookType;
	uint8_t addons;
};

struct Outfit {
	Outfit(std::string initName, uint16_t initLookType, bool initPremium, bool initUnlocked, std::string initFrom) :
		name(std::move(initName)), lookType(initLookType), premium(initPremium), unlocked(initUnlocked), from(std::move(initFrom)) {
			std::memset(skills, 0, sizeof(skills));
			std::memset(skillsPercent, 0, sizeof(skillsPercent));
			std::memset(stats, 0, sizeof(stats));
			std::memset(statsPercent, 0, sizeof(statsPercent));
		}

	std::string name;
	uint16_t lookType;
	bool premium;
	bool unlocked;
	std::string from;

	int32_t skills[SKILL_LAST + 1];
	int32_t skillsPercent[SKILL_LAST + 1];
	int32_t stats[STAT_LAST + 1];
	int32_t statsPercent[STAT_LAST + 1];
};

struct ProtocolOutfit {
	ProtocolOutfit(const std::string &initName, uint16_t initLookType, uint8_t initAddons) :
		name(initName), lookType(initLookType), addons(initAddons) { }

	const std::string &name;
	uint16_t lookType;
	uint8_t addons;
};

class Outfits {
public:
	static Outfits &getInstance();

	bool reload();
	bool loadFromXml();

	[[nodiscard]] std::shared_ptr<Outfit> getOutfitByLookType(const std::shared_ptr<const Player> &player, uint16_t lookType, bool isOppositeOutfit = false) const;
	[[nodiscard]] const std::vector<std::shared_ptr<Outfit>> &getOutfits(PlayerSex_t sex) const;

	std::shared_ptr<Outfit> getOutfitByName(PlayerSex_t sex, const std::string &name) const;
	uint32_t getOutfitId(PlayerSex_t sex, uint32_t lookType) const;

	bool addAttributes(uint32_t playerId, uint32_t outfitId, uint16_t sex, uint16_t addons);
	bool removeAttributes(uint32_t playerId, uint32_t outfitId, uint16_t sex);
};
