local teleportPosition = Position(34003, 31841, 14)
local destinationPosition = Position(34122, 31879, 14)

local teleportTile = MoveEvent()

function teleportTile.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if position ~= teleportPosition then
		return true
	end

	local tile = Tile(position)
	if not tile then
		return true
	end

	local hasCorrectItem = false
	for _, item in pairs(tile:getItems()) do
		if item:getId() == 42676 then
			hasCorrectItem = true
			break
		end
	end

	if not hasCorrectItem then
		return true
	end

	player:teleportTo(destinationPosition)
	destinationPosition:sendMagicEffect(CONST_ME_TELEPORT)
	position:sendMagicEffect(CONST_ME_TELEPORT)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been teleported outside.")

	return true
end

teleportTile:position(teleportPosition)
teleportTile:register()
