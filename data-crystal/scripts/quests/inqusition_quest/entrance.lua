local throneConfig = {
	{ storage = Storage.Quest.U8_0.BarbarianArena.GreenhornDoor, value = 1 },
	{ storage = Storage.Quest.U8_0.BarbarianArena.ScrapperDoor, value = 1 },
	{ storage = Storage.Quest.U8_0.BarbarianArena.WarlordDoor, value = 1 },
}

local function hasTouchedOneThrone(player)
	for i = 1, #throneConfig do
		local config = throneConfig[i]
		if player:getStorageValue(config.storage) == config.value then
			return true
		end
	end
	return false
end

local config = {
	{ position = {x = 446, y = 808, z = 12}, destination = {x = 3071, y = 4063, z = 8} },
}

local entrance = MoveEvent()
function entrance.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if hasTouchedOneThrone(player) and player:getLevel() >= 100 and player:getStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Questline) >= 20 then
		for i = 1, #config do
			local cfg = config[i]
			if Position(cfg.position.x, cfg.position.y, cfg.position.z) == player:getPosition() then
				local destination = Position(cfg.destination.x, cfg.destination.y, cfg.destination.z)
				player:teleportTo(destination)
				position:sendMagicEffect(CONST_ME_TELEPORT)
				destination:sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end
		end
	end

	player:teleportTo(fromPosition, true)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

entrance:type("stepin")
for i = 1, #config do
	entrance:position(Position(config[i].position.x, config[i].position.y, config[i].position.z))
end

entrance:register()
