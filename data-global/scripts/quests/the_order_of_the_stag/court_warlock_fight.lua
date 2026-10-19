-- The Order of the Stag - the Court Warlock fight
--
-- W (The Fight):
--   - "the first player to enter the lever room will have Raubritters continuously spawn on their
--     position for the duration of the fight" (we use the player on the first lever position)
--   - 4 types: Poisoned / Frozen / Raging / Energised Raubritter, each immune to its own element
--   - "At intervals, all players will be teleported around the room. The room is divided into
--     regular floor and 'special' terrain ... each step will deal high Death Damage."
--   - "After a few waves, the room will fill up with Falcon Paladins and Falcon Knights, and all
--     'special' terrain will disappear ... Once all of the minions have been dealt with, the Court
--     Warlock will spawn. It spawns with less HP, depending on how the fight went until now."
-- V: "fighting 7 raubritters through multiple waves", "each time you get teleported so does the
--   creatures ... you are put next to each other", "You will get teleported 6 times and then for
--   the 7th time instead there will be a wave of 22 falcons ... the full room will be available".
--   Up to 5 players (V), 4 above level 500 recommended (V).
--
-- NOT CONFIRMED (our own numbers, adjust after testing):
--   length of each phase, Raubritters per wave, terrain damage, how much of the floor becomes special,
--   the Warlock health formula and the "stronger" form of the Raubritters ("Empowered ..." monsters
--   in monster/winter_update_2025/quests/empowered_*.lua; their name, health and damage are ours).

local BOSS_NAME = "Court Warlock"
local RAUBRITTERS = { "Poisoned Raubritter", "Frozen Raubritter", "Raging Raubritter", "Energised Raubritter" }
local FALCONS = { "Falcon Knight", "Falcon Paladin" }

local ARENA_FROM = Position(33830, 32133, 2)
local ARENA_TO = Position(33847, 32150, 2)
local ARENA_CENTER = Position(33838, 32141, 2)
local LEVER_POSITION = Position(33843, 32147, 3)
local LEVER_ROOM_EXIT = Position(33842, 32141, 3)

local TELEPORTS = 6 -- V (phase 1 is the entrance; teleports in phases 2..7, falcons in the 8th)
local FALCON_COUNT = 22 -- V
local RAUBRITTERS_PER_WAVE = 7 -- V ("7 raubritters through multiple waves")
local PHASE_SECONDS = 45 -- NOT CONFIRMED
local TERRAIN_SHARE = 0.35 -- NOT CONFIRMED: share of the floor that becomes special terrain
local TERRAIN_DAMAGE_PERCENT = 10 -- NOT CONFIRMED: % of max health per step
local WARLOCK_MIN_HEALTH = 0.4 -- NOT CONFIRMED: killing everything, the Warlock spawns with 40% health
local EMPOWER_SAME_TYPE = 4 -- W: "four of the same Raubritter type alive at the same time"
local EMPOWER_AFTER_SECONDS = 60 -- NOT CONFIRMED (V: "not killing them fast enough ... change phases")

local fight = nil -- state of the running fight
local arenaTiles = nil -- walkable arena tiles (built on the first fight)

local function getZone()
	return Zone("boss." .. toKey(BOSS_NAME))
end

local function isFloor(position)
	local tile = Tile(position)
	return tile and tile:getGround() and not tile:hasProperty(CONST_PROP_BLOCKSOLID) and not tile:hasFlag(TILESTATE_TELEPORT) and not tile:hasFlag(TILESTATE_FLOORCHANGE)
end

