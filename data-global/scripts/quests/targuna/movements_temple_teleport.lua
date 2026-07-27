-- Hidden Lizard Temple: return teleport (cave center -2 -> north entrance)
local FROM_POSITION = Position(31941, 31928, 9)
local TO_POSITION = Position(31935, 31861, 7)

local templeReturn = MoveEvent()

function templeReturn.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(TO_POSITION)
	TO_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

templeReturn:type("stepin")
templeReturn:position(FROM_POSITION)
templeReturn:register()
