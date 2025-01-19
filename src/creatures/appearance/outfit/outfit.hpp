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
	Outfit(std::string initName, std::string initFrom, bool initPremium, bool initUnlocked, uint16_t initLookType) :
		name(std::move(initName)), from(std::move(initFrom)), premium(initPremium), unlocked(initUnlocked), lookType(initLookType) {
		std::memset(skills, 0, sizeof(skills));
		std::memset(stats, 0, sizeof(stats));
	}

	std::string name = "";
	std::string from = "";

	bool premium = false;
	bool unlocked = false;
	bool manaShield = false;
	bool invisible = false;
	bool regeneration = false;

	uint16_t lookType = 0;

	int32_t speed = 0;
	int32_t attackSpeed = 0;
	int32_t healthGain = 0;
	int32_t healthTicks = 0;
	int32_t manaGain = 0;
	int32_t manaTicks = 0;

	int32_t skills[SKILL_LAST + 1] = { 0 };
	int32_t stats[STAT_LAST + 1] = { 0 };
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

	std::shared_ptr<Outfit> getOutfitByName(PlayerSex_t sex, const std::string_view &name) const;
	uint32_t getOutfitId(PlayerSex_t sex, uint16_t lookType) const;

	bool addAttributes(uint32_t playerId, uint32_t outfitId, uint16_t sex, uint16_t addons);
	bool removeAttributes(uint32_t playerId, uint32_t outfitId, uint16_t sex);
};
