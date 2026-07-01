if not GlobalRottenBloodStates then
	GlobalRottenBloodStates = {}
end

local function cleanupBakragore()
	if GlobalRottenBloodStates["Bakragore"] then
		if GlobalRottenBloodStates["Bakragore"].teleportTimer then
			stopEvent(GlobalRottenBloodStates["Bakragore"].teleportTimer)
		end
		GlobalRottenBloodStates["Bakragore"] = nil
	end
end

local bakragoreDeath = CreatureEvent("BakragoreMechanicsDeath")

function bakragoreDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not creature or creature:getName() ~= "Bakragore" then
		return true
	end

	local essenceCount = creature:getStorageValue(88888) or 0

	if essenceCount > 0 and corpse then
		logger.debug("Bakragore died with {} essences, checking for special bags", essenceCount)

		local bagChances = {
			[1] = 5, -- 5% chance
			[2] = 8, -- 8% chance
			[3] = 12, -- 12% chance
			[4] = 15, -- 15% chance
		}

		local chancePerBag = bagChances[essenceCount] or 5
		local bagTypes = { 43895, 43860 } -- bag you covet, grand sanguine

		local roll = math.random(100)
		if roll <= chancePerBag then
			local bagId = bagTypes[math.random(#bagTypes)]
			corpse:addItem(bagId, 1)
			logger.debug("Added special bag (type: {}) with {} essences (chance: {}%, roll: {})", bagId, essenceCount, chancePerBag, roll)
		else
			logger.debug("No special bag added with {} essences (chance: {}%, roll: {})", essenceCount, chancePerBag, roll)
		end
	end

	cleanupBakragore()

	Game.setStorageValue("BakragoreTeleportPaused", -1)
	Game.setStorageValue("BakragoreElderBloodjawSpawnPaused", -1)

	return true
end

bakragoreDeath:register()
