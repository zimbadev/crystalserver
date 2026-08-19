--[[
	A PIECE OF CAKE - World Quest
	============================
	Main config file. The rest of the system (globalevents, actions, npcs, monster) only reads values from here.
	============================
	Quest TLDR:
	Stage 1:
		* Cake Golems invade Carlin, Darshia, Edron, Liberty Bay and Thais.
		* Baker NPCs spawn in the same cities, next to the extraction machines.
		* The server need:
			-> lure 200 cake golems to the extraction machines;
			-> delivery 200 substances (cake golem loot) to the bakers NPCs.
	Stage 2:
		* Create the bridge.
		* The server must consume the cake layer within a 30-minute window; if they fail, the consumed layers return. If they succeed, the topmost layer of the cake disappears.
		* Repeat the "cake-eating machine" sequence 4 times.
	Stage 3:
		* Step on where the cake used to be, receive a "mark," and remove that "mark" at the extraction machines. Repeat this process in the five cities invaded by Cake Golems.
	Day after eating the last layer of the cake:
		* XP, health, and mana regeneration bonuses begin, lasting for 7 days.
		* NPC Brutus spawns so that the server can collect its rewards.
	Rewards:
		Each year the quest is successful, after completing the mission to clear the "marks" from the extraction machines, players can receive one of the three event items and one of the three cupcakes.
	
	There are 1116 edible cakes tiles on the map. If you wish to make it easier on your server you can increase the amount of "bites" each player can take during the 30 minutes window. The base config requires ~87 players to eat the whole cake in 30 minutes.

	Check talkactions_gm_cakequest.lua to test the quest via command.
	
	Event model to "data/xml/events.xml"
	<event name="A Piece of Cake" startdate="02/21/2027" enddate="02/26/2027">
		<description description="Defeat the invading cake golems and build a bridge to a legendary island reachable only once a year. There you will have to face a challenge unlike any before. Grab your fork and be ready." />
		<colors colordark="#64162b" colorlight="#7a1b34" />
		<details displaypriority="3" isseasonal="0" specialevent="0" />
	</event>
]]

CakeQuest = CakeQuest or {}

-- ============================================================
-- 1) GLOBAL STATE (KV)
-- ============================================================
CakeQuest.KV = kv:scoped("a_piece_of_cake")

