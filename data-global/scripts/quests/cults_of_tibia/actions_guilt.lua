local guilt = Action()

function guilt.onUse(player, item, fromPosition, target, toPosition)
	if not IsRunningGlobalDatapack() then
		return false
	end
	local fromPos = Position(33023, 31904, 15)
	local toPos = Position(33052, 31932, 15)

	if not player:getPosition():isInRange(fromPos, toPos) then
		return true
	end

	if not target or not target:isMonster() then
		return true
	end

	local targetName = target:getName():lower()
	local storageKey = "CheckTile"
	local healthStorageKey = "healthSoul"

	if targetName == "the remorseless corruptor" then
		target:addHealth(-17000)
		target:remove()
		toPosition:sendMagicEffect(CONST_ME_POFF)

		local newMonster = Game.createMonster("The Corruptor of Souls", toPosition)
		if newMonster then
			newMonster:registerEvent("CheckTile")

			local storedHealth = Game.getStorageValue(healthStorageKey)
			if storedHealth and storedHealth > 0 then
				local diff = newMonster:getHealth() - storedHealth
				if diff > 0 then
					newMonster:addHealth(-diff)
				end
			end

			Game.setStorageValue(storageKey, os.time() + 30)
		end

		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	elseif targetName == "the corruptor of souls" then
		Game.setStorageValue(storageKey, os.time() + 30)
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	return true
end

guilt:id(25774)
guilt:register()
