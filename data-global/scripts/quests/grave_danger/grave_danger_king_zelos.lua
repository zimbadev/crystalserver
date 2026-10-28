-- Grave Danger: King Zelos (source TibiaWiki = W)
-- Area (floor 13): entrance room in the south, 4 round knight rooms in the corners, corridors between them and
-- Zelos' closed room in the centre. On the official map the passages are vortexes (22761) with no destination: here
-- each vortex leads to the other side of its pair. Positions checked on the official minimap (tibiamaps).
--   W: 4 Lich Knights in separate rooms, any order; the teleport in the middle of the north corridor leads to Zelos.
--   NOT CONFIRMED (server choice): if the last knight dies after 6 min, Zelos takes half the damage (otherwise normal).
--   W Rewar: only takes damage with no Fetter alive; goes back to the centre of the room when changing form.
--   W Red Knight: only takes drowning damage, caused by a Vampiric Blood dying next to him.
--   W Magnor: on death he becomes 4 Shards with shared health; each Shard explodes (~2,000 life drain).
--   W Nargol: on death a Regenerating Mass spawns in the centre of the room; 30 s to kill it, or he comes back at full health.
--   W Zelos: Greater Hex beam (max health 40%); stepping on the centre vortex removes the hex and creates an Unleashed Hex;
--            3 Risen Soldiers in the room that come back quickly.
--   NOT CONFIRMED: knight rooms from Canary positions (NE Magnor, NW Nargol, SE Rewar, SW Red Knight);
--   Fetters (server choice): 2 when someone enters Rewar's room and 2 every 20 s, 2 sqm from the centre; up to 3 Vampiric Bloods
--   (refilled every 10 s) and 20,000-25,000 drowning on the Red Knight; Risen Soldiers refilled every 15 s;
--   hex vortex = centre of Zelos' room; the room corners lead back to the entrance.
local Z = 13
local ENTRANCE = Position(33445, 31573, Z)
local ZELOS_ROOM_CENTER = Position(33443, 31545, Z)
local ZELOS_ROOM_ARRIVAL = Position(33443, 31540, Z)
local NORTH_GATE = Position(33443, 31532, Z)
local AREA_CENTER, AREA_RX, AREA_RY = Position(33444, 31548, Z), 32, 31
local ROOM = {
	magnor = Position(33463, 31529, Z),
	nargol = Position(33423, 31529, Z),
	rewar = Position(33463, 31562, Z),
	redKnight = Position(33423, 31562, Z),
}
local HALF_AFTER_S = 6 * 60
-- lower-case names: Rewar shows up as "Rewar The Bloody" (capital T) in both forms
local KNIGHTS = {
	["rewar the bloody"] = true,
	["the red knight"] = true,
	["magnor mournbringer"] = true,
	["shard of magnor"] = true,
	["nargol the impaler"] = true,
	["regenerating mass"] = true,
}

GraveDangerZelos = GraveDangerZelos or { start = 0, done = false, half = false, token = 0 }
local fight = GraveDangerZelos

local function inArea(position)
	return position.z == Z and math.abs(position.x - AREA_CENTER.x) <= AREA_RX and math.abs(position.y - AREA_CENTER.y) <= AREA_RY
end

local function areaCreatures(playersOnly)
	return Game.getSpectators(AREA_CENTER, false, playersOnly, AREA_RX, AREA_RX, AREA_RY, AREA_RY)
end

local function countIn(center, range, name)
	local n = 0
	for _, creature in ipairs(Game.getSpectators(center, false, false, range, range, range, range)) do
		if creature:isMonster() and creature:getName() == name then
			n = n + 1
		end
	end
	return n
end

local function tellArea(text)
	for _, player in ipairs(areaCreatures(true)) do
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	end
end