CakeQuest.Keys = {
	--[[
	0 = inactive
	1 = stage 1 (raids / substance+golem collection)
	2 = stage 2 (eating the cake, round by round)
	3 = cake fully eaten - the "mark" errand (step on the cake spot, go extract at each city, repeat) is available RIGHT AWAY in this stage, even before Brutus shows up (see BrutusAndBonusActive below for that part).
	]]

	Stage = "stage",
	SubstancesDelivered = "substancesDelivered", -- how many "Sweet and Sugary Substance" have been delivered so far
	GolemsLured = "golemsLured", -- how many Cake Golems have been lured/extracted so far
	CurrentLayer = "currentLayer", -- current cake layer/round (1 to 4)
	LayerProgress = "layerProgress", -- bites accumulated in the current window of the current round
	EatingWindowActive = "eatingWindowActive", -- -- true while a 30-min eating window is open
	EatingWindowEndsAt = "eatingWindowEndsAt", -- os.time() at which the current window closes
	EatingWindowStartedAt = "eatingWindowStartedAt", -- os.time() at which the current window opened (used to reset each player's bite count)
	WorldBonusUntil = "worldBonusUntil", -- os.time() until when the 7-day bonus is valid
	QuestStartedAt = "questStartedAt", -- os.time() when the CURRENT occurrence's stage 1 started - also used to know if today's auto-start already happened
	PendingBrutusBonus = "pendingBrutusBonus", -- True the instant the ground floor's final round is fully eaten (stage becomes 3 immediately at that point). Brutus + the world bonus (xp/regen) only actually activate at the NEXT server save (see globalevents_cake_server_save.lua) - this flag marks that they're still owed. Cleared once CakeQuest.activateBrutusAndBonus() runs.
	BrutusAndBonusActive = "brutusAndBonusActive", -- True once Brutus has actually spawned and the bonus timer has actually started (i.e. once PendingBrutusBonus was consumed). Used so the end-of-event cleanup knows whether there's a Brutus to remove.
	EventEndCleanedUp = "eventEndCleanedUp", -- True once the end-of-event cleanup (bridge/Brutus removal on Feb 26 -> 27) has already run for the CURRENT occurrence, so it doesn't repeat its broadcast message every day after that.
}

-- Storages
CakeQuest.PlayerStorage = {
	BitesThisWindow = 43231, -- how many bites the player took in the current window
	LastBiteAt = 43232, -- os.time() of the last bite (cooldown)
	BitesWindowStart = 43233, -- os.time() of the window in which BitesThisWindow was counted (to know when to reset it)
}

function CakeQuest.getBrutusErrand(player)
	local currentRunId = CakeQuest.get(CakeQuest.Keys.QuestStartedAt, 0)
	local state = CakeQuest.getPlayerKV(player):get("brutusErrand")
	if not state or state.runId ~= currentRunId then
		state = {
			runId = currentRunId,
			started = false,
			stepIsleArmed = false,
			visitedCities = {},
			itemRewardGiven = false,
			cupcakeRewardGiven = false,
		}
	end
	return state
end

function CakeQuest.setBrutusErrand(player, state)
	CakeQuest.getPlayerKV(player):set("brutusErrand", state)
end

function CakeQuest.getPlayerKV(player)
	return player:kv():scoped("a_piece_of_cake")
end

-- ============================================================
-- 2) Configs: these settings can be changed to better adapt to each case
-- ============================================================
CakeQuest.Config = {
	SUBSTANCE_GOAL = 200, -- amount of "Sweet and Sugary Substance" to clear the bridge
	GOLEM_LURE_GOAL = 200, -- amount of "Cake Golems" lured to unlock the bridgebridge
	CHECK_INTERVAL_MINUTES = 10, -- safety-net check only; the real stage 1 -> 2 transition is instant (CakeQuest.checkStage1Complete(), called right after every delivery/lure)
	RAID_INTERVAL_MINUTES = 60, -- time between Cake Golem raids in each city (original: 60 min, from server save)
	RAID_OFFSET_MINUTES = 4, -- the first raid of the day starts this many minutes after server save
	GOLEMS_PER_RAID = 20, -- amount of Cake Golems per raid spot

	LAYERS = 4, -- amount of cake layers/rounds (original: 4)
	EAT_WINDOW_MINUTES = 30, -- time to eat the cake or fail

	BITES_REQUIRED_PER_LAYER = 1116, -- all edible cake tiles on the map (1092 of id 12147 + 24 of id 12148 = 1116)
	MAX_BITES_PER_PLAYER_PER_WINDOW = 12, -- max bites per player per window (original: 12)
	BITE_COOLDOWN_SECONDS = 90,

	WORLD_BONUS_DAYS = 7, -- bonus days after completing the quest
	REGEN_BONUS_PERCENT = 25, -- % extra health/mana regeneration
	EXP_BONUS_PERCENT = 50, -- % extra exp for premium accounts

	-- Date window on which the quest runs (day/month)
	EVENT_START_DAY = 21,
	EVENT_START_MONTH = 2,
	EVENT_END_DAY = 26,
	EVENT_END_MONTH = 2,
}

CakeQuest.Config.LayerFloors = { 4, 5, 6, 7 }
CakeQuest.Config.EatingFloorZ = 7
CakeQuest.Config.TowerBoundingBox = {
	minX = 33287,
	maxX = 33330,
	minY = 32065,
	maxY = 32103,
}

function CakeQuest.getNextFloorToRemove()
	local layer = CakeQuest.get(CakeQuest.Keys.CurrentLayer, 1)
	if layer < 1 then
		layer = 1
	end
	return CakeQuest.Config.LayerFloors[layer]
end

function CakeQuest.isCakeEdibleId(itemId)
	for _, id in ipairs(CakeQuest.Items.CakeEdibleIds) do
		if id == itemId then
			return true
		end
	end
	return false
end

function CakeQuest.isCakeBorderId(itemId)
	for _, id in ipairs(CakeQuest.Items.CakeBorderIds) do
		if id == itemId then
			return true
		end
	end
	return false
end

