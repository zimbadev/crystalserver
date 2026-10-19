-- Isle of Ada - what happens on the island outside the quest itself
--
-- 1) Night harpy raid. W (Spoiler): "Night Harpies only spawn at night time, as part of a Raid
--    mechanic. They do not spawn every night. Once they start spawning, the raid will last for
--    several hours, but they still only appear at night." Hartford (W): the nest is "far to the south
--    of the island, somewhere in the mountains". Our choice: night only, on ~50% of the nights.
--    Spawn spots: open-sky blocks of the map (castle, surroundings, valley and southern mountains).
--    NOT CONFIRMED: spots, amount and refill (our own numbers).
-- 2) Overseer Osverger. W: "Only spawns at night time. If not killed, disappears at day time."
--    Wiki position (132.86|125.121|2).
-- 3) Marked attack on the surface. V: "While you are at the Surface there are going to be some
--    attacks coming. These are announced with a Target Mark, and shortly after a heavy agony attack
--    lands in an aoe around it. Which i believe hits for a third of your HP."
--    NOT CONFIRMED: frequency, chance, radius and delay (our own numbers).

local ISLE_FROM = Position(33760, 32060, 0)
local ISLE_TO = Position(33930, 32280, 8)

local RAID_CHANCE = 50 -- % of the nights (NOT CONFIRMED)
local HARPIES_PER_SPOT = 3
local REFILL_SECONDS = 60
local HARPY_NAME = "Night Harpy"

-- top-left corner of open-sky 8x8 blocks (taken from the official map)
local RAID_SPOTS = {
	Position(33896, 32120, 4), Position(33888, 32144, 4), Position(33904, 32120, 4), Position(33880, 32104, 4), -- castle yard
	Position(33880, 32160, 5), Position(33872, 32176, 5), Position(33888, 32184, 5), -- surroundings
	Position(33840, 32176, 6), Position(33816, 32184, 6), Position(33856, 32192, 6), Position(33896, 32200, 6), Position(33848, 32208, 6), -- valley
	Position(33824, 32216, 6), Position(33808, 32224, 6), Position(33888, 32224, 6), -- southern mountains (nest)
}

local OSVERGER_NAME = "Overseer Osverger"
local OSVERGER_POSITION = Position(33878, 32121, 2)

local MARK_INTERVAL_SECONDS = 15
local MARK_CHANCE = 20 -- % per player under open sky, each cycle
local MARK_DELAY_MS = 2500
local MARK_RADIUS = 1
local MARK_DAMAGE_SHARE = 1 / 3 -- V: "a third of your HP"

local raid = { active = false, spots = {}, refillEvent = nil }
local osvergerId = nil

local function outdoor(position)
	for z = position.z - 1, 0, -1 do
		if Tile(Position(position.x, position.y, z)) then
			return false
		end
	end
	return true
end

local function freeOutdoorTile(spot)
	for _ = 1, 20 do
		local position = Position(spot.x + math.random(0, 7), spot.y + math.random(0, 7), spot.z)
		local tile = Tile(position)
		if tile and tile:getGround() and not tile:hasProperty(CONST_PROP_BLOCKSOLID) and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and not tile:getTopCreature() and outdoor(position) then
			return position
		end
	end
	return nil
end

local function refillRaid()
	raid.refillEvent = nil
	if not raid.active then
		return
	end

	for i, spot in ipairs(RAID_SPOTS) do
		local alive = {}
		for _, id in ipairs(raid.spots[i] or {}) do
			if Monster(id) then
				alive[#alive + 1] = id
			end
		end
		while #alive < HARPIES_PER_SPOT do
			local position = freeOutdoorTile(spot)
			local harpy = position and Game.createMonster(HARPY_NAME, position, false, true)
			if not harpy then
				break
			end
			alive[#alive + 1] = harpy:getId()
		end
		raid.spots[i] = alive
	end

	raid.refillEvent = addEvent(refillRaid, REFILL_SECONDS * 1000)
end

local function startRaid()
	if raid.active then
		return
	end
	raid.active = true
	logger.info("[Isle of Ada] night harpy raid started")
	refillRaid()
end

local function stopRaid()
	if raid.refillEvent then
		stopEvent(raid.refillEvent)
		raid.refillEvent = nil
	end
	for _, ids in pairs(raid.spots) do
		for _, id in ipairs(ids) do
			local harpy = Monster(id)
			if harpy then
				harpy:getPosition():sendMagicEffect(CONST_ME_POFF)
				harpy:remove()
			end
		end
	end
	raid.spots = {}
	if raid.active then
		logger.info("[Isle of Ada] night harpy raid ended (sunrise)")
	end
	raid.active = false
end

local function spawnOsverger()
	if osvergerId and Monster(osvergerId) then
		return
	end
	local boss = Game.createMonster(OSVERGER_NAME, OSVERGER_POSITION, false, true)
	osvergerId = boss and boss:getId() or nil
end

local function removeOsverger()
	local boss = osvergerId and Monster(osvergerId)
	if boss then
		boss:getPosition():sendMagicEffect(CONST_ME_POFF)
		boss:remove()
	end
	osvergerId = nil
end

local function nightStarts()
	spawnOsverger()
	if math.random(100) <= RAID_CHANCE then
		startRaid()
	end
end

local function dayStarts()
	stopRaid()
	removeOsverger()
end

local adaPeriod = GlobalEvent("IsleOfAdaNight")

function adaPeriod.onPeriodChange(period)
	if period == LIGHT_STATE_SUNSET then
		nightStarts()
	elseif period == LIGHT_STATE_SUNRISE then
		dayStarts()
	end
	return true
end

adaPeriod:register()

local adaStartup = GlobalEvent("IsleOfAdaStartup")

function adaStartup.onStartup()
	if getTibiaTimerDayOrNight() == "night" then
		addEvent(nightStarts, 5000)
	end
	return true
end

adaStartup:register()

-- marked attack: picks players under open sky on the island, marks the floor and explodes later
local function detonate(center)
	for x = center.x - MARK_RADIUS, center.x + MARK_RADIUS do
		for y = center.y - MARK_RADIUS, center.y + MARK_RADIUS do
			local position = Position(x, y, center.z)
			position:sendMagicEffect(CONST_ME_AGONY)
			local tile = Tile(position)
			if tile then
				for _, creature in ipairs(tile:getCreatures() or {}) do
					local player = creature:getPlayer()
					if player then
						local damage = math.floor(player:getMaxHealth() * MARK_DAMAGE_SHARE)
						doTargetCombatHealth(0, player, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_NONE)
					end
				end
			end
		end
	end
end

local surfaceMarks = GlobalEvent("IsleOfAdaSurfaceMarks")

function surfaceMarks.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local position = player:getPosition()
		if position:isInRange(ISLE_FROM, ISLE_TO) and math.random(100) <= MARK_CHANCE then
			local tile = Tile(position)
			if tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and outdoor(position) and not player:getGroup():getAccess() then
				local center = Position(position.x, position.y, position.z)
				center:sendMagicEffect(CONST_ME_RED_HITAREA)
				addEvent(detonate, MARK_DELAY_MS, center)
			end
		end
	end
	return true
end

surfaceMarks:interval(MARK_INTERVAL_SECONDS * 1000)
surfaceMarks:register()
