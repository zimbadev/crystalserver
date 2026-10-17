local mission9TheDeepestCatacombTeleport = MoveEvent()

local GLOBAL_AMPHORAS_OPEN = 101026

function mission9TheDeepestCatacombTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item.uid == 9257 and player:getStorageValue(Storage.Quest.U7_6.TheApeCity.Questline) >= 17 then
		player:teleportTo(Position(32749, 32536, 10))
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	elseif item.uid == 9258 then
		if Game.getStorageValue(GLOBAL_AMPHORAS_OPEN) > os.time() then
			player:teleportTo(Position(32885, 32632, 11))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(fromPosition)
			position:sendMagicEffect(CONST_ME_TELEPORT)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to break all 4 large amphoras to use this teleporter.")
		end
	else
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have access to this area.")
	end
	return true
end

mission9TheDeepestCatacombTeleport:type("stepin")
mission9TheDeepestCatacombTeleport:uid(9257, 9258)
mission9TheDeepestCatacombTeleport:register()
