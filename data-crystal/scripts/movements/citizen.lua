local config = {
	[Storage.CrystalServer.Citizen.Karmia] = TOWNS_LIST.KARMIA,
	[Storage.CrystalServer.Citizen.DesertCity] = TOWNS_LIST.DESERT_CITY,
	[Storage.CrystalServer.Citizen.Inferno] = TOWNS_LIST.INFERNO,
	[Storage.CrystalServer.Citizen.Venore] = TOWNS_LIST.VENORE,
	[Storage.CrystalServer.Citizen.Tiquanda] = TOWNS_LIST.TIQUANDA,
	[Storage.CrystalServer.Citizen.PremiumIsland] = TOWNS_LIST.PREMIUM_ISLAND,
	[Storage.CrystalServer.Citizen.Folda] = TOWNS_LIST.FOLDA,
	[Storage.CrystalServer.Citizen.LibertyBay] = TOWNS_LIST.LIBERTY_BAY,
}

local citizen = MoveEvent()

function citizen.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local townId = config[item.uid]
	if not townId then
		return true
	end

	local town = Town(townId)
	if not town then
		return true
	end

	player:setTown(town)
	player:teleportTo(town:getTemplePosition())
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_LOOK, "You are now a citizen of " .. town:getName() .. ".")
	player:save()
	return true
end

citizen:type("stepin")

for index, value in pairs(config) do
	citizen:uid(index)
end

citizen:register()
