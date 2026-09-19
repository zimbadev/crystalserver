local chagorzDeath = CreatureEvent("ChagorzMechanicsDeath")

function chagorzDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not creature or creature:getName() ~= "Chagorz" then
		return true
	end

	Game.setStorageValue("ChagorzTeleportPaused", -1)
	Game.setStorageValue("ChagorzElderBloodjawSpawnPaused", -1)

	return true
end

chagorzDeath:register()
