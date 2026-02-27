local taintCooldown = {}
local positionSwapCooldown = {}
local rootCooldown = {}

-- Función para obtener el nivel de hazard del ícono (basado en party mínimo taint)
local function getPlayerHazardLevel(player)
	local hazardIcon = player:getIcon("rotten-hazard")
	if hazardIcon and hazardIcon.category == CreatureIconCategory_Quests and hazardIcon.icon == CreatureIconQuests_Hazard then
		local hazardLevel = hazardIcon.count or 0
		logger.debug("Combat System: Player {} using hazard level {} from icon", player:getName(), hazardLevel)
		return hazardLevel
	end
	logger.debug("Combat System: Player {} has no hazard icon, using level 0", player:getName())
	return 0
end

-- Función para verificar si el jugador está en zona de bakragore
local function isInBakragoreZone(player)
	local bakragoreMonsters = {
		"sopping corpus",
		"oozing corpus",
		"mycobiontic beetle",
		"bloated man-maggot",
		"walking pillar",
		"darklight matter",
		"darklight source",
		"darklight striker",
		"darklight emitter",
		"darklight construct",
		"wandering pillar",
		"converter",
		"oozing carcass",
		"sopping carcass",
		"rotten man-maggot",
		"meandering mushroom",
	}
	local bakragoreBosses = {
		"bakragore",
		"vemiath",
		"chagorz",
		"murcion",
		"ichgahal",
	}

	-- Verificar si está en las zonas de bakragore (puedes ajustar estas coordenadas)
	local pos = player:getPosition()
	return (pos.x >= 33800 and pos.x <= 34137 and pos.y >= 31653 and pos.y <= 31932 and (pos.z == 14 or pos.z == 15))
end

-- Función para crear Elder Bloodjaw instantáneamente
local function createElderBloodjawInstant(player, spawnPosition)
	local playerId = player:getId()

	-- Solo crear si el jugador no tiene cooldown
	if not taintCooldown[playerId] or os.time() > taintCooldown[playerId] then
		taintCooldown[playerId] = os.time() + 30
		local elderBloodjaw = Game.createMonster("elderbloodjaw", spawnPosition, true, true)
		if elderBloodjaw then
			logger.debug("Elder Bloodjaw spawned instantly for player {} at position {},{},{}", player:getName(), spawnPosition.x, spawnPosition.y, spawnPosition.z)
			return true
		else
			logger.warn("Failed to spawn Elder Bloodjaw for player {} at position {},{},{}", player:getName(), spawnPosition.x, spawnPosition.y, spawnPosition.z)
		end
	else
		logger.debug("Elder Bloodjaw spawn blocked by cooldown for player {}", player:getName())
	end
	return false
end

-- Función para intercambio de posiciones (Hazard 1 y 5)
local function handlePositionSwap(monster, target, chance)
	local targetPlayer = target:getPlayer()
	if not targetPlayer then
		return
	end

	local hazardLevel = getPlayerHazardLevel(targetPlayer)

	if not isInBakragoreZone(targetPlayer) then
		return
	end

	-- Hazard 1-4: 6% chance, Hazard 5+: 9% chance
	local swapChance = 0
	if hazardLevel >= 1 and hazardLevel <= 4 then
		swapChance = 2
	elseif hazardLevel >= 5 then
		swapChance = 5
	end

	if swapChance > 0 and math.random(1, 100) <= swapChance then
		local playerId = targetPlayer:getId()
		if not positionSwapCooldown[playerId] or os.time() > positionSwapCooldown[playerId] then
			positionSwapCooldown[playerId] = os.time() + 60 -- 60   segundos de cooldown

			-- Intercambio directo: Monster <-> Player que está siendo atacado
			local playerPos = targetPlayer:getPosition()

			-- Mostrar efecto 2 segundos antes en la posición del jugador
			playerPos:sendMagicEffect(CONST_ME_MORTAREA)

			addEvent(function(monsterId, playerId)
				local eventMonster = Monster(monsterId)
				local eventPlayer = Player(playerId)
				if eventMonster and eventPlayer then
					-- VERIFICAR SI EL JUGADOR SIGUE EN LA ZONA DE ROTTEN BLOOD
					if not isInBakragoreZone(eventPlayer) then
						logger.debug("Position swap cancelled: player {} is no longer in Rotten Blood zone", eventPlayer:getName())
						return
					end

					local monsterPosition = eventMonster:getPosition()
					local playerPosition = eventPlayer:getPosition()

					-- VERIFICAR QUE EL PLAYER ESTÉ EN EL MISMO PISO
					if monsterPosition.z ~= playerPosition.z then
						logger.debug("Position swap cancelled: player {} is on different floor (monster z: {}, player z: {})", eventPlayer:getName(), monsterPosition.z, playerPosition.z)
						return
					end

					-- VERIFICAR QUE EL PLAYER ESTÉ A MÁXIMO 2 SQM DEL MONSTER
					local distance = monsterPosition:getDistance(playerPosition)
					if distance > 2 then
						logger.debug("Position swap cancelled: player {} is too far from monster (distance: {} sqm)", eventPlayer:getName(), distance)
						return
					end

					-- Intercambiar posiciones: Monster va donde está el player, player va donde estaba el monster
					eventMonster:teleportTo(playerPosition, true)
					eventPlayer:teleportTo(monsterPosition, true)

					-- Efectos
					playerPosition:sendMagicEffect(CONST_ME_TELEPORT)
					monsterPosition:sendMagicEffect(CONST_ME_TELEPORT)

					logger.debug("Position swap executed: player {} and monster {} swapped positions", eventPlayer:getName(), eventMonster:getName())
				end
			end, 2000, monster:getId(), targetPlayer:getId())
		end
	end
