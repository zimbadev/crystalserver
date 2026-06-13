local onDeathNewhaven = CreatureEvent("onDeathNewhaven")

function onDeathNewhaven.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamageUnjustified)
	if creature and creature:isPlayer() then
		if creature:getVocation():getId() == VOCATION_NONE then
			creature:teleportTo(Position(32534, 32513, 7))
			creature:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, 1)
			return true
		end

		if table.contains({ TOWNS_LIST.DAWNPORT, TOWNS_LIST.DAWNPORT_TUTORIAL }, creature:getTown():getId()) then
			creature:teleportTo(Position(32544, 32515, 7))
		end
	end
	return true
end

onDeathNewhaven:register()
