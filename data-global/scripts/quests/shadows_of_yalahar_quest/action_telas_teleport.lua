local telasLevers = {
	{ telas = Position(33271, 31797, 6), lab = Position(33271, 31797, 11) },
}

local telasElevatorLevers = Action()

function telasElevatorLevers.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2773 then
		item:transform(2772)
		return true
	end

	if item.itemid == 2772 then
		local playerPosition = player:getPosition()
		local teleportTo

		local elevator = telasLevers[1]

		if playerPosition == elevator.telas then
			teleportTo = elevator.lab
		elseif playerPosition == elevator.lab then
			teleportTo = elevator.telas
		end

		if teleportTo then
			item:transform(2773)

			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(teleportTo)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			item:transform(2773)
			toPosition:sendMagicEffect(CONST_ME_POFF)
		end
		return true
	end
	return true
end

telasElevatorLevers:aid(57235)
telasElevatorLevers:register()
