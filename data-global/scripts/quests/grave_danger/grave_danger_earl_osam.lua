-- Grave Danger: Earl Osam (source TibiaWiki = W)
--   W: after a while he goes to the centre and channels, invulnerable (Channeling Earl Osam); 4 Magical Spheres spawn,
--      one on each side of the room, and walk to him. Each sphere that arrives heals 80,000. Once the spheres are gone,
--      shortly after he pushes away whoever stands next to him (not diagonal) and goes back to normal. Repeats 1 or 2 times.
--   Here the channeling form is the SAME boss with another type (setType): health, damage dealt and difficulty are kept.
--   NOT CONFIRMED: channels every 15% of health lost; spheres walk 1 sqm every 4 s (positions from Canary);
--   push = teleport to a free sqm 3-4 sqm from the centre, 3 s after the last sphere.
local CENTER = Position(33488, 31438, 13)
local RANGE_X, RANGE_Y = 9, 9
local CHANNEL_EACH = 0.15
local SPHERE_HEAL = 80000
local STEP_MS = 4000
local SPHERE_SPOTS = { Position(33480, 31438, 13), Position(33488, 31430, 13), Position(33496, 31438, 13), Position(33488, 31446, 13) }

local fights = {} -- [bossId] = { lost, spheres, channeling, token }

local function fightOf(boss)
	local f = fights[boss:getId()]
	if not f then
		f = { lost = 0, spheres = 0, token = 0 }
		fights[boss:getId()] = f
	end
	return f
end

local function room(playersOnly)
	return Game.getSpectators(CENTER, false, playersOnly, RANGE_X, RANGE_X, RANGE_Y, RANGE_Y)
end

local function stepToward(from, to)
	local dx = to.x > from.x and 1 or (to.x < from.x and -1 or 0)
	local dy = to.y > from.y and 1 or (to.y < from.y and -1 or 0)
	if dx ~= 0 and dy ~= 0 then
		dy = 0 -- walk in a straight line (the spheres spawn aligned with the centre)
	end
	return Position(from.x + dx, from.y + dy, from.z)
end

local function endChannel(bossId, token)
	local boss = Monster(bossId)
	local f = fights[bossId]
	if not boss or not f or f.token ~= token or not f.channeling then
		return
	end
	-- W: pushes away whoever stands next to him (not diagonal)
	local center = boss:getPosition()
	for _, player in ipairs(room(true)) do
		local p = player:getPosition()
		if math.abs(p.x - center.x) + math.abs(p.y - center.y) == 1 then
			for _ = 1, 10 do
				local spot = Position(center.x + math.random(-4, 4), center.y + math.random(-4, 4), center.z)
				local tile = Tile(spot)
				if spot:getDistance(center) >= 3 and tile and tile:isWalkable(true, false, false, false, true) then
					player:teleportTo(spot)
					spot:sendMagicEffect(CONST_ME_TELEPORT)
					break
				end
			end
		end
	end
	f.channeling = false
	f.lost = 0
	boss:setType("Earl Osam")
	boss:getPosition():sendMagicEffect(CONST_ME_ICEAREA)
end

local function sphereTick(bossId, token)
	local boss = Monster(bossId)
	local f = fights[bossId]
	if not boss or not f or f.token ~= token or not f.channeling then
		return
	end
	if boss:getPosition() ~= CENTER then
		boss:teleportTo(CENTER) -- while channeling he does not leave the centre
	end
	local left = 0
	for _, creature in ipairs(room(false)) do
		if creature:isMonster() and creature:getName() == "Magical Sphere" then
			local next = stepToward(creature:getPosition(), CENTER)
			if next == CENTER then
				creature:remove()
				boss:addHealth(SPHERE_HEAL)
				boss:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				boss:say("The sphere's power heals the earl!", TALKTYPE_MONSTER_SAY)
			else
				local tile = Tile(next)
				if tile and not tile:getTopCreature() then
					creature:teleportTo(next)
				end -- sqm taken: the sphere waits
				left = left + 1
			end
		end
	end
	f.spheres = left
	if left == 0 then
		addEvent(endChannel, 3000, bossId, token)
		return
	end
	addEvent(sphereTick, STEP_MS, bossId, token)
end

local function startChannel(bossId)
	local boss = Monster(bossId)
	local f = fights[bossId]
	if not boss or not f or f.channeling then
		return
	end
	local top = Tile(CENTER) and Tile(CENTER):getTopCreature()
	if top and top:getId() ~= bossId then
		top:teleportTo(Position(CENTER.x, CENTER.y + 2, CENTER.z))
	end
	boss:teleportTo(CENTER)
	boss:setType("Channeling Earl Osam")
	f.channeling = true
	f.token = f.token + 1
	for _, spot in ipairs(SPHERE_SPOTS) do
		Game.createMonster("Magical Sphere", spot, true, true)
	end
	f.spheres = #SPHERE_SPOTS
	CENTER:sendMagicEffect(CONST_ME_ICETORNADO)
	addEvent(sphereTick, STEP_MS, bossId, f.token)
end

-- registered on Earl Osam and on Channeling Earl Osam
local osam = CreatureEvent("GraveDangerOsam")

function osam.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local f = fightOf(creature)
	if f.channeling then
		creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		return 0, primaryType, 0, secondaryType -- unlike Canary, really immune
	end
	f.lost = f.lost + math.abs(primaryDamage) + math.abs(secondaryDamage)
	if f.lost >= creature:getMaxHealth() * CHANNEL_EACH then
		f.lost = 0
		addEvent(startChannel, 100, creature:getId())
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

osam:register()

-- dead sphere: the next tick sees they are gone and ends the channeling
local sphere = CreatureEvent("GraveDangerSphere")
function sphere.onDeath(creature)
	creature:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
	return true
end
sphere:register()
