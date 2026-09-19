local WHITE_SILK_FLOWER_ID = 34008
local LION_STATUE_ID = 34015

local config = {
	{
		position = Position(33516, 31043, 8),
		destination = Position(33521, 31044, 8),
	},
	{
		position = Position(33521, 31043, 8),
		destination = Position(33516, 31044, 8),
	},
}

local lionStatue = Action()

function lionStatue.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= LION_STATUE_ID then
		return false
	end

	if player:getItemCount(WHITE_SILK_FLOWER_ID) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a white silk flower to pass.")
		return true
	end

	for _, teleport in ipairs(config) do
		if fromPosition == teleport.position then
			player:teleportTo(teleport.destination)
			player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
			return true
		end
	end

	return false
end

for _, teleport in ipairs(config) do
	lionStatue:position(teleport.position)
end

lionStatue:register()
