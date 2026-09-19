-- Burning Heart: Herald of Fire "red floor" plates (Crimson Court boss room).
-- Stepping on all three plates clears the room (fire fields + the boss's summons),
-- leaving only the Herald. The plates then reset and the boss starts a new round.
local RED_FLOOR_UNSTEPPED = 53096
local RED_FLOOR_STEPPED = 53095

local PLATES = {
	Position(32496, 32649, 15),
	Position(32503, 32656, 15),
	Position(32496, 32663, 15),
}

local FIRE_FIELD_IDS = { 2118, 2119, 2120 }

-- Boss arena bounds (matches the lever's specPos).
local AREA_FROM = Position(32487, 32649, 15)
local AREA_TO = Position(32504, 32664, 15)
local HERALD_CENTER = Position(32496, 32656, 15)
local HERALD_NAME = "herald of fire"

local function allStepped()
	for _, pos in ipairs(PLATES) do
		local tile = Tile(pos)
		if not (tile and tile:getItemById(RED_FLOOR_STEPPED)) then
			return false
		end
	end
	return true
end

local function resetPlates()
	for _, pos in ipairs(PLATES) do
		local tile = Tile(pos)
		if tile then
			local stepped = tile:getItemById(RED_FLOOR_STEPPED)
			if stepped then
				stepped:transform(RED_FLOOR_UNSTEPPED)
			end
		end
	end
end

local function clearRoom()
	-- Remove every fire field inside the arena.
	for x = AREA_FROM.x, AREA_TO.x do
		for y = AREA_FROM.y, AREA_TO.y do
			local tile = Tile(Position(x, y, AREA_FROM.z))
			if tile then
				for _, id in ipairs(FIRE_FIELD_IDS) do
					local field = tile:getItemById(id)
					if field then
						field:remove()
					end
				end
			end
		end
	end

	-- Remove the boss's summons (every monster in the arena except the Herald).
	for _, creature in ipairs(Game.getSpectators(HERALD_CENTER, false, false, 12, 12, 12, 12)) do
		if creature:isMonster() and creature:getName():lower() ~= HERALD_NAME then
			creature:remove()
		end
	end
end

local redFloor = MoveEvent()

function redFloor.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local tile = Tile(position)
	local unstepped = tile and tile:getItemById(RED_FLOOR_UNSTEPPED)
	if not unstepped then
		return true
	end

	unstepped:transform(RED_FLOOR_STEPPED)
	player:say("Click!", TALKTYPE_MONSTER_SAY, false, nil, position)

	if allStepped() then
		resetPlates()
		clearRoom()
	end
	return true
end

redFloor:type("stepin")
for _, pos in ipairs(PLATES) do
	redFloor:position(pos)
end
redFloor:register()
