if not GlobalRottenBloodStates then
	GlobalRottenBloodStates = {}
end

local function cleanupVemiath()
	if GlobalRottenBloodStates["Vemiath"] then
		if GlobalRottenBloodStates["Vemiath"].teleportTimer then
			stopEvent(GlobalRottenBloodStates["Vemiath"].teleportTimer)
		end
		GlobalRottenBloodStates["Vemiath"] = nil
	end
end

local vemiathDeath = CreatureEvent("VemiathMechanicsDeath")

function vemiathDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not creature or creature:getName() ~= "Vemiath" then
		return true
	end

	cleanupVemiath()

	Game.setStorageValue("VemiathTeleportPaused", -1)
	Game.setStorageValue("VemiathElderBloodjawSpawnPaused", -1)

	return true
end

vemiathDeath:register()