-- called by the lever (actions_king_zelos_lever.lua) when the fight starts
function GraveDangerZelos.start()
	fight.start = os.time()
	fight.done = false
	fight.half = false
	fight.token = fight.token + 1
	local token = fight.token
	-- Red Knight: keeps up to 3 Vampiric Bloods in the room; Zelos: 3 Risen Soldiers
	local function tick()
		if fight.token ~= token then
			return
		end
		if Creature("The Red Knight") and countIn(ROOM.redKnight, 7, "Vampiric Blood") < 3 then
			local spot = Position(ROOM.redKnight.x + math.random(-4, 4), ROOM.redKnight.y + math.random(-4, 4), Z)
			if Tile(spot) and Tile(spot):isWalkable(false, false, false, false, true) then
				Game.createMonster("Vampiric Blood", spot, false, true)
			end
		end
		if Creature("King Zelos") and countIn(ZELOS_ROOM_CENTER, 9, "Risen Soldier") < 3 then
			local zelos = Creature("King Zelos")
			local spot = zelos:getClosestFreePosition(zelos:getPosition(), true)
			if spot and inArea(spot) then
				Game.createMonster("Risen Soldier", spot, false, true)
			end
		end
		if Creature("King Zelos") then
			addEvent(tick, 10000)
		end
	end
	addEvent(tick, 10000)
	-- Rewar: Fetters when someone enters the room and every 20 s (loop defined below)
	addEvent(function()
		if GraveDangerZelos.rewarLoop then
			GraveDangerZelos.rewarLoop(token, false, 0)
		end
	end, 1000)
end

local function checkKnights()
	if fight.done then
		return
	end
	for _, creature in ipairs(areaCreatures(false)) do
		if creature:isMonster() and KNIGHTS[creature:getName():lower()] then
			return
		end
	end
	fight.done = true
	local elapsed = os.time() - fight.start
	fight.half = elapsed > HALF_AFTER_S
	tellArea(string.format("The ritual is broken after %d:%02d! King Zelos awaits through the teleport in the north corridor.", math.floor(elapsed / 60), elapsed % 60))
	if fight.half then
		tellArea("The ritual lasted too long: King Zelos grew stronger and takes only half the damage.")
	end
end

-- death of a knight, Shard or Regenerating Mass
local knightDeath = CreatureEvent("GraveDangerKnight")

function knightDeath.onDeath(creature)
	local name = creature:getName()
	local position = creature:getPosition()
	if name == "Nargol the Impaler" then
		local mass = Game.createMonster("Regenerating Mass", ROOM.nargol, true, true)
		if mass then
			local massId, token = mass:getId(), fight.token
			tellArea("A regenerating mass rises from Nargol's remains! Destroy it within 30 seconds.")
			addEvent(function()
				local m = Monster(massId)
				if m and fight.token == token then
					m:remove()
					Game.createMonster("Nargol the Impaler", ROOM.nargol, true, true)
					tellArea("Nargol the Impaler rises again!")
				end
			end, 30000)
		end
	elseif name == "Magnor Mournbringer" then
		local hpid = os.time()
		for _ = 1, 4 do
			local spot = creature:getClosestFreePosition(position, true)
			local shard = spot and Game.createMonster("Shard of Magnor", spot, false, true)
			if shard then
				shard:beginSharedLife(hpid)
				shard:registerEvent("SharedLife")
			end
		end
	elseif name == "Shard of Magnor" then
		-- W: each Shard explodes on death (~2,000 life drain) on whoever is close
		position:sendMagicEffect(CONST_ME_DRAWBLOOD)
		for _, player in ipairs(Game.getSpectators(position, false, true, 2, 2, 2, 2)) do
			doTargetCombatHealth(0, player, COMBAT_LIFEDRAIN, -1800, -2200, CONST_ME_MAGIC_RED)
		end
	end
	addEvent(checkKnights, 300)
	return true
end

knightDeath:register()

-- Rewar: invulnerable while any Fetter is alive in the room (W). Server choice: 2 Fetters as soon as someone enters the
-- room and 2 more every 20 s. Close to the centre, so one Great Fireball in the middle hits both (W strategy).
-- NOT CONFIRMED: at most 6 Fetters alive at once; "entering the room" = a player up to 8 sqm from the centre.
local FETTER_EVERY_S = 20
local FETTER_PER_WAVE = 2
local FETTER_MAX = 6
local REWAR_ROOM_RANGE = 8
local REWAR_SPOTS = {
	Position(ROOM.rewar.x - 2, ROOM.rewar.y, Z),
	Position(ROOM.rewar.x + 2, ROOM.rewar.y, Z),
	Position(ROOM.rewar.x, ROOM.rewar.y - 2, Z),
	Position(ROOM.rewar.x, ROOM.rewar.y + 2, Z),
}
local rewarInv = {} -- Rewar id -> true while in the immune form

