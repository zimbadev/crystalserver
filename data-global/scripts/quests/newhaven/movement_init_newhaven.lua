local initNewhaven = MoveEvent()

function initNewhaven.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:teleportTo(fromPosition, true)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "I should not climb down again but rather venture forth.")

	return true
end

initNewhaven:type("stepin")
initNewhaven:position(Position(32533, 32513, 7))
initNewhaven:register()
