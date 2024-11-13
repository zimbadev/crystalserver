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

/**
 * @enum EventCallback_t
 * @brief Defines the types of events that can trigger callbacks.
 *
 * @details This enumeration represents different types of game events that can be associated
 * with specific callbacks.
 * @note The events are categorized by the type of game entity they relate to.
 */
enum class EventCallback_t : uint16_t {
	none,
	// Creature
	creatureOnChangeOutfit,
	creatureOnAreaCombat,
	creatureOnTargetCombat,
	creatureOnDrainHealth,
	creatureOnCombat,
	// Party
	partyOnJoin,
	partyOnLeave,
	partyOnDisband,
	partyOnShareExperience,
	// Player
	playerOnBrowseField,
	playerOnLook,
	playerOnLookInBattleList,
	playerOnLookInTrade,
	playerOnLookInShop,
	playerOnMoveItem,
	playerOnItemMoved,
	playerOnChangeZone,
	playerOnChangeHazard,
	playerOnMoveCreature,
	playerOnReportRuleViolation,
	playerOnReportBug,
	playerOnTurn,
	playerOnTradeRequest,
	playerOnTradeAccept,
	playerOnGainExperience,
	playerOnLoseExperience,
	playerOnGainSkillTries,
	playerOnRequestQuestLog,
	playerOnRequestQuestLine,
	playerOnStorageUpdate,
	playerOnRemoveCount,
	playerOnCombat,
	playerOnInventoryUpdate,
	playerOnRotateItem,
	playerOnWalk,
	playerOnThink,
	// Monster
	monsterOnDropLoot,
	monsterPostDropLoot,
	// Zone
	zoneBeforeCreatureEnter,
	zoneBeforeCreatureLeave,
	zoneAfterCreatureEnter,
	zoneAfterCreatureLeave,
	mapOnLoad,
};
