local config = {
	[Storage.CrystalServer.Portals.S1] = Position(702, 365, 9),
	[Storage.CrystalServer.Portals.S2] = Position(648, 425, 8),
}

local goUnderWater = MoveEvent()

function goUnderWater.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetConfig = config[item.uid]
	if targetConfig then
		player:teleportTo(targetConfig)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	return true
end

goUnderWater:type("stepin")

for index, _ in pairs(config) do
	goUnderWater:uid(index)
end

goUnderWater:register()
