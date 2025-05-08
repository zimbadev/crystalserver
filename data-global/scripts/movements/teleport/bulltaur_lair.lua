local setting = {
	[10536] = { effectTeleport = CONST_ME_TELEPORT, newPosition = Position(32872, 32374, 8) },
	[10537] = { effectTeleport = CONST_ME_TELEPORT, newPosition = Position(32800, 32367, 8) },
}

local bulltaurlair = MoveEvent()

function bulltaurlair.onStepIn(creature, item, position, fromPosition)
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

bulltaurlair:type("stepin")

for index, value in pairs(setting) do
	bulltaurlair:aid(index)
end

bulltaurlair:register()
