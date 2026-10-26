-- No Rest for the Wicked - the Arbaziloth fight
--
-- W = TibiaWiki, No_Rest_for_the_Wicked_Quest/Spoiler, "With friends like these...":
--   * Arbaziloth + 2 Overcharged Demons + The Forgemaster. The demons keep respawning; killing one heals the boss.
--   * 4 times during the fight he yells "Open fire you fools!" and becomes invulnerable (he takes damage but his
--     health does not go down); the Imp Minions shoot and a purple fire appears on a random spot of the room. Lure
--     the boss onto the fire until "CRAAAACK!" and use Fishing Rods on him (he can dodge). When he turns
--     vulnerable again: hearts effect, players lose their target, he says one line per turn and loses one of the
--     energy spheres on his arm.
--   * Easy: kill The Forgemaster -> inferniarch weapons + Demon Claws loot, no Doomforge.
--   * Hard: spare The Forgemaster -> shortly after the 4th time she leaves the fight, he heals fully and hits
--     harder; helmets + Demon Skull + Demon in a Green Box loot and the Doomforge opens.
--
-- How it is built:
--   * "Arbaziloth" (arbaziloth.lua) = the whole fight and the EASY loot.
--   * "Enraged Arbaziloth" (enraged_arbaziloth.lua, shown as "Arbaziloth") = the final phase of the hard mode,
--     with the HARD loot. The swap happens when he heals fully (full health either way), so nothing is lost.
--
-- NOT CONFIRMED (the Wiki gives no numbers): health at which each "Open fire" happens (80/60/40/20%),
-- chance to dodge the rod (50%), how long after the 4th time The Forgemaster leaves (3 s) and how much
-- harder he hits in the final phase (damage x1.3, in enraged_arbaziloth.lua).

ArbazilothFight = ArbazilothFight or {}
local F = ArbazilothFight

F.config = {
	zoneName = "boss.arbaziloth",
	arenaFrom = Position(34026, 32324, 14),
	arenaTo = Position(34040, 32340, 14),
	thresholds = { 0.8, 0.6, 0.4, 0.2 }, -- NOT CONFIRMED
	-- client outfits: 1798 = 4 lit spheres ... 1802 = none
	sphereOutfits = { 1799, 1800, 1801, 1802 },
	vulnerableLines = { -- W
		"UH? WHAT ... ? HOW... ?",
		"AHHH! HOW DARE YOU!?",
		"YOU WILL PAY FOR THIS INSOLENCE",
		"NOOO! AHHHH! THE POWER!!",
	},
	fireItem = 49362, -- purple fire (the same item the community script used)
	fishingRods = { [3483] = true }, -- W: Fishing Rod
	dodgeChance = 50, -- NOT CONFIRMED
	forgemasterLeaveDelay = 3000, -- NOT CONFIRMED
	impPositions = { Position(34024, 32329, 14), Position(34024, 32334, 14) }, -- Imp Minion niches (official map)
	demonPositions = { Position(34029, 32328, 14), Position(34037, 32328, 14) },
	demonCount = 2, -- W
}

local function newState()
	return {
		bossId = nil,
		forgemasterId = nil,
		phase = 0, -- how many "Open fire" phases have started (0..4)
		invulnerable = false,
		pendingPhase = false, -- a hit reached the threshold; the phase starts on the next tick
		cracked = false,
		forgemasterKilled = false,
		hardMode = false, -- The Forgemaster left and he became the Enraged one
		result = nil, -- "easy" / "hard" after his death (used by the forge portal)
	}
end

F.state = F.state or newState()

local function inArena(position)
	local from, to = F.config.arenaFrom, F.config.arenaTo
	return position.z == from.z and position.x >= from.x and position.x <= to.x and position.y >= from.y and position.y <= to.y
end

function F.getBoss()
	return F.state.bossId and Monster(F.state.bossId) or nil
end

local function arenaPlayers()
	local zone = Zone(F.config.zoneName)
	return zone and zone:getPlayers() or {}
end

local function walkableArenaTiles()
	local list = {}
	local from, to = F.config.arenaFrom, F.config.arenaTo
	for x = from.x, to.x do
		for y = from.y, to.y do
			local position = Position(x, y, from.z)
			local tile = Tile(position)
			if tile and tile:getGround() and not tile:hasFlag(TILESTATE_BLOCKSOLID) and not tile:hasFlag(TILESTATE_TELEPORT) then
				table.insert(list, position)
			end
		end
	end
	return list
end

-- The Zone monster list can be stale right after the lever creates the monsters. The arena is small: scan the tiles.
local function arenaMonsters()
	local list = {}
	local from, to = F.config.arenaFrom, F.config.arenaTo
	for x = from.x, to.x do
		for y = from.y, to.y do
			local tile = Tile(Position(x, y, from.z))
			if tile then
				for _, creature in ipairs(tile:getCreatures() or {}) do
					if creature:isMonster() then
						table.insert(list, creature)
					end
				end
			end
		end
	end
	return list
