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

// Player.hpp already includes the animus mastery
#include "creatures/players/player.hpp"

#include "config/configmanager.hpp"
#include "io/fileloader.hpp"
#include "utils/tools.hpp"

AnimusMastery::AnimusMastery(Player &player) :
	m_player(player) {
	maxMonsterXpMultiplier = g_configManager().getFloat(ANIMUS_MASTERY_MAX_MONSTER_XP_MULTIPLIER);
	monsterXpMultiplier = g_configManager().getFloat(ANIMUS_MASTERY_MONSTER_XP_MULTIPLIER);
	monstersXpMultiplier = g_configManager().getFloat(ANIMUS_MASTERY_MONSTERS_XP_MULTIPLIER);
	monstersAmountToMultiply = std::clamp<uint16_t>(g_configManager().getNumber(ANIMUS_MASTERY_MONSTERS_TO_INCREASE_XP_MULTIPLIER), 1, std::numeric_limits<uint16_t>::max());
}

void AnimusMastery::add(const std::string &addMonsterType) {
	if (!has(addMonsterType)) {
		const std::string &lowerMonsterName = asLowerCaseString(addMonsterType);
		animusMasteries.emplace_back(lowerMonsterName);
	}
}

void AnimusMastery::remove(const std::string &removeMonsterType) {
	const std::string &lowerMonsterName = asLowerCaseString(removeMonsterType);
	std::erase_if(animusMasteries, [lowerMonsterName](const std::string &monsterType) {
		return asLowerCaseString(monsterType) == lowerMonsterName;
	});
}

bool AnimusMastery::has(const std::string &searchMonsterType) const {
	const std::string &lowerMonsterName = asLowerCaseString(searchMonsterType);
	auto it = std::ranges::find(animusMasteries, lowerMonsterName);

	return it != animusMasteries.end();
}

float AnimusMastery::getExperienceMultiplier() const {
	uint16_t monsterAmountMultiplier = animusMasteries.size() / monstersAmountToMultiply;

	return std::min(maxMonsterXpMultiplier, 1 + (monsterXpMultiplier + (monsterAmountMultiplier * monstersXpMultiplier)) / 100);
}

uint16_t AnimusMastery::getPoints() const {
	return animusMasteries.size();
}

const std::vector<std::string> &AnimusMastery::getAnimusMasteries() const {
	return animusMasteries;
}

void AnimusMastery::serialize(PropWriteStream &propWriteStream) const {
	std::ranges::for_each(animusMasteries, [&propWriteStream](const std::string &monsterName) {
		propWriteStream.writeString(monsterName);
	});
}

bool AnimusMastery::unserialize(PropStream &propStream) {
	std::string monsterName;
	while (propStream.readString(monsterName)) {
		animusMasteries.emplace_back(monsterName);
	}
	return true;
}
