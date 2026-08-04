local newhavenOnLogin = CreatureEvent("NewhavenOnLogin")

function newhavenOnLogin.onLogin(player)
	if not player then
		return false
	end

	if player:getVocation():getId() == VOCATION_NONE and not player:getGroup():getAccess() then
		if player:getStorageValue(Storage.Quest.U15_12.newhavenCitizen) <= 0 then
			player:teleportTo(Position(32534, 32513, 7))
			player:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, 1)
		end
	end

	if player:getStorageValue(Storage.Quest.U15_12.newhavenCitizen) == 1 then
		player:registerEvent("onDeathNewhaven")

		if player:getVocation():getId() ~= VOCATION_NONE then
			Newhaven.giveStarterItems(player)
		end
	end

	return true
end

newhavenOnLogin:register()
