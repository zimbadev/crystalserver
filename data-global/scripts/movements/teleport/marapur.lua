local setting = {
	[10425] = { effectTeleport = CONST_ME_TELEPORT, newPosition = Position(33842, 32853, 7) },
	[10426] = { effectTeleport = CONST_ME_TELEPORT, newPosition = Position(33036, 32738, 2) },
}

local marapur = MoveEvent()

function marapur.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = setting[item.actionid]
	if teleport then
		local newPosition = teleport.newPosition
		player:teleportTo(newPosition)

		fromPosition:sendMagicEffect(teleport.effectTeleport)
		newPosition:sendMagicEffect(teleport.effectTeleport)
	end
	return true
end

marapur:type("stepin")

for index, value in pairs(setting) do
	marapur:aid(index)
end

marapur:register()
