-- Don't change IDs if you don't change it in map editor
local ACTION_IDS = {
	NORTH = Storage.CrystalServer.TrainingRoom.NORTH,
	SOUTH = Storage.CrystalServer.TrainingRoom.SOUTH,
	WEST = Storage.CrystalServer.TrainingRoom.WEST,
	EAST = Storage.CrystalServer.TrainingRoom.EAST,
}

local trainingRoms = Action()

function trainingRoms.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	local emptyRoom = true
	local currentCharPosition = player:getPosition()
	local otherSidePosition = {}

	if item.actionid == ACTION_IDS.NORTH then
		otherSidePosition = currentCharPosition.y < fromPosition.y and { x = fromPosition.x, y = fromPosition.y + 1, z = fromPosition.z } or { x = fromPosition.x, y = fromPosition.y - 1, z = fromPosition.z, stackpos = 253 }
	elseif item.actionid == ACTION_IDS.SOUTH then
		otherSidePosition = currentCharPosition.y > fromPosition.y and { x = fromPosition.x, y = fromPosition.y - 1, z = fromPosition.z } or { x = fromPosition.x, y = fromPosition.y + 1, z = fromPosition.z, stackpos = 253 }
	elseif item.actionid == ACTION_IDS.EAST then
		otherSidePosition = currentCharPosition.x > fromPosition.x and { x = fromPosition.x - 1, y = fromPosition.y, z = fromPosition.z } or { x = fromPosition.x + 1, y = fromPosition.y, z = fromPosition.z, stackpos = 253 }
	elseif item.actionid == ACTION_IDS.WEST then
		otherSidePosition = currentCharPosition.x < fromPosition.x and { x = fromPosition.x + 1, y = fromPosition.y, z = fromPosition.z } or { x = fromPosition.x - 1, y = fromPosition.y, z = fromPosition.z, stackpos = 253 }
	end

	if otherSidePosition.x and otherSidePosition.y then
		local things = getThingfromPos(otherSidePosition)
		if things.itemid == 1 and getPlayerLevel(things.uid) > 0 then
			emptyRoom = false
		end
	end

	if emptyRoom then
		local destination = Position(otherSidePosition)
		player:teleportTo(destination)
		doSendMagicEffect(otherSidePosition, CONST_ME_TELEPORT)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The room is occupied, find another room.")
	end

	return true
end

trainingRoms:aid(2017, 2018, 2019, 2020)
trainingRoms:register()
