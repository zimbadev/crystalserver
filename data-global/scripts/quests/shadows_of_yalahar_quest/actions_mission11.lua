local ELEVATOR_FLOORS = {
	{ a = Position(32893, 31296, 9), b = Position(32893, 31296, 11) },
}
local AREA_SIZE = 2

local function isInArea(position, areaPosition)
	return position.z == areaPosition.z and position.x >= areaPosition.x and position.x < areaPosition.x + AREA_SIZE and position.y >= areaPosition.y and position.y < areaPosition.y + AREA_SIZE
end

local function sendAreaEffect(areaPosition, effect)
	for x = 0, AREA_SIZE - 1 do
		for y = 0, AREA_SIZE - 1 do
			Position(areaPosition.x + x, areaPosition.y + y, areaPosition.z):sendMagicEffect(effect)
		end
	end
end

local function teleportPlayer(fromPosition, toPosition)
	sendAreaEffect(fromPosition, CONST_ME_POFF)

	for x = 0, AREA_SIZE - 1 do
		for y = 0, AREA_SIZE - 1 do
			local originalPosition = Position(fromPosition.x + x, fromPosition.y + y, fromPosition.z)
			local tile = Tile(originalPosition)
			if tile then
				local creatures = tile:getCreatures()
				if creatures then
					for _, creature in ipairs(creatures) do
						if creature:isPlayer() then
							local targetPosition = Position(toPosition.x + x, toPosition.y + y, toPosition.z)
							originalPosition:sendMagicEffect(CONST_ME_TELEPORT)
							if creature:teleportTo(targetPosition) then
								targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
							else
								creature:sendCancelMessage("Something is wrong with the elevator.")
							end
						end
					end
				end
			end
		end
	end
	sendAreaEffect(toPosition, CONST_ME_POFF)
end

local elevatorYalahar = Action()
function elevatorYalahar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPosition = player:getPosition()

	for _, pair in ipairs(ELEVATOR_FLOORS) do
		if isInArea(playerPosition, pair.a) then
			teleportPlayer(pair.a, pair.b)
			return true
		end

		if isInArea(playerPosition, pair.b) then
			teleportPlayer(pair.b, pair.a)
			return true
		end
	end

	player:sendCancelMessage("You cannot use this here.")
	return true
end

elevatorYalahar:aid(4955)
elevatorYalahar:register()
