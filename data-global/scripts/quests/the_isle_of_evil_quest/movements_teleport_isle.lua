local teleportEvilIsle = MoveEvent()

function teleportEvilIsle.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local player = Player(creature)
	player:teleportTo(Position(32754, 31469, 6))

	return true
end

teleportEvilIsle:position(Position(32753, 31452, 7))
teleportEvilIsle:register()
