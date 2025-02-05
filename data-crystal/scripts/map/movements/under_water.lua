local config = {
	[Storage.CrystalServer.UnderWater.S1] = Position(265, 396, 8),
	[Storage.CrystalServer.UnderWater.S2] = Position(265, 396, 8),

	[Storage.CrystalServer.UnderWater.S3] = Position(344, 429, 8),
	[Storage.CrystalServer.UnderWater.S4] = Position(344, 429, 8),

	[Storage.CrystalServer.UnderWater.S5] = Position(538, 559, 8),
	[Storage.CrystalServer.UnderWater.S6] = Position(538, 559, 8),

	[Storage.CrystalServer.UnderWater.S7] = Position(627, 676, 8),
	[Storage.CrystalServer.UnderWater.S8] = Position(627, 676, 8),
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now at the destination.")
		return true
	end

	return true
end

goUnderWater:type("stepin")

for index, _ in pairs(config) do
	goUnderWater:uid(index)
end

goUnderWater:register()
