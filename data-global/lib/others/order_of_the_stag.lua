-- The Order of the Stag (Winter Update 2025, 15.20) - shared quest data.
--
-- Sources:
--   W = TibiaWiki, The_Order_of_the_Stag_Quest/Spoiler (walkthrough + NPC transcripts)
--   V = video "The Order of the Stag Quest [Full Video Guide]" (Tibia Videos by Gudii)
--   M = official map (world.otbm), positions checked tile by tile
-- Anything without a source is marked "NOT CONFIRMED".
--
-- The Isle of Ada has no action ids on the map: everything here is registered by position.

OrderOfTheStag = {
	-- values of Storage.Quest.U15_20.TheOrderOfTheStag.Questline (only moves forward, see setStage)
	Stage = {
		WRIT = 1, -- Kesar asked for the writ (W: Etzel Writ)
		CERTIFICATE = 2, -- took the certificate from the frozen chest (W, V)
		TO_ADA = 3, -- Kesar sent you to the Isle of Ada; unlocks the boat (W: Isle of Ada)
		DEMERON = 4, -- Demeron accepted the proof (W: Finding Heir of Eldoran)
		MINES = 5, -- explored the mines; quest log update (W)
		BEAKS = 6, -- Hartford asked for the beaks (W: Fighting Night Harpies)
		UPPER_HALL = 7, -- delivered 20 beaks; access to Eldoran's floor (W)
		CORPSES = 8, -- Eldoran asked you to burn the 3 corpses (W)
		LOWER_WARD = 9, -- reported the corpses (W)
		WARLOCK = 10, -- Eldoran sent you after the Court Warlock (W)
		WALL = 11, -- Marie-Denise opened the wall (W, V)
		WARLOCK_DEAD = 12, -- killed the Court Warlock (W)
		DONE = 13, -- Eldoran gave the sword + Bastard (W, V)
	},

	-- KesarMission of The Order of the Lion: 5 = previous quest finished (npc/kesar_the_younger_day.lua)
	LION_DONE = 5,

	Items = {
		FROZEN_STARLIGHT = 3249,
		CERTIFICATE = 52586, -- ice-covered certificate of ancestry (W, items.xml)
		BEAK = 52632, -- night harpy beak (W)
		NIGHT_HARPY_CORPSE = 52680, -- monster/winter_update_2025/night_harpy.lua
		SWORD = 52824, -- the broken sword of Eldoran Etzel (W)
		VENISON = 52636,
		IRON = 52635,
		BRONZE = 52758,
		SILVER = 52743,
		COMPASS = 52759,
		QUEST_CORPSE = 52741, -- the 3 corpses "facing right" (W + M: same 3 positions)
	},

	BEAKS_NEEDED = 20, -- W
	VENISON_NEEDED = 20, -- W
	PARTS_NEEDED = { iron = 30, bronze = 20, silver = 10 }, -- W

	Positions = {
		-- Bounac cathedral (W: Mapper Coords 126.146|126.212|4 = 32402,32468,4; M)
		stand = Position(32402, 32465, 4), -- stand 9101 (M)
		holeTile = Position(32402, 32467, 4), -- hole 52654 (M)
		holeArrival = Position(32402, 32467, 5), -- ice floor right below (M)
		chest = Position(32401, 32469, 5), -- chest 28905 (M)
		exitWall = Position(32402, 32472, 5), -- stone wall 1507 (M)
		exitArrival = Position(32402, 32473, 4), -- other side of the arch 1534/1535 (M)
		warlockSpawn = Position(32403, 32470, 5), -- V: the Ancient Lion Warlock is in the room

		-- boat to the Isle of Ada (W: rope 126.138|127.1|7 = 32394,32513,7; M: hawser at 32393,32513,7)
		boatRope = Position(32393, 32513, 7),
		adaArrival = Position(33875, 32249, 7), -- NOT CONFIRMED: island pier, next to the small boat (M) and Demeron (W)
		mainlandArrival = Position(32395, 32511, 7), -- NOT CONFIRMED: shore next to the boat
		adaRope = Position(33874, 32250, 7), -- hawser 6391 on the island pier (M); the way back is NOT CONFIRMED

		-- mines (W: 132.80|125.193|7); the trigger covers the area around the ramp, see isle_of_ada.lua
		minesLog = Position(33872, 32193, 7),

		-- the 3 corpses (W: 132.66|125.118|5, 132.77|125.114|5, 132.77|125.135|5; M: item 52741)
		corpses = {
			Position(33858, 32117, 5),
			Position(33870, 32113, 5),
			Position(33869, 32134, 5),
		},

		-- Marie-Denise's wall (W: 132.41|125.140|4; M: usable wall 52735) and the teleport behind it (M)
		markWall = Position(33834, 32139, 4),
		markWallInside = Position(33833, 32138, 4),
		wallTeleport = Position(33833, 32137, 4), -- forcefield 1949, destination 0,0,0 on the map
		leverRoomArrival = Position(33836, 32141, 3), -- NOT CONFIRMED: middle of the lever room
		leverRoomTeleport = Position(33833, 32137, 3), -- forcefield 37001, lever room exit (M)
		leverRoomExit = Position(33834, 32140, 4), -- NOT CONFIRMED: back to the west tower
	},
}

-- storage keys used by this quest (TheOrderOfTheStag in lib/core/storages.lua)
local function storageKey(key)
	local stag = Storage.Quest.U15_20.TheOrderOfTheStag
	local keys = {
		Mission = stag.Questline,
		Beaks = stag.HarpyBeaks,
		Corpses = stag.Corpses,
		Harlan = stag.Harlan,
		Demeron = stag.Demeron,
		KingsCouncil = stag.KingsCouncil,
	}
	return keys[key]
end

function OrderOfTheStag.getStage(player)
	return math.max(player:getStorageValue(storageKey("Mission")), 0)
end

-- Only moves forward: never sends the player back to an earlier stage.
function OrderOfTheStag.setStage(player, stage)
	if OrderOfTheStag.getStage(player) < stage then
		player:setStorageValue(storageKey("Mission"), stage)
	end
end

function OrderOfTheStag.lionDone(player)
	return player:getStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarMission) >= OrderOfTheStag.LION_DONE
end

function OrderOfTheStag.getCount(player, key)
	return math.max(player:getStorageValue(storageKey(key)), 0)
end

function OrderOfTheStag.setCount(player, key, value)
	player:setStorageValue(storageKey(key), value)
end

-- Called by skinning.lua when the character pulls a night harpy beak with the Obsidian Knife.
-- Only counts during Hartford's mission (W: "Each character will need to skin the items themselves").
function OrderOfTheStag.onBeakSkinned(player)
	if OrderOfTheStag.getStage(player) ~= OrderOfTheStag.Stage.BEAKS then
		return
	end

	local count = OrderOfTheStag.getCount(player, "Beaks") + 1
	OrderOfTheStag.setCount(player, "Beaks", count)
	if count <= OrderOfTheStag.BEAKS_NEEDED then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You pulled a night harpy beak yourself. (%d/%d)", count, OrderOfTheStag.BEAKS_NEEDED))
	end
end
