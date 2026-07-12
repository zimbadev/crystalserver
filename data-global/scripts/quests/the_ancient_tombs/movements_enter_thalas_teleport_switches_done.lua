local enterThalasTeleport = MoveEvent()
function enterThalasTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if Game.getStorageValue(Storage.Quest.U7_4.TheAncientTombs.ThalasSwitchesGlobalStorage) < 8 then
		player:teleportTo(fromPosition, true)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	local destination = Position(33367, 32805, 14)
	player:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
enterThalasTeleport:type("stepin")
enterThalasTeleport:uid(50135)
enterThalasTeleport:register()
