local scimitarPos = { x = 33205, y = 32537, z = 6 }
local waterPos = { x = 33207, y = 32537, z = 6 }
local caveEntrancePos = { x = 33206, y = 32536, z = 6 }

local scimitarItemId = 3307
local placedSimitarItemId = 5858
local waterPoolId = 2886
local caveEntranceId = 7181
local caveMountainId = 1085
local scimitarCracksId = 6298

local effectPosition = {
	Position(33206, 32536, 6),
	Position(33206, 32537, 6),
	Position(33205, 32537, 6),
	Position(33207, 32537, 6),
}
-- revert scimitar transformation
local function revertScimitar()
	local tile = Tile(scimitarPos)
	if not tile then
		return
	end

	local item = tile:getItemById(placedSimitarItemId)
	if item then
		item:transform(scimitarCracksId)
	end
end

-- revert cave entrance
local function revertEntrance()
	local tile = Tile(caveEntrancePos)
	if not tile then
		return
	end

	local item = tile:getItemById(caveEntranceId)
	if item then
		item:transform(caveMountainId)
	end
end

-- scimitar tranformation (2 minutes action)
local scimitarTransf = MoveEvent()
function scimitarTransf.onAddItem(moveitem, tileitem, position)
	if moveitem.itemid ~= scimitarItemId then
		return true
	end

	local tile = Tile(position):getItemById(scimitarCracksId)
	if not tile then
		return true
	end
	tile:transform(placedSimitarItemId)
	Item(moveitem.uid):remove(1)
	addEvent(revertScimitar, 2 * 60 * 1000)
	return true
end

local waterEvent = MoveEvent()
function waterEvent.onAddItem(moveitem, tileitem, position)
	if moveitem.itemid ~= waterPoolId then
		return true
	end
	if position.x ~= waterPos.x or position.y ~= waterPos.y or position.z ~= waterPos.z then
		return true
	end

	local scimitarTile = Tile(scimitarPos)
	if not scimitarTile then
		return true
	end
	local placed = scimitarTile:getItemById(placedSimitarItemId)
	if not placed then
		return true
	end

	local cPos = Position(caveEntrancePos.x, caveEntrancePos.y, caveEntrancePos.z)
	local mountain = Tile(cPos):getItemById(caveMountainId)
	if mountain then
		mountain:transform(caveEntranceId)
	end
	for i = 1, #effectPosition do
		effectPosition[i]:sendMagicEffect(CONST_ME_POFF)
	end
	addEvent(revertEntrance, 2 * 60 * 1000)
	return true
end

scimitarTransf:type("additem")
scimitarTransf:aid(50366)
scimitarTransf:register()
waterEvent:type("additem")
waterEvent:id(waterPoolId)
waterEvent:register()
