local config = {
	{ position = { x = 34038, y = 31726, z = 10 }, destination = { x = 34000, y = 31733, z = 9 } },
	{ position = { x = 34000, y = 31732, z = 9 }, destination = { x = 34038, y = 31727, z = 10 } },
}

local entrance = Action()
function entrance.onUse(creature, item, position, fromPosition)
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
	entrance:position(config[value].position)
end
entrance:register()
