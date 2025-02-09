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

#ifndef USE_PRECOMPILED_HEADERS
	#include <cstdint>
#endif

enum class CyclopediaBadge_t : uint8_t {
	ACCOUNT_AGE = 1,
	LOYALTY,
	ACCOUNT_ALL_LEVEL,
	ACCOUNT_ALL_VOCATIONS,
	TOURNAMENT_PARTICIPATION,
	TOURNAMENT_POINTS,
};

enum CyclopediaTitle_t : uint8_t {
	NOTHING = 0,
	GOLD,
	MOUNTS,
	OUTFITS,
	LEVEL,
	HIGHSCORES,
	BESTIARY,
	BOSSTIARY,
	DAILY_REWARD,
	TASK,
	MAP,
	OTHERS,
};

enum Summary_t : uint8_t {
	HOUSE_ITEMS = 9,
	BOOSTS = 10,
	PREY_CARDS = 12,
	BLESSINGS = 14,
	ALL_BLESSINGS = 17,
	INSTANT_REWARDS = 18,
	HIRELINGS = 20,
};

enum class CyclopediaMapData_t : uint8_t {
	MinimapMarker = 0,
	DiscoveryData = 1,
	ActiveRaid = 2,
	ImminentRaidMainArea = 3,
	ImminentRaidSubArea = 4,
	SetDiscoveryArea = 5,
	Passage = 6,
	SubAreaMonsters = 7,
	MonsterBestiary = 8,
	Donations = 9,
	SetCurrentArea = 10,
};

enum class CyclopediaHouseState : uint8_t {
	Available = 0,
	Rented = 2,
	Transfer = 3,
	MoveOut = 4,
};

enum class HouseAuctionType : uint8_t {
	Bid = 1,
	MoveOut = 2,
	Transfer = 3,
	CancelMoveOut = 4,
	CancelTransfer = 5,
	AcceptTransfer = 6,
	RejectTransfer = 7,
};

enum class BidSuccessMessage : uint8_t {
	BidSuccess = 0,
	LowerBid = 1,
};

enum class BidErrorMessage : uint8_t {
	NoError = 0,
	Rookgaard = 3,
	Premium = 5,
	Guildhall = 6,
	OnlyOneBid = 7,
	NotEnoughMoney = 17,
	NotEnoughGuildMoney = 21,
	Internal = 24,
};

// Bytes to:
// Move Out, Transfer
// Cancel Move Out/Transfer
enum class TransferErrorMessage : uint8_t {
	Success = 0,
	NotHouseOwner = 2,
	CharacterNotExist = 4,
	Premium = 7,
	Rookgaard = 16,
	AlreadyTheOwner = 19,
	OnlyOneBid = 25,
	Internal = 32,
};

enum class AcceptTransferErrorMessage : uint8_t {
	Success = 0,
	NotNewOwner = 2,
	AlreadyBid = 3,
	AlreadyAccepted = 7,
	Rookgaard = 8,
	Premium = 9,
	Frozen = 15,
	Internal = 19,
};