local function loadArenaTiles()
	if arenaTiles then
		return arenaTiles
	end
	arenaTiles = {}
	for x = ARENA_FROM.x, ARENA_TO.x do
		for y = ARENA_FROM.y, ARENA_TO.y do
			local position = Position(x, y, ARENA_FROM.z)
			if isFloor(position) then
				arenaTiles[#arenaTiles + 1] = position
			end
		end
	end
	return arenaTiles
end

local function key(position)
	return position.x .. ":" .. position.y
end

local function randomTile(filter)
	local tiles = loadArenaTiles()
	for _ = 1, 30 do
		local position = tiles[math.random(#tiles)]
		if not filter or filter(position) then
			return position
		end
	end
	return ARENA_CENTER
end

local function isSpecial(position)
	return fight and fight.special and fight.special[key(position)] == true
end

-- regular tiles around a center (to group players and creatures after the teleport)
local function tilesAround(center, radius)
	local list = {}
	for x = center.x - radius, center.x + radius do
		for y = center.y - radius, center.y + radius do
			local position = Position(x, y, center.z)
			if isFloor(position) and not isSpecial(position) then
				list[#list + 1] = position
			end
		end
	end
	if #list == 0 then
		list[1] = center
	end
	return list
end

local function rollTerrain()
	fight.special = {}
	for _, position in ipairs(loadArenaTiles()) do
		if math.random() < TERRAIN_SHARE then
			fight.special[key(position)] = true
		end
	end
end

local function showTerrain()
	if not fight or not fight.special then
		return
	end
	for _, position in ipairs(loadArenaTiles()) do
		if fight.special[key(position)] then
			position:sendMagicEffect(CONST_ME_MORTAREA)
		end
	end
end

local function getTarget(zone)
	local target = fight and Player(fight.targetId)
	if target and target:getPosition():isInRange(ARENA_FROM, ARENA_TO) then
		return target
	end
	return zone:getPlayers()[1]
end

local function spawnRaubritters(zone)
	local target = getTarget(zone)
	local origin = target and target:getPosition() or randomTile()
	for _ = 1, RAUBRITTERS_PER_WAVE do
		local name = RAUBRITTERS[math.random(#RAUBRITTERS)]
		local monster = Game.createMonster(name, origin, true, true)
		if monster then
			monster:registerEvent("CourtWarlockMinionDeath")
			fight.spawned = fight.spawned + 1
			fight.born[monster:getId()] = fight.seconds
		end
	end
	origin:sendMagicEffect(CONST_ME_MORTAREA)
end

-- everyone (players and creatures) goes to the same corner of the room; the terrain changes
local function shuffleRoom(zone)
	rollTerrain()
	local center = randomTile(function(position)
		return not isSpecial(position)
	end)
	local playerTiles = tilesAround(center, 1)
	local monsterTiles = tilesAround(center, 3)
	for _, player in ipairs(zone:getPlayers()) do
		player:teleportTo(playerTiles[math.random(#playerTiles)])
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	for _, monster in ipairs(zone:getMonsters()) do
		monster:teleportTo(monsterTiles[math.random(#monsterTiles)])
	end
	zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The warlock's magic tears you through the room!")
end

-- swaps a Raubritter for its empowered form, keeping its health %
local function empower(monster, baseName)
	local position = monster:getPosition()
	local ratio = monster:getHealth() / monster:getMaxHealth()
	fight.born[monster:getId()] = nil
	monster:remove()
	local strong = Game.createMonster("Empowered " .. baseName, position, true, true)
	if strong then
		strong:setHealth(math.max(1, math.floor(strong:getMaxHealth() * ratio)))
		strong:registerEvent("CourtWarlockMinionDeath")
		position:sendMagicEffect(CONST_ME_MORTAREA)
	end
end

local function empowerCheck(zone)
	local byType = {}
	for _, monster in ipairs(zone:getMonsters()) do
		local name = monster:getName():lower()
		for _, baseName in ipairs(RAUBRITTERS) do
			if name == baseName:lower() then
				byType[baseName] = byType[baseName] or {}
				table.insert(byType[baseName], monster)
				break
			end
		end
	end
	for baseName, list in pairs(byType) do
		local crowd = #list >= EMPOWER_SAME_TYPE
		for _, monster in ipairs(list) do
			local born = fight.born[monster:getId()]
			if crowd or (born and fight.seconds - born >= EMPOWER_AFTER_SECONDS) then
				empower(monster, baseName)
			end
		end
	end
end

local function spawnFalcons()
	fight.special = nil
	for _ = 1, FALCON_COUNT do
		local monster = Game.createMonster(FALCONS[math.random(#FALCONS)], randomTile(), true, true)
		if monster then
			monster:registerEvent("CourtWarlockMinionDeath")
		end
	end
	getZone():sendTextMessage(MESSAGE_EVENT_ADVANCE, "The cursed falcon knights storm the room!")
end

local function spawnWarlock()
	local monster = Game.createMonster(BOSS_NAME, ARENA_CENTER, true, true)
	if not monster then
		logger.error("[Court Warlock] could not create the boss at {}", ARENA_CENTER:toString())
		return
	end
	-- less health the more Raubritters the team killed (W: "depending on how the fight went")
	local ratio = fight.spawned > 0 and (fight.killed / fight.spawned) or 0
	local share = 1 - (1 - WARLOCK_MIN_HEALTH) * ratio
	monster:setHealth(math.max(1, math.floor(monster:getMaxHealth() * share)))
	monster:registerEvent("CourtWarlockDeath")
	fight.warlockSpawned = true
	ARENA_CENTER:sendMagicEffect(CONST_ME_MORTAREA)
	getZone():sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Court Warlock joins the fight!")
end

local function stopFight()
	if fight and fight.tickEvent then
		stopEvent(fight.tickEvent)
	end
	fight = nil
end

-- fight clock: 1 tick per second
local function tick()
	if not fight then
		return
	end
	fight.tickEvent = nil

	local zone = getZone()
	zone:refresh()
	if #zone:getPlayers() == 0 then
		zone:removeMonsters()
		stopFight()
		return
	end

	fight.seconds = fight.seconds + 1
	if fight.seconds % 2 == 0 then
		showTerrain()
	end

	if fight.phase <= TELEPORTS + 1 then
		if fight.seconds % 5 == 0 then
			empowerCheck(zone)
		end
		if fight.seconds % PHASE_SECONDS == 0 then
			fight.phase = fight.phase + 1
			if fight.phase <= TELEPORTS + 1 then
				shuffleRoom(zone)
				spawnRaubritters(zone)
			else
				spawnFalcons()
			end
		elseif fight.seconds % math.floor(PHASE_SECONDS / 2) == 0 then
			spawnRaubritters(zone)
		end
	elseif not fight.warlockSpawned and #zone:getMonsters() == 0 then
		spawnWarlock()
	end

	fight.tickEvent = addEvent(tick, 1000)
end

local function startFight()
	local targetId = fight and fight.targetId or nil -- stored by the lever's onUseExtra
	stopFight()
	loadArenaTiles()
	fight = { targetId = targetId, phase = 0, seconds = 0, spawned = 0, killed = 0, warlockSpawned = false, born = {} }
	return true
end

-- special terrain: death damage on every step (W)
local terrain = MoveEvent()

function terrain.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or not isSpecial(position) then
		return true
	end
	local damage = math.floor(player:getMaxHealth() * TERRAIN_DAMAGE_PERCENT / 100)
	doTargetCombatHealth(0, player, COMBAT_DEATHDAMAGE, -damage, -damage, CONST_ME_MORTAREA)
	return true
end

for x = ARENA_FROM.x, ARENA_TO.x do
	for y = ARENA_FROM.y, ARENA_TO.y do
		terrain:position(Position(x, y, ARENA_FROM.z))
	end
end
terrain:register()

local minionDeath = CreatureEvent("CourtWarlockMinionDeath")

function minionDeath.onDeath(creature)
	-- counts the 4 types and the empowered forms (the name ends with "raubritter")
	if fight and creature:getName():lower():find("raubritter$") then
		fight.killed = fight.killed + 1
		fight.born[creature:getId()] = nil
	end
	return true
end

minionDeath:register()

local warlockDeath = CreatureEvent("CourtWarlockDeath")

function warlockDeath.onDeath(creature)
	local zone = getZone()
	zone:refresh()
	for _, player in ipairs(zone:getPlayers()) do
		if OrderOfTheStag.getStage(player) >= OrderOfTheStag.Stage.WALL then
			OrderOfTheStag.setStage(player, OrderOfTheStag.Stage.WARLOCK_DEAD)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Court Warlock is dead. Return to Eldoran the Ambitious.")
		end
	end
	onDeathForDamagingPlayers(creature, function(_creature, player)
		player:sendBannerType(BANNER_TYPE_BOSSDEFEATED)
	end)

	stopFight()

	-- what BossLeverOnDeath would do (the boss is spawned by the script, not by the lever)
	local bossLever = BossLever[BOSS_NAME:lower()]
	if bossLever then
		if bossLever.timeoutEvent then
			stopEvent(bossLever.timeoutEvent)
			bossLever.timeoutEvent = nil
		end
		local after = bossLever.timeAfterKill or 60
		zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Court Warlock has been defeated. You have " .. after .. " seconds to leave the room.")
		bossLever.timeoutEvent = addEvent(function(zn)
			zn:refresh()
			zn:removePlayers()
		end, after * 1000, zone)
		if bossLever.lever then
			bossLever.lever:clearPlayerRefs()
			bossLever.lever = nil
		end
	end
	return true
end

warlockDeath:register()

local firstPlayerPosition = Position(33842, 32142, 3)

local config = {
	boss = {
		name = BOSS_NAME,
		position = ARENA_CENTER,
		createFunction = function()
			startFight()
			-- the lever teleports the players right after this function: the first wave waits a little
			fight.tickEvent = addEvent(function()
				if fight then
					fight.tickEvent = nil
					local zone = getZone()
					zone:refresh()
					rollTerrain()
					spawnRaubritters(zone)
					fight.phase = 1
					fight.tickEvent = addEvent(tick, 1000)
				end
			end, 3000)
			return true
		end,
	},
	-- only players with the wall unlocked (Marie-Denise) can pull the lever; stores the "tank" (first position)
	onUseExtra = function(creature, infoPositions)
		if OrderOfTheStag.getStage(creature) < OrderOfTheStag.Stage.WALL then
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not prepared to face the Court Warlock yet.")
			return false
		end
		if creature:getPosition() == firstPlayerPosition then
			fight = fight or {}
			fight.targetId = creature:getId()
		end
		return true
	end,
	timeToFightAgain = 20 * 60 * 60, -- NOT CONFIRMED: usual quest boss cooldown
	timeToDefeat = 30 * 60, -- NOT CONFIRMED
	playerPositions = {
		{ pos = firstPlayerPosition, teleport = ARENA_CENTER, effect = CONST_ME_TELEPORT },
		{ pos = Position(33842, 32143, 3), teleport = ARENA_CENTER, effect = CONST_ME_TELEPORT },
		{ pos = Position(33842, 32144, 3), teleport = ARENA_CENTER, effect = CONST_ME_TELEPORT },
		{ pos = Position(33842, 32145, 3), teleport = ARENA_CENTER, effect = CONST_ME_TELEPORT },
		{ pos = Position(33842, 32146, 3), teleport = ARENA_CENTER, effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = ARENA_FROM,
		to = ARENA_TO,
	},
	exit = LEVER_ROOM_EXIT,
}

local lever = BossLever(config)
lever:position(LEVER_POSITION)
lever:register()
