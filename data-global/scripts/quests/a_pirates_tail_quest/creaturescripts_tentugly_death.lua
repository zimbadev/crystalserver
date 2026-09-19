local tentuglysDeath = CreatureEvent("tentuglysDeath")

function tentuglysDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return true
	end

	local damageMap = creature:getMonster():getDamageMap()

	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player and player:getStorageValue(Storage.Quest.U12_60.APiratesTail.TentuglyKilled) < 1 then
			player:setStorageValue(Storage.Quest.U12_60.APiratesTail.TentuglyKilled, 1)

			if not player:hasMount(175) then
				player:addMount(175)
				player:addAchievement("Release the Kraken")
			end
		end
	end

	return true
end

tentuglysDeath:register()
