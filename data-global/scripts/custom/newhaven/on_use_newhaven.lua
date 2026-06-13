local MIN_LEVEL_TO_TRAVEL = 8

local doorNewhaven = Action()

function doorNewhaven.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < MIN_LEVEL_TO_TRAVEL then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to be at least level " .. MIN_LEVEL_TO_TRAVEL .. ".")
		return false
	end

	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(Position(32555, 32497, 7), true)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

	return true
end

doorNewhaven:id(51777, 51778)
doorNewhaven:register()
