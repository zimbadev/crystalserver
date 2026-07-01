-- Castle Crasher: step on 10 of the 13 Aragonia sandcastles.
-- Uses a bitmask in the SandcastleCount storage to count distinct castles.
local SANDCASTLE_MASK = Storage.Quest.U15_24.Targuna.LongLostTreasure.SandcastleCount

local ACHIEVEMENT_NAME = "Castle Crasher"
local CASTLES_REQUIRED = 10

local castlePositions = {
	{ x = 33533, y = 32705, z = 7 },
	{ x = 33534, y = 32714, z = 7 },
	{ x = 33497, y = 32735, z = 7 },
	{ x = 33527, y = 32725, z = 7 },
	{ x = 33486, y = 32739, z = 7 },
	{ x = 33514, y = 32736, z = 7 },
	{ x = 33507, y = 32740, z = 7 },
	{ x = 33517, y = 32748, z = 7 },
	{ x = 33525, y = 32736, z = 7 },
	{ x = 33539, y = 32701, z = 7 },
	{ x = 33549, y = 32703, z = 7 },
	{ x = 33536, y = 32721, z = 7 },
	{ x = 33536, y = 32731, z = 7 },
}

local function countBits(mask)
	local total = 0
	while mask > 0 do
		total = total + (mask % 2)
		mask = math.floor(mask / 2)
	end
	return total
end

local sandcastle = MoveEvent()

function sandcastle.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	-- Identify which castle by the position index.
	local index
	for i, pos in ipairs(castlePositions) do
		if position.x == pos.x and position.y == pos.y and position.z == pos.z then
			index = i
			break
		end
	end
	if not index then
		return true
	end

	if player:hasAchievement(ACHIEVEMENT_NAME) then
		return true
	end

	local mask = math.max(player:getStorageValue(SANDCASTLE_MASK), 0)
	local bit = 2 ^ (index - 1)
	if math.floor(mask / bit) % 2 == 1 then
		return true -- castle already counted
	end

	mask = mask + bit
	player:setStorageValue(SANDCASTLE_MASK, mask)
	position:sendMagicEffect(CONST_ME_POFF)

	if countBits(mask) >= CASTLES_REQUIRED then
		player:addAchievement(ACHIEVEMENT_NAME)
	end
	return true
end

sandcastle:type("stepin")
for _, pos in ipairs(castlePositions) do
	sandcastle:position(pos)
end
sandcastle:register()