local function findRewar()
	for _, monster in ipairs(Game.getSpectators(ROOM.rewar, false, false, 9, 9, 9, 9)) do
		if monster:isMonster() and monster:getName():lower() == "rewar the bloody" then
			return monster
		end
	end
	return nil
end

local function setRewarInv(boss, inv)
	local id = boss:getId()
	if (rewarInv[id] or false) == inv then
		return
	end
	rewarInv[id] = inv or nil
	-- W: goes back to the centre of the room when changing form
	boss:teleportTo(ROOM.rewar)
	boss:setType(inv and "Rewar the Bloody Inv" or "Rewar the Bloody")
	ROOM.rewar:sendMagicEffect(inv and CONST_ME_MORTAREA or CONST_ME_DRAWBLOOD)
end

local function spawnFetters(boss)
	local alive = countIn(ROOM.rewar, 9, "Fetter")
	local want = math.min(FETTER_PER_WAVE, FETTER_MAX - alive)
	local made, first = 0, math.random(#REWAR_SPOTS)
	for i = 0, #REWAR_SPOTS - 1 do
		if made >= want then
			break
		end
		local spot = REWAR_SPOTS[(first + i - 1) % #REWAR_SPOTS + 1]
		local tile = Tile(spot)
		if tile and not tile:getTopCreature() then
			spot:sendMagicEffect(CONST_ME_TELEPORT)
			if Game.createMonster("Fetter", spot, false, true) then
				made = made + 1
			end
		end
	end
	if countIn(ROOM.rewar, 9, "Fetter") > 0 then
		setRewarInv(boss, true)
	end
end

-- Rewar room loop (started by GraveDangerZelos.start): waits for someone to enter and sends the waves
local function rewarLoop(token, entered, wait)
	if fight.token ~= token then
		return
	end
	local boss = findRewar()
	if not boss then
		return
	end
	if not entered then
		for _, player in ipairs(Game.getSpectators(ROOM.rewar, false, true, REWAR_ROOM_RANGE, REWAR_ROOM_RANGE, REWAR_ROOM_RANGE, REWAR_ROOM_RANGE)) do
			entered = true
			wait = 0
			break
		end
	end
	if entered then
		wait = wait - 1
		if wait <= 0 then
			spawnFetters(boss)
			wait = FETTER_EVERY_S
		end
	end
	addEvent(rewarLoop, 1000, token, entered, wait)
end
GraveDangerZelos.rewarLoop = rewarLoop

local rewar = CreatureEvent("GraveDangerRewar")

function rewar.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType ~= COMBAT_HEALING and rewarInv[creature:getId()] then
		creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		return 0, primaryType, 0, secondaryType
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

rewar:register()

local fetterDeath = CreatureEvent("GraveDangerFetter")

function fetterDeath.onDeath(creature)
	addEvent(function()
		if countIn(ROOM.rewar, 9, "Fetter") > 0 then
			return
		end
		local boss = findRewar()
		if boss then
			setRewarInv(boss, false)
		end
	end, 200)
	return true
end

fetterDeath:register()

-- a Vampiric Blood dying next to the Red Knight deals drowning damage to him
local bloodDeath = CreatureEvent("GraveDangerVampiricBlood")

function bloodDeath.onDeath(creature)
	local position = creature:getPosition()
	position:sendMagicEffect(CONST_ME_WATERSPLASH)
	for _, monster in ipairs(Game.getSpectators(position, false, false, 1, 1, 1, 1)) do
		if monster:isMonster() and monster:getName() == "The Red Knight" then
			doTargetCombatHealth(0, monster, COMBAT_DROWNDAMAGE, -20000, -25000, CONST_ME_BUBBLES)
		end
	end
	return true
end

bloodDeath:register()

-- Zelos: half damage if the ritual took too long (server choice)
local zelos = CreatureEvent("GraveDangerZelos")

function zelos.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType ~= COMBAT_HEALING and fight.half then
		primaryDamage = math.floor(primaryDamage / 2)
		secondaryDamage = math.floor(secondaryDamage / 2)
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

zelos:register()

-- area teleports: each vortex leads to the sqm right after its pair
local PAIRS = {
	{ Position(33432, 31529, Z), Position(33435, 31529, Z) },
	{ Position(33451, 31529, Z), Position(33454, 31529, Z) },
	{ Position(33432, 31562, Z), Position(33435, 31562, Z) },
	{ Position(33451, 31562, Z), Position(33454, 31562, Z) },
	{ Position(33423, 31538, Z), Position(33423, 31541, Z) },
	{ Position(33423, 31551, Z), Position(33423, 31554, Z) },
	{ Position(33463, 31538, Z), Position(33463, 31541, Z) },
	{ Position(33463, 31550, Z), Position(33463, 31553, Z) },
}
local CORNERS = { Position(33421, 31521, Z), Position(33465, 31521, Z), Position(33421, 31570, Z), Position(33465, 31570, Z) }

local function landingPast(from, to)
	local dx = to.x > from.x and 1 or (to.x < from.x and -1 or 0)
	local dy = to.y > from.y and 1 or (to.y < from.y and -1 or 0)
	return Position(to.x + dx, to.y + dy, Z)
end

local function registerVortex(position, destination)
	local vortex = MoveEvent()
	function vortex.onStepIn(creature, item, pos, fromPosition)
		local target = destination
		local tile = Tile(target)
		if not tile or not tile:isWalkable(true, false, false, false, true) then
			target = creature:getClosestFreePosition(destination, true) or destination
		end
		creature:teleportTo(target)
		target:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	vortex:position(position)
	vortex:register()
end

for _, pair in ipairs(PAIRS) do
	registerVortex(pair[1], landingPast(pair[1], pair[2]))
	registerVortex(pair[2], landingPast(pair[2], pair[1]))
end
for _, corner in ipairs(CORNERS) do
	registerVortex(corner, ENTRANCE)
end

-- north corridor gate: only with the 4 knights dead
local gate = MoveEvent()

function gate.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		creature:teleportTo(fromPosition)
		return true
	end
	if not fight.done or not Creature("King Zelos") then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The ritual of the Lich Knights still shields the king. Defeat all four of them first.")
		return true
	end
	player:teleportTo(ZELOS_ROOM_ARRIVAL)
	ZELOS_ROOM_ARRIVAL:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

gate:position(NORTH_GATE)
gate:register()

-- vortex in the centre of the room: removes the Greater Hex and creates an Unleashed Hex (W)
local hexVortex = MoveEvent()

function hexVortex.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player and player:getCondition(CONDITION_GREATERHEX) then
		player:removeCondition(CONDITION_GREATERHEX)
		position:sendMagicEffect(CONST_ME_HOLYAREA)
		local spot = player:getClosestFreePosition(position, true)
		if spot then
			Game.createMonster("Unleashed Hex", spot, false, true)
		end
	end
	return true
end

hexVortex:position(ZELOS_ROOM_CENTER)
hexVortex:register()

local wiring = GlobalEvent("GraveDangerZelosArea")
function wiring.onStartup()
	local bad = 0
	for _, pair in ipairs(PAIRS) do
		for _, p in ipairs({ landingPast(pair[1], pair[2]), landingPast(pair[2], pair[1]) }) do
			local tile = Tile(p)
			if not tile or not tile:isWalkable(true, false, false, false, true) then
				bad = bad + 1
				logger.warn("[Grave Danger] destino de vortice sem chao andavel: {}", p:toString())
			end
		end
	end
	logger.info("[Grave Danger] area do King Zelos: {} vortices ligados, {} destinos a conferir", #PAIRS * 2 + #CORNERS, bad)
	return true
end
wiring:register()