end

-- Función para spawn de Elder Bloodjaw al morir monstruo (Hazard 2 y 6)
local function onPlayerKillMonster(player, target)
	local monster = target:getMonster()
	if not monster then
		return
	end

	local hazardLevel = getPlayerHazardLevel(player)
	if not isInBakragoreZone(player) then
		return
	end

	local bakragoreMonsters = {
		"sopping corpus",
		"oozing corpus",
		"mycobiontic beetle",
		"bloated man-maggot",
		"walking pillar",
		"darklight matter",
		"darklight source",
		"darklight striker",
		"darklight emitter",
		"darklight construct",
		"wandering pillar",
		"converter",
		"oozing carcass",
		"sopping carcass",
		"rotten man-maggot",
		"meandering mushroom",
	}

	local monsterName = monster:getName():lower()
	if not table.contains(bakragoreMonsters, monsterName) then
		return
	end

	-- Hazard 2: 6% chance, Hazard 6: 9% chance
	local spawnChance = 0
	if hazardLevel >= 6 then
		spawnChance = 9 -- Hazard 6+: 9% chance
	elseif hazardLevel >= 2 then
		spawnChance = 6 -- Hazard 2-5: 6% chance
	end

	if spawnChance > 0 and math.random(1, 100) <= spawnChance then
		local spawnPosition = monster:getPosition()
		createElderBloodjawInstant(player, spawnPosition)
	end
end

-- Función para aplicar root (Hazard 3)
local function applyRootEffect(monster, target)
	local targetPlayer = target:getPlayer()
	if not targetPlayer then
		return
	end

	local hazardLevel = getPlayerHazardLevel(targetPlayer)

	if not isInBakragoreZone(targetPlayer) then
		return
	end

	-- Hazard 3+: 100% chance (TESTING)
	if hazardLevel >= 3 then
		if math.random(1, 100) <= 3 then
			local playerId = targetPlayer:getId()
			if not rootCooldown[playerId] or os.time() > rootCooldown[playerId] then
				rootCooldown[playerId] = os.time() + 5 -- 5 segundos de cooldown

				-- Mostrar efecto visual de advertencia
				local playerPos = targetPlayer:getPosition()
				playerPos:sendMagicEffect(CONST_ME_ROOTS)

				-- Aplicar root después de 500ms
				addEvent(function(pId)
					local eventPlayer = Player(pId)
					if eventPlayer then
						-- Verificar que sigue en zona
						if not isInBakragoreZone(eventPlayer) then
							return
						end

						-- Aplicar condición de root
						local condition = Condition(CONDITION_ROOTED)
						condition:setParameter(CONDITION_PARAM_TICKS, 3000) -- 3 segundos
						eventPlayer:addCondition(condition)

						-- Efectos visuales
						eventPlayer:getPosition():sendMagicEffect(CONST_ME_ROOTS)
					end
				end, 500, playerId)
			end
		end
	end
end

-- Función para aumentar daño recibido (Hazard 4, 7, 8)
local function onMonsterAttackPlayer(target, primaryValue, secondaryValue)
	local targetPlayer = target:getPlayer()
	if not targetPlayer then
		return primaryValue, secondaryValue
	end

	local hazardLevel = getPlayerHazardLevel(targetPlayer)
	if not isInBakragoreZone(targetPlayer) then
		return primaryValue, secondaryValue
	end

	local damageIncrease = 0

	-- Hazard 4: +15% damage
	if hazardLevel >= 4 then
		damageIncrease = damageIncrease + 15
	end

	-- Hazard 7: +30% additional damage
	if hazardLevel >= 7 then
		damageIncrease = damageIncrease + 30
	end

	-- Hazard 8: +45% additional damage
	if hazardLevel >= 8 then
		damageIncrease = damageIncrease + 45
	end

	if damageIncrease > 0 then
		primaryValue = primaryValue + math.ceil(primaryValue * damageIncrease / 100)
		secondaryValue = secondaryValue + math.ceil(secondaryValue * damageIncrease / 100)
	end

	return primaryValue, secondaryValue
end

-- Callback principal de combate
local callback = EventCallback("CreatureOnCombatRottenBlood")

function callback.creatureOnCombat(caster, target, primaryValue, primaryType, secondaryValue, secondaryType, origin)
	if not caster or not target then
		return primaryValue, primaryType, secondaryValue, secondaryType
	end

	-- Monstruo atacando jugador
	if caster:getMonster() and target:getPlayer() then
		-- Intercambio de posiciones (Hazard 1 y 5)
		handlePositionSwap(caster, target, 0)

		-- Aplicar root (Hazard 3)
		applyRootEffect(caster, target)

		-- Aumentar daño recibido (Hazard 4, 7, 8)
		primaryValue, secondaryValue = onMonsterAttackPlayer(target, primaryValue, secondaryValue)
	end

	return primaryValue, primaryType, secondaryValue, secondaryType
end

callback:register()

-- Callback para muerte de monstruos (Elder Bloodjaw spawn)
local deathCallback = CreatureEvent("RottenBloodMonsterDeath")

function deathCallback.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not creature or creature:isPlayer() or creature:getMaster() then
		return true
	end

	-- Verificar si el killer es un jugador
	local killerPlayer = nil
	if killer and killer:isPlayer() then
		killerPlayer = killer
	elseif mostDamageKiller and mostDamageKiller:isPlayer() then
		killerPlayer = mostDamageKiller
	end

	if killerPlayer then
		onPlayerKillMonster(killerPlayer, creature)
	end

	return true
end

deathCallback:register()
