local ArbazilothFire = MoveEvent()

function ArbazilothFire.onStepIn(creature, item, position, fromPosition)
	if not creature or not creature:isMonster() then
		return true
	end

	local monster = creature:getName():lower()
	if monster == "arbaziloth" or monster == "weakened arbaziloth" then
		creature:unregisterEvent("ArbazilothImmunity")
		creature:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)

		local currentHealth = creature:getHealth()
		local newHealth = math.max(1, currentHealth - 5500)
		creature:setHealth(newHealth)

		local tile = Tile(position)
		if tile then
			local itemToRemove = tile:getItemById(49362)
			if itemToRemove then
				itemToRemove:remove()
				Game.setStorageValue("globalArbazilothFire", 0)
			end
		end
	end
	return true
end

ArbazilothFire:type("stepin")
ArbazilothFire:id(49362)
ArbazilothFire:register()
