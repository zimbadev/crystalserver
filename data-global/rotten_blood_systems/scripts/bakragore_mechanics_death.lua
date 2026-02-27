-- Estados globales para cleanup
if not GlobalRottenBloodStates then
	GlobalRottenBloodStates = {}
end

local function cleanupBakragore()
	-- Limpiar estado global de Bakragore
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

	-- Obtener essenceCount del boss
	local essenceCount = creature:getStorageValue(88888) or 0

	-- Sistema de loot dinámico basado en esencias
	if essenceCount > 0 and corpse then
		logger.debug("Bakragore died with {} essences, checking for special bags", essenceCount)

		-- Probabilidades de bolsas adicionales según esencias
		-- 1 esencia: 5% chance de bolsa adicional
		-- 2 esencias: 8% chance de bolsa adicional
		-- 3 esencias: 12% chance de bolsa adicional
		-- 4 esencias: 15% chance de bolsa adicional

		local bagChances = {
			[1] = 5, -- 1 esencia: 5% chance
			[2] = 8, -- 2 esencias: 8% chance
			[3] = 12, -- 3 esencias: 12% chance
			[4] = 15, -- 4 esencias: 15% chance
		}

		local chancePerBag = bagChances[essenceCount] or 5
		local bagTypes = { 43895, 43860 } -- bag you covet, grand sanguine

		-- Intentar agregar una bolsa adicional
		local roll = math.random(100)
		if roll <= chancePerBag then
			-- Elegir tipo de bolsa aleatoriamente
			local bagId = bagTypes[math.random(#bagTypes)]
			corpse:addItem(bagId, 1)
			logger.debug("Added special bag (type: {}) with {} essences (chance: {}%, roll: {})", bagId, essenceCount, chancePerBag, roll)
		else
			logger.debug("No special bag added with {} essences (chance: {}%, roll: {})", essenceCount, chancePerBag, roll)
		end
	end

	-- Limpiar mecánicas del boss
	cleanupBakragore()

	-- Resetear GlobalStorage values para Bakragore
	Game.setStorageValue("BakragoreTeleportPaused", -1)
	Game.setStorageValue("BakragoreElderBloodjawSpawnPaused", -1)

	return true
end

bakragoreDeath:register()
