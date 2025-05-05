local config = {
	[62221] = Position(33574, 32223, 7),
	[62222] = Position(33575, 32223, 7),
	[62223] = Position(33338, 32126, 7),
	[62224] = Position(33339, 32126, 7),
}

local candiaTeleport = MoveEvent()

function candiaTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local actionId = item:getActionId()

	local targetPosition = config[actionId]
	if not targetPosition then
		return true
	end

	player:teleportTo(targetPosition)
	return true
end

candiaTeleport:type("stepin")

for actionId, targetPos in pairs(config) do
	candiaTeleport:aid(actionId)
end

candiaTeleport:register()