function CakeQuest.removeFloorBulk(z)
	local box = CakeQuest.Config.TowerBoundingBox
	local ids = {}
	for _, id in ipairs(CakeQuest.Items.UpperFloorCakeIds) do
		table.insert(ids, id)
	end
	for _, id in ipairs(CakeQuest.Items.CakeBorderIds) do
		table.insert(ids, id)
	end

	for x = box.minX, box.maxX do
		for y = box.minY, box.maxY do
			local tile = Tile(Position(x, y, z))
			if tile then
				for _, id in ipairs(ids) do
					local item = tile:getItemById(id)
					while item do
						item:remove()
						item = tile:getItemById(id)
					end
				end
			end
		end
	end
end

-- ============================================================
-- 3) ACTION IDS (aid)
-- Added via 'data-global\startup\tables\tile.lua'
-- ============================================================
CakeQuest.ActionIds = {
	ExtractionSpot = {
		Carlin = 43910,
		Thais = 43911,
		Edron = 43912,
		Darashia = 43913,
		["Liberty Bay"] = 43914,
	},
}

-- ============================================================
-- 4) MAP POSITIONS
-- ============================================================
CakeQuest.Positions = {
	-- Cake Golems raid spots (can add more)
	Cities = {
		Carlin = {
			{ x = 32381, y = 31785, z = 7 },
			{ x = 32310, y = 31789, z = 7 },
		},
		Thais = {
			{ x = 32324, y = 32216, z = 7 },
			{ x = 32390, y = 32214, z = 7 },
		},
		Edron = {
			{ x = 33160, y = 31824, z = 7 },
			{ x = 33222, y = 31880, z = 7 },
		},
		Darashia = {
			{ x = 33264, y = 32446, z = 7 },
			{ x = 33195, y = 32463, z = 7 },
		},
		["Liberty Bay"] = {
			{ x = 32317, y = 32835, z = 7 },
			{ x = 32288, y = 32871, z = 7 },
		},
	},

	-- Bakers NPC's
	BakersNPCs = {
		Carlin = { x = 32345, y = 31819, z = 7 },
		Thais = { x = 32348, y = 32272, z = 7 },
		Edron = { x = 33248, y = 31799, z = 7 },
		Darashia = { x = 33192, y = 32401, z = 7 },
		["Liberty Bay"] = { x = 32375, y = 32798, z = 7 },
	},

	-- Cake Bridge (Cormaya)
	BridgeEntrance = { x = 33303, y = 32055, z = 7 },

	-- NPC Brutus The Baker
	Brutus = { x = 33303, y = 32064, z = 7 },
}

-- ============================================================
-- BRIDGE
-- ============================================================
CakeQuest.Bridge = {
	FloorId = 48227,
	RailId = 12113,
	RailLeftX = 33300,
	RailRightX = 33306,
	Area = { minX = 33301, maxX = 33305, minY = 32052, maxY = 32059, z = 7 },
}