end

local function findInArena(name)
	for _, monster in ipairs(arenaMonsters()) do
		if monster:getName():lower() == name then
			return monster
		end
	end
	return nil
end

local function removeFires()
	local from, to = F.config.arenaFrom, F.config.arenaTo
	for x = from.x, to.x do
		for y = from.y, to.y do
			local tile = Tile(Position(x, y, from.z))
			local fire = tile and tile:getItemById(F.config.fireItem)
			if fire then
				fire:remove()
			end
		end
	end
end

-- the Imp Minions shoot and the purple fire appears on a random spot (W)
local function spawnFire()
	local boss = F.getBoss()
	if not boss or not F.state.invulnerable or F.state.cracked then
		return
	end
	removeFires()
	local bossPosition = boss:getPosition()
	local tiles = walkableArenaTiles()
	for _ = 1, 30 do
		local position = tiles[math.random(#tiles)]
		if position and position ~= bossPosition then
			local imp = F.config.impPositions[math.random(#F.config.impPositions)]
			imp:sendDistanceEffect(position, CONST_ANI_FIRE)
			Game.createItem(F.config.fireItem, 1, position)
			position:sendMagicEffect(CONST_ME_PURPLESMOKE)
			return
		end
	end
end

local function startOpenFire(boss)
	local state = F.state
	state.phase = state.phase + 1
	state.pendingPhase = false
	state.invulnerable = true
	state.cracked = false
	boss:say("Open fire you fools!", TALKTYPE_MONSTER_YELL)
	addEvent(spawnFire, 1500)
end

-- health of the next "Open fire" (nil after the 4th)
local function nextThreshold(boss)
	local share = F.config.thresholds[F.state.phase + 1]
	return share and math.floor(boss:getMaxHealth() * share) or nil
end

-- damage on the boss: invulnerable = health does not go down (W); and no hit can skip a phase
function F.onBossHealthChange(boss, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if primaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	if F.state.invulnerable or F.state.pendingPhase then
		boss:getPosition():sendMagicEffect(CONST_ME_HITAREA)
		return 0, primaryType, 0, secondaryType
	end
	local threshold = nextThreshold(boss)
	if not threshold then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local health = boss:getHealth()
	local total = math.abs(primaryDamage) + math.abs(secondaryDamage)
	if health - total > threshold then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	-- cut the hit so it stops exactly at the threshold and start the phase
	local allowed = math.max(0, health - threshold)
	local primaryPart = math.min(math.abs(primaryDamage), allowed)
	local secondaryPart = math.min(math.abs(secondaryDamage), allowed - primaryPart)
	local boundId = boss:getId()
	addEvent(function()
		local current = Monster(boundId)
		if current and F.state.bossId == boundId and F.state.pendingPhase then
			startOpenFire(current)
		end
	end, 0)
	F.state.pendingPhase = true -- already blocks the next hits of this same turn
	return -primaryPart, primaryType, -secondaryPart, secondaryType
end

-- the boss stepped on the purple fire
function F.onFireStep(creature, item)
	local boss = F.getBoss()
	if not boss or creature:getId() ~= boss:getId() then
		return
	end
	if not F.state.invulnerable or F.state.cracked then
		return
	end
	item:remove()
	F.state.cracked = true
	boss:say("CRAAAACK!", TALKTYPE_MONSTER_YELL)
	boss:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
end

local function forgemasterLeaves()
	local state = F.state
	local boss = F.getBoss()
	if not boss or state.forgemasterKilled or state.hardMode then
		return
	end
	local forgemaster = state.forgemasterId and Monster(state.forgemasterId) or findInArena("the forgemaster")
	if not forgemaster then
		logger.warn("[Arbaziloth] The Forgemaster should leave the fight but is not in the arena")
		return
	end
	forgemaster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	forgemaster:remove()

	-- he heals fully and gets stronger (W): becomes the Enraged one, at full health
	local position = boss:getPosition()
	boss:remove()
	local enraged = Game.createMonster("Enraged Arbaziloth", position, true, true)
	if not enraged then
		logger.error("[Arbaziloth] could not create Enraged Arbaziloth at {}", position:toString())
		return
	end
	enraged:registerEvent("BossLeverOnDeath")
	state.bossId = enraged:getId()
	state.hardMode = true
	enraged:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	enraged:say("With this power I can crush everyone!", TALKTYPE_MONSTER_YELL) -- W: one of his lines
	local zone = Zone(F.config.zoneName)
	if zone then
		zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Forgemaster has left the fight. Arbaziloth draws on her forge and heals himself completely!")
	end
end

-- Fishing Rod used on a creature (called by scripts/actions/other/fishing.lua). true = handled here.
function F.onRod(player, item, target)
	if not F.config.fishingRods[item.itemid] then
		return false
	end
	local boss = F.getBoss()
	if not boss or target:getId() ~= boss:getId() then
		return false
	end
	local state = F.state
	-- texts NOT CONFIRMED (the Wiki has no transcript). Two messages so "not cracked yet" is not mistaken for
	-- a dodge (the dodge only shows CONST_ME_DODGE, no text).
	if not state.invulnerable then
		boss:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Arbaziloth is not shielded right now.")
		return true
	end
	if not state.cracked then
		boss:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Arbaziloth's shield holds. Lure him into the purple fire first.")
		return true
	end
	if math.random(100) <= F.config.dodgeChance then
		boss:getPosition():sendMagicEffect(CONST_ME_DODGE)
		return true
	end

	-- vulnerable again
	state.invulnerable = false
	state.cracked = false
	local phase = state.phase
	boss:getPosition():sendMagicEffect(CONST_ME_POWERFUL_HEARTS)
	boss:say(F.config.vulnerableLines[phase] or F.config.vulnerableLines[#F.config.vulnerableLines], TALKTYPE_MONSTER_YELL)
	local outfit = boss:getOutfit()
	outfit.lookType = F.config.sphereOutfits[phase] or outfit.lookType
	boss:setOutfit(outfit)
	for _, arenaPlayer in ipairs(arenaPlayers()) do
		arenaPlayer:setTarget(nil)
	end
	removeFires()
	if phase >= #F.config.thresholds and not state.forgemasterKilled then
		addEvent(forgemasterLeaves, F.config.forgemasterLeaveDelay)
	end
	return true
end

-- Overcharged Demons: the fight starts with 2 and they respawn (W: "keep on respawning as they die").
-- Own 2 s clock while the boss is alive: the boss onThink does not run while he has no target.
local function countDemons()
	local alive = 0
	for _, monster in ipairs(arenaMonsters()) do
		if monster:getName():lower() == "overcharged demon" then
			alive = alive + 1
		end
	end
	return alive
end

function F.checkDemons()
	if F.demonEvent or not F.getBoss() then
		return
	end
	local missing = F.config.demonCount - countDemons()
	if missing <= 0 then
		return
	end
	for i = 1, missing do
		F.config.demonPositions[i]:sendMagicEffect(CONST_ME_TELEPORT)
	end
	F.demonEvent = addEvent(function(count)
		F.demonEvent = nil
		if not F.getBoss() then
			return
		end
		for i = 1, count do
			Game.createMonster("Overcharged Demon", F.config.demonPositions[i], true, true)
		end
	end, 5000, missing)
end

local function demonClock()
	if not F.getBoss() then
		F.clockEvent = nil
		return
	end
	F.checkDemons()
	F.clockEvent = addEvent(demonClock, 2000)
end

-- still called by the monster onThink (harmless; the clock does the work)
function F.onThink(boss)
	if F.state.bossId == boss:getId() then
		F.checkDemons()
	end
end

-- fight start: called by the lever (onUseExtra runs once per player; schedule only once)
function F.onLever()
	if F.startEvent then
		stopEvent(F.startEvent)
	end
	F.startEvent = addEvent(function()
		F.startEvent = nil
		F.state = newState()
		removeFires()
		for _, monster in ipairs(arenaMonsters()) do
			local name = monster:getName():lower()
			if name == "arbaziloth" then
				F.state.bossId = monster:getId()
				monster:registerEvent("ArbazilothFightHealth")
			elseif name == "the forgemaster" then
				F.state.forgemasterId = monster:getId()
				monster:registerEvent("ArbazilothForgemasterDeath")
			elseif name == "overcharged demon" then
				monster:remove() -- leftover from a previous fight
			end
		end
		if F.state.bossId then
			for i = 1, F.config.demonCount do
				Game.createMonster("Overcharged Demon", F.config.demonPositions[i], true, true)
			end
			if F.clockEvent then
				stopEvent(F.clockEvent)
			end
			F.clockEvent = addEvent(demonClock, 2000)
		end
	end, 100)
	return true
end

local healthEvent = CreatureEvent("ArbazilothFightHealth")

function healthEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if F.state.bossId ~= creature:getId() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	return F.onBossHealthChange(creature, primaryDamage, primaryType, secondaryDamage, secondaryType)
end

healthEvent:register()

local forgemasterDeath = CreatureEvent("ArbazilothForgemasterDeath")

function forgemasterDeath.onDeath(creature)
	if F.state.forgemasterId == creature:getId() then
		F.state.forgemasterKilled = true
		local zone = Zone(F.config.zoneName)
		if zone then
			zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Forgemaster has been slain. Arbaziloth can no longer draw on her forge.")
		end
	end
	return true
end

forgemasterDeath:register()

local fire = MoveEvent()

function fire.onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() and inArena(position) then
		F.onFireStep(creature, item)
	end
	return true
end

fire:type("stepin")
fire:id(F.config.fireItem)
fire:register()
