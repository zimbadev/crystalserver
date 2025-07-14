local config = {
	firePositions = {
		Position(32100, 32084, 7),
		Position(32101, 32084, 7),
		Position(32102, 32084, 7),
		Position(32100, 32085, 7),
		Position(32102, 32085, 7),
		Position(32100, 32086, 7),
		Position(32101, 32086, 7),
		Position(32102, 32086, 7),
	},
	swordPosition = Position(32101, 32085, 7),
}

local SoFEvent = MoveEvent()

function SoFEvent.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	for _, pos in ipairs(config.firePositions) do
		local fieldItem = Tile(pos):getItemById(2123)
		if fieldItem then
			fieldItem:transform(2125)
		end
	end

	local swordItem = Tile(config.swordPosition):getItemById(3271)
	if swordItem then
		swordItem:remove()
		config.swordPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
	end

	return true
end

SoFEvent:type("stepin")
SoFEvent:aid(5635, 5636)
SoFEvent:register()