function CakeQuest.createBridge()
	local bridge = CakeQuest.Bridge
	local failedPositions = {}

	local function buildTile(x, y, itemToPlace)
		local pos = Position(x, y, bridge.Area.z)
		local tile = Tile(pos)
		if not tile then
			table.insert(failedPositions, pos:toString())
			return
		end

		if tile:getItemById(itemToPlace) then
			return
		end

		local posKey = string.format("%d,%d,%d", x, y, bridge.Area.z)
		local removedItems = {}
		for i = tile:getThingCount() - 1, 0, -1 do
			local thing = tile:getThing(i)
			if thing and thing:isItem() then
				table.insert(removedItems, thing.itemid)
				thing:remove()
			end
		end
		if #removedItems > 0 then
			CakeQuest.KV:set("bridgeItems:" .. posKey, removedItems)
		end

		Game.createItem(itemToPlace, 1, pos)
	end

	for x = bridge.Area.minX, bridge.Area.maxX do
		for y = bridge.Area.minY, bridge.Area.maxY do
			buildTile(x, y, bridge.FloorId)
		end
	end

	for y = bridge.Area.minY, bridge.Area.maxY do
		for _, x in ipairs({ bridge.RailLeftX, bridge.RailRightX }) do
			buildTile(x, y, bridge.RailId)
		end
	end

	if #failedPositions > 0 then
		logger.warn("[A Piece of Cake] The bridge could not be created at {} position(s) because there's no tile/ground there yet: {}. Add basic ground there in Remere's Map Editor.", #failedPositions, table.concat(failedPositions, ", "))
	end
end

function CakeQuest.removeBridge()
	local bridge = CakeQuest.Bridge

	local function clearTile(x, y, expectedItemId)
		local pos = Position(x, y, bridge.Area.z)
		local tile = Tile(pos)
		if not tile then
			return
		end

		local item = tile:getItemById(expectedItemId)
		if item then
			item:remove()
		end

		local posKey = string.format("%d,%d,%d", x, y, bridge.Area.z)
		local removedItems = CakeQuest.KV:get("bridgeItems:" .. posKey)
		if removedItems then
			for _, itemId in ipairs(removedItems) do
				Game.createItem(itemId, 1, pos)
			end
			CakeQuest.KV:remove("bridgeItems:" .. posKey)
		end
	end

	for x = bridge.Area.minX, bridge.Area.maxX do
		for y = bridge.Area.minY, bridge.Area.maxY do
			clearTile(x, y, bridge.FloorId)
		end
	end

	for y = bridge.Area.minY, bridge.Area.maxY do
		for _, x in ipairs({ bridge.RailLeftX, bridge.RailRightX }) do
			clearTile(x, y, bridge.RailId)
		end
	end
end

function CakeQuest.enterStage2()
	CakeQuest.setStage(2)
	CakeQuest.set(CakeQuest.Keys.CurrentLayer, 1)
	CakeQuest.set(CakeQuest.Keys.LayerProgress, 0)
	CakeQuest.set(CakeQuest.Keys.EatingWindowActive, false)

	CakeQuest.createBridge()

	Game.broadcastMessage("The bridge to the Cake Keep Isle has been built! The tower of cake awaits - go take a bite!", MESSAGE_EVENT_ADVANCE)
	local bridgePos = CakeQuest.Positions.BridgeEntrance
	Position(bridgePos.x, bridgePos.y, bridgePos.z):sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
end

CakeQuest.LAYER_ORDINAL = {
	[1] = "the first layer",
	[2] = "the second layer",
	[3] = "the third layer",
	[4] = "the last layer",
}

function CakeQuest.openEatingWindow()
	CakeQuest.set(CakeQuest.Keys.LayerProgress, 0)
	CakeQuest.set(CakeQuest.Keys.EatingWindowActive, true)
	CakeQuest.set(CakeQuest.Keys.EatingWindowStartedAt, os.time())
	CakeQuest.set(CakeQuest.Keys.EatingWindowEndsAt, os.time() + (CakeQuest.Config.EAT_WINDOW_MINUTES * 60))

	local layer = CakeQuest.get(CakeQuest.Keys.CurrentLayer, 1)
	Game.broadcastMessage(("A new %d-minute eating window has started (round %d/%d)! Eat away at the ground floor - if you succeed, %s will crumble away! Bite goal: %d bites."):format(CakeQuest.Config.EAT_WINDOW_MINUTES, layer, CakeQuest.Config.LAYERS, CakeQuest.LAYER_ORDINAL[layer], CakeQuest.Config.BITES_REQUIRED_PER_LAYER), MESSAGE_EVENT_ADVANCE)
end

function CakeQuest.checkStage1Complete()
	if CakeQuest.getStage() ~= 1 then
		return false
	end
	local substances = CakeQuest.get(CakeQuest.Keys.SubstancesDelivered, 0)
	local golems = CakeQuest.get(CakeQuest.Keys.GolemsLured, 0)
	if substances >= CakeQuest.Config.SUBSTANCE_GOAL and golems >= CakeQuest.Config.GOLEM_LURE_GOAL then
		CakeQuest.enterStage2()
		return true
	end
	return false
end

function CakeQuest.runRaid()
	if CakeQuest.getStage() ~= 1 then
		return
	end

	for _, city in ipairs(CakeQuest.Cities) do
		local spots = CakeQuest.Positions.Cities[city]
		if spots and #spots > 0 then
			for i = 1, CakeQuest.Config.GOLEMS_PER_RAID do
				local base = spots[math.random(1, #spots)]
				local pos = Position(base.x + math.random(-3, 3), base.y + math.random(-3, 3), base.z)
				local monster = Game.createMonster(CakeQuest.MonsterName, pos, true, true)
				if monster then
					pos:sendMagicEffect(CONST_ME_MAGIC_RED)
				end
			end
		end
	end
end

function CakeQuest.spawnBakers()
	for city, position in pairs(CakeQuest.Positions.BakersNPCs) do
		local npcName = CakeQuest.Bakers[city]
		if npcName and not (position.x == 0 and position.y == 0 and position.z == 0) then
			local pos = Position(position.x, position.y, position.z)
			local tile = Tile(pos)
			local alreadyThere = false
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:getName() == npcName then
					alreadyThere = true
				end
			end
			if not alreadyThere then
				Game.createNpc(npcName, pos, true, true)
			end
		end
	end
end

function CakeQuest.removeBakers()
	for city, position in pairs(CakeQuest.Positions.BakersNPCs) do
		local npcName = CakeQuest.Bakers[city]
		if npcName and not (position.x == 0 and position.y == 0 and position.z == 0) then
			local tile = Tile(Position(position.x, position.y, position.z))
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:getName() == npcName then
					creature:remove()
				end
			end
		end
	end
end

function CakeQuest.removeBrutus()
	local brutusPos = CakeQuest.Positions.Brutus
	if brutusPos.x == 0 and brutusPos.y == 0 and brutusPos.z == 0 then
		return
	end
	local tile = Tile(Position(brutusPos.x, brutusPos.y, brutusPos.z))
	if tile then
		local creature = tile:getTopCreature()
		if creature and creature:getName() == "Brutus The Baker" then
			creature:remove()
		end
	end
end

function CakeQuest.activateBrutusAndBonus()
	CakeQuest.set(CakeQuest.Keys.PendingBrutusBonus, false)
	CakeQuest.set(CakeQuest.Keys.BrutusAndBonusActive, true)

	local bonusUntil = os.time() + (CakeQuest.Config.WORLD_BONUS_DAYS * 24 * 60 * 60)
	CakeQuest.set(CakeQuest.Keys.WorldBonusUntil, bonusUntil)

	Game.broadcastMessage(("The whole cake is gone! As thanks, the world gains +%d%% health/mana regeneration and premium accounts +%d%% experience for the next %d days."):format(CakeQuest.Config.REGEN_BONUS_PERCENT, CakeQuest.Config.EXP_BONUS_PERCENT, CakeQuest.Config.WORLD_BONUS_DAYS), MESSAGE_EVENT_ADVANCE)

	for _, player in ipairs(Game.getPlayers()) do
		CakeQuest.applyRegenBonus(player)
	end

	local brutusPos = CakeQuest.Positions.Brutus
	Game.createNpc("Brutus The Baker", Position(brutusPos.x, brutusPos.y, brutusPos.z), true, true)
end

function CakeQuest.endOfEventCleanup()
	if CakeQuest.get(CakeQuest.Keys.EventEndCleanedUp, false) then
		return
	end
	CakeQuest.set(CakeQuest.Keys.EventEndCleanedUp, true)

	CakeQuest.removeBridge()
	CakeQuest.removeBrutus()
	CakeQuest.set(CakeQuest.Keys.BrutusAndBonusActive, false)

	Game.broadcastMessage("The World Quest has ended for this year - the bridge to the Cake Keep Isle crumbles away, and Brutus The Baker departs. See you next year!", MESSAGE_EVENT_ADVANCE)
end

-- Cities
CakeQuest.Cities = { "Carlin", "Thais", "Edron", "Darashia", "Liberty Bay" }

CakeQuest.Bakers = {
	Carlin = "Benny The Baker",
	Thais = "Biff The Baker",
	Edron = "Brian The Baker",
	Darashia = "Balduin The Baker",
	["Liberty Bay"] = "Billy The Baker",
}

-- ============================================================
-- 5) ITEMS
-- ============================================================
CakeQuest.Items = {
	CakeCabinetKit = 14756, -- cake cabinet kit
	CakeBackpack = 20347, -- cake backpack
	CakeTapestry = 20350, -- cake tapestry
	CupcakeBlueberry = 28484, -- blueberry cupcake
	CupcakeStrawberry = 28485, -- strawberry cupcake
	CupcakeLemon = 28486, -- lemon cupcake

	CakeEdibleIds = { 12085, 12086 },

	UpperFloorCakeIds = { 12147, 12148 },

	CakeBorderIds = { 12152, 12153, 12154, 12155 },

	CakeBaseIds = { 12090, 12091, 12092, 12093, 12094, 12095 },

	SweetAndSugarySubstance = 12143,
}

-- ============================================================
-- 6) MONSTER
-- ============================================================
CakeQuest.MonsterName = "Cake Golem"

-- ============================================================
-- 7) SHARED UTILITY FUNCTIONS
-- ============================================================
function CakeQuest.get(key, default)
	local value = CakeQuest.KV:get(key)
	if value == nil then
		return default
	end
	return value
