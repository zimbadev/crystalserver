local theAncientOasisMovement = MoveEvent()

function theAncientOasisMovement.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local newPosition = Position(position.x, position.y + 1, position.z)
	creature:teleportTo(newPosition)
	newPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

theAncientOasisMovement:aid(12107)
theAncientOasisMovement:register()
