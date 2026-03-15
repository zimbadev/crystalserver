-- First magic wall (first lever)
local firstSealCloseMw = MoveEvent()

function firstSealCloseMw.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local magicWallPosition = { x = 32259, y = 31890, z = 10 }

	addEvent(function()
		local tile = Tile(magicWallPosition)
		if tile and not tile:getItemById(2129) then
			if Position(magicWallPosition):createItem(2129) then
			end
		end
	end, 120000)

	return true
end

firstSealCloseMw:position({ x = 32315, y = 31913, z = 13 })
firstSealCloseMw:register()

-- Second magic wall (second lever)
local secondSealCloseMw = MoveEvent()

function secondSealCloseMw.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local magicWallPosition = { x = 32259, y = 31891, z = 10 }

	addEvent(function()
		local tile = Tile(magicWallPosition)
		if tile and not tile:getItemById(2129) then
			if Position(magicWallPosition):createItem(2129) then
			end
		end
	end, 120000)

	return true
end

secondSealCloseMw:position({ x = 32210, y = 31898, z = 12 })
secondSealCloseMw:register()

-- Third magic wall (third lever)
local thirdSealCloseMw = MoveEvent()

function thirdSealCloseMw.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local magicWallPosition = { x = 32266, y = 31860, z = 11 }

	addEvent(function()
		Position(magicWallPosition):removeItem(369)

		local leverPosition = { x = 32266, y = 31861, z = 11 }
		Position.revertItem(magicWallPosition, 2129, leverPosition, 2773, 27260)
	end, 3000)

	return true
end

thirdSealCloseMw:position({ x = 32266, y = 31860, z = 12 })
thirdSealCloseMw:register()