end

function CakeQuest.set(key, value)
	CakeQuest.KV:set(key, value)
end

function CakeQuest.getStage()
	return CakeQuest.get(CakeQuest.Keys.Stage, 0)
end

function CakeQuest.setStage(value)
	CakeQuest.set(CakeQuest.Keys.Stage, value)
end

function CakeQuest.isWithinEventWindow()
	local date = os.date("*t")
	local d, m = date.day, date.month
	if m ~= CakeQuest.Config.EVENT_START_MONTH then
		return false
	end
	return d >= CakeQuest.Config.EVENT_START_DAY and d <= CakeQuest.Config.EVENT_END_DAY
end

function CakeQuest.shouldAutoStartToday()
	local date = os.date("*t")
	local isStartDay = date.month == CakeQuest.Config.EVENT_START_MONTH and date.day == CakeQuest.Config.EVENT_START_DAY
	if not isStartDay then
		return false
	end

	local lastStart = CakeQuest.get(CakeQuest.Keys.QuestStartedAt, 0)
	if lastStart == 0 then
		return true
	end

	local lastDate = os.date("*t", lastStart)
	if lastDate.year == date.year and lastDate.month == date.month and lastDate.day == date.day then
		return false
	end
	return true
end

function CakeQuest.startFreshOccurrence()
	CakeQuest.setStage(1)
	CakeQuest.set(CakeQuest.Keys.SubstancesDelivered, 0)
	CakeQuest.set(CakeQuest.Keys.GolemsLured, 0)
	CakeQuest.set(CakeQuest.Keys.CurrentLayer, 0)
	CakeQuest.set(CakeQuest.Keys.LayerProgress, 0)
	CakeQuest.set(CakeQuest.Keys.EatingWindowActive, false)
	CakeQuest.set(CakeQuest.Keys.PendingBrutusBonus, false)
	CakeQuest.set(CakeQuest.Keys.BrutusAndBonusActive, false)
	CakeQuest.set(CakeQuest.Keys.EventEndCleanedUp, false)
	CakeQuest.set(CakeQuest.Keys.QuestStartedAt, os.time())
	CakeQuest.removeBridge()
	CakeQuest.removeBrutus()
	CakeQuest.removeBakers()
	CakeQuest.spawnBakers()
	CakeQuest.checkConfigured()
end

function CakeQuest.checkConfigured()
	local missing = {}
	for city, list in pairs(CakeQuest.Positions.Cities) do
		for _, pos in ipairs(list) do
			if pos.x == 0 and pos.y == 0 and pos.z == 0 then
				table.insert(missing, "Positions.Cities." .. city)
			end
		end
	end
	for city, pos in pairs(CakeQuest.Positions.BakersNPCs) do
		if pos.x == 0 and pos.y == 0 and pos.z == 0 then
			table.insert(missing, "Positions.BakersNPCs." .. city)
		end
	end
	if CakeQuest.Positions.BridgeEntrance.x == 0 then
		table.insert(missing, "Positions.BridgeEntrance")
	end
	if CakeQuest.Positions.Brutus.x == 0 then
		table.insert(missing, "Positions.Brutus")
	end
	if #missing > 0 then
		logger.warn("[A Piece of Cake] {} position(s) still not configured in scripts/lib/a_piece_of_cake_config.lua: {}", #missing, table.concat(missing, ", "))
	end
end
