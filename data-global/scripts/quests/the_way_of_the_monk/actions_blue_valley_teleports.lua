local config = {
	{ position = { x = 33605, y = 31468, z = 7 }, destination = { x = 32456, y = 32291, z = 7 } },
	{ position = { x = 33601, y = 31468, z = 7 }, destination = { x = 32456, y = 32291, z = 7 } },
	{ position = { x = 32456, y = 32290, z = 7 }, destination = { x = 33614, y = 31494, z = 7 } },
	{ position = { x = 32203, y = 32303, z = 6 }, destination = { x = 33614, y = 31494, z = 7 } },
}

local teleport = Action()
function teleport.onUse(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	for value in pairs(config) do
		if Position(config[value].position) == item:getPosition() then
			player:teleportTo(Position(config[value].destination))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
end

for value in pairs(config) do
	teleport:position(config[value].position)
end
teleport:register()
