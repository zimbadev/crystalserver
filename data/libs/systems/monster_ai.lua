--[[
    Sistema de Inteligencia Artificial para Monsters
    Creado para manejar comportamientos avanzados de monsters
    
    Características:
    - Curaciones inteligentes
    - Combos con aliados
    - Magic walls defensivas
    - Critical hits y Fatal hits (outslaugh)
    - Priorización de objetivos
    
    USO DE CRITICAL/FATAL HITS:
    1. Método automático: El sistema calculará automáticamente critical/fatal hits
       basado en la configuración del monster.
    
    2. Método manual (desde scripts de monster):
       local finalDamage, isCrit, isFatal = MonsterAI.calculateDamageModifier(monster, baseDamage)
       
    3. Aplicar daño con modificadores:
       MonsterAI.applyDamageWithModifiers(monster, target, baseDamage, CONST_ME_DRAWBLOOD, "exevo gran mas flam")
    
    EFECTOS VISUALES:
    - Critical Hit: Efecto 173
    - Fatal Hit: Efecto 230
    
    MONSTER SAY:
    - Curaciones: Configurar monsterSay en primary/secondary del healing
    - Habilidades: Configurar monsterSay en cada ability o pasar como parámetro a applyDamageWithModifiers
]]

if not MonsterAI then
	MonsterAI = {}
end

-- Configuración de monsters con IA
MonsterAI.Config = {
	["Elder Bloodjaw"] = {
		enabled = true,

		-- Sistema de critical hits y fatal hits
		criticalHits = {
			enabled = true,
			chance = 15, -- 15% de probabilidad de critical hit (más agresivo)
			damageBonus = 60, -- +60% de daño adicional
		},
		fatalHits = {
			enabled = false,
			chance = 8, -- 8% de probabilidad de fatal hit (outslaugh)
			damageBonus = 120, -- +120% de daño adicional
		},

		-- Sin curación (no tiene healing)
		healing = {
			enabled = false,
		},

		-- Sin habilidades especiales (solo targeting)
		abilities = {},

		-- Priorización de objetivos: PRIORIZA KNIGHTS
		targeting = {
			enabled = true,
			priorityByVocation = {
				[1] = 70, -- Sorcerer
				[2] = 70, -- Druid
				[3] = 75, -- Paladin
				[4] = 100, -- Knight (MÁXIMA PRIORIDAD)
				[5] = 70, -- Master Sorcerer
				[6] = 70, -- Elder Druid
				[7] = 75, -- Royal Paladin
				[8] = 100, -- Elite Knight (MÁXIMA PRIORIDAD)
				[9] = 70, -- Monk
				[10] = 70, -- Exalted Monk
			},
			priorityLowHealth = true,
			lowHealthThreshold = 30,
		},
	},
}

-- Estados globales de IA (timers, cooldowns)
if not MonsterAI.States then
	MonsterAI.States = {}
end

-- Función auxiliar: Obtener estado de un monster
local function getMonsterState(monsterId)
	if not MonsterAI.States[monsterId] then
		MonsterAI.States[monsterId] = {
			lastHealTime = 0,
			lastWallTime = 0,
			lastComboCheck = 0,
			wallCooldown = 0,
			usedSecondaryHeal = false,
			fleeUntil = 0, -- Timestamp hasta cuando debe huir
			fleeFrom = 0, -- ID de la criatura de la que huye
		}
	end
	return MonsterAI.States[monsterId]
end

-- Función auxiliar: Limpiar estado de monster muerto
local function cleanupMonsterState(monsterId)
	MonsterAI.States[monsterId] = nil
end

-- Función: Buscar aliados cercanos
function MonsterAI.findNearbyAllies(monster, allyNames, range)
	if not monster then
		return {}
	end

	local pos = monster:getPosition()
	local allies = {}

	local specs = Game.getSpectators(pos, false, false, range, range, range, range)
	for _, creature in ipairs(specs) do
		if creature:isMonster() then
			local creatureName = creature:getName()
			for _, allyName in ipairs(allyNames) do
				if creatureName == allyName and creature:getId() ~= monster:getId() then
					table.insert(allies, creature)
					break
				end
			end
		end
	end

	return allies
end

-- Función: Calcular porcentaje de vida
function MonsterAI.getHealthPercent(creature)
	if not creature then
		return 100
	end
	return math.floor((creature:getHealth() / creature:getMaxHealth()) * 100)
end

-- Función: Calcular y aplicar critical/fatal hits
function MonsterAI.calculateDamageModifier(monster, baseDamage)
	if not monster then
		return baseDamage, false, false
	end

	local monsterName = monster:getName()
	local config = MonsterAI.Config[monsterName]

	if not config then
		return baseDamage, false, false
	end

	local finalDamage = baseDamage
	local isCritical = false
	local isFatal = false

	-- Verificar fatal hit primero (tiene prioridad sobre critical)
	if config.fatalHits and config.fatalHits.enabled then
		local fatalChance = math.random(1, 100)
		if fatalChance <= config.fatalHits.chance then
			-- Fatal hit! Aplicar bonus de daño
			local bonusMultiplier = 1 + (config.fatalHits.damageBonus / 100)
			finalDamage = math.floor(baseDamage * bonusMultiplier)
			isFatal = true
			return finalDamage, false, true
		end
	end

	-- Si no fue fatal, verificar critical hit
	if config.criticalHits and config.criticalHits.enabled then
		local critChance = math.random(1, 100)
		if critChance <= config.criticalHits.chance then
			-- Critical hit! Aplicar bonus de daño
			local bonusMultiplier = 1 + (config.criticalHits.damageBonus / 100)
			finalDamage = math.floor(baseDamage * bonusMultiplier)
			isCritical = true
			return finalDamage, true, false
		end
	end

	return finalDamage, isCritical, isFatal
end

-- Función: Aplicar daño con posibilidad de critical/fatal
function MonsterAI.applyDamageWithModifiers(monster, target, baseDamage, damageType, monsterSay)
	if not monster or not target then
		return false
	end

	-- Monster dice palabras mágicas (antes del ataque)
	if monsterSay and type(monsterSay) == "string" then
		monster:say(monsterSay, TALKTYPE_MONSTER_SAY)
	end

	-- Calcular si es critical o fatal
	local finalDamage, isCritical, isFatal = MonsterAI.calculateDamageModifier(monster, math.abs(baseDamage))

	-- Aplicar el daño
	local damageValue = -finalDamage -- Negativo para daño
	target:addHealth(damageValue)

	-- Efectos visuales y texto
	local targetPos = target:getPosition()

	if isFatal then
		-- Fatal hit - efecto especial (230)
		targetPos:sendMagicEffect(230)
	elseif isCritical then
		-- Critical hit - efecto especial (173)
		targetPos:sendMagicEffect(173)
	else
		-- Hit normal - efecto basado en tipo de daño
		local effect = CONST_ME_DRAWBLOOD
		if damageType then
			effect = damageType
		end
		targetPos:sendMagicEffect(effect)
	end

	return true
end

-- Función: Curación inteligente
function MonsterAI.handleHealing(monster, config)
	if not monster or not config or not config.enabled then
		return false
	end

	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)
	local healthPercent = MonsterAI.getHealthPercent(monster)
	local currentTime = os.time() * 1000 -- Convertir a milisegundos

	-- Verificar si necesita curación secundaria (emergencia)
	if config.secondary and healthPercent <= config.secondary.healthPercent then
		local timeSinceHeal = currentTime - state.lastHealTime
		if timeSinceHeal >= config.secondary.interval then
			-- Aplicar curación secundaria
			local healAmount = math.random(config.secondary.minHeal, config.secondary.maxHeal)
			monster:addHealth(healAmount)
			monster:getPosition():sendMagicEffect(config.secondary.effect)

			-- Monster dice palabras mágicas
			if config.secondary.monsterSay then
				monster:say(config.secondary.monsterSay, TALKTYPE_MONSTER_SAY)
			end

			state.lastHealTime = currentTime
			state.usedSecondaryHeal = true
			return true
		end
	end

	-- Verificar si necesita curación primaria
	if config.primary and healthPercent <= config.primary.healthPercent then
		local timeSinceHeal = currentTime - state.lastHealTime
		if timeSinceHeal >= config.primary.interval then
			-- Aplicar curación primaria
			local healAmount = math.random(config.primary.minHeal, config.primary.maxHeal)
			monster:addHealth(healAmount)
			monster:getPosition():sendMagicEffect(config.primary.effect)

			-- Monster dice palabras mágicas
			if config.primary.monsterSay then
				monster:say(config.primary.monsterSay, TALKTYPE_MONSTER_SAY)
			end

			state.lastHealTime = currentTime
			return true
		end
	end

	return false
end

-- Función: Crear magic wall defensiva
function MonsterAI.createDefensiveWall(monster, attacker, config)
	if not monster or not attacker or not config or not config.enabled then
		return false
	end

	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)
	local currentTime = os.time() * 1000 -- Convertir a milisegundos
	local healthPercent = MonsterAI.getHealthPercent(monster)

	-- Verificar condiciones
	if healthPercent > config.healthPercent then
		return false
	end

	-- Verificar cooldown
	if currentTime < state.wallCooldown then
		return false
	end

	-- Verificar distancia
	local monsterPos = monster:getPosition()
	local attackerPos = attacker:getPosition()
	local distance = monsterPos:getDistance(attackerPos)

	if distance > config.maxDistance then
		return false
	end

	-- Calcular posición para la wall (entre el monster y el atacante)
	local wallPos = Position(math.floor((monsterPos.x + attackerPos.x) / 2), math.floor((monsterPos.y + attackerPos.y) / 2), monsterPos.z)

	-- Usar itemId configurable (default: 1497)
	local wallItemId = config.itemId or 1497

	-- Crear magic wall
	local tile = Tile(wallPos)
	if tile then
		local item = Game.createItem(wallItemId, 1, wallPos)
		if item then
			-- Programar eliminación de la wall
			addEvent(function()
				local wall = Tile(wallPos):getItemById(wallItemId)
				if wall then
					wall:remove()
				end
			end, config.wallDuration)

			-- Establecer cooldown aleatorio
			local nextCooldown = math.random(config.minCooldown, config.maxCooldown)
			state.wallCooldown = currentTime + nextCooldown

			wallPos:sendMagicEffect(CONST_ME_ENERGYAREA)

			-- Huir después de crear la wall (caminar naturalmente)
			if config.fleeAfterWall then
				-- Activar modo de huida temporal
				-- El monster usará su propio pathfinding para alejarse
				state.fleeUntil = currentTime + (config.fleeDuration or 5000) -- Huir por 5 segundos
				state.fleeFrom = attacker:getId()

				-- El monster intentará caminar en dirección opuesta
				-- usando su sistema de movimiento natural
			end

			return true
		end
	end

	return false
end

-- Función: Verificar y ejecutar combos
function MonsterAI.handleComboAbility(monster, abilityConfig)
	if not monster or not abilityConfig or not abilityConfig.enabled then
		return false
	end

	local currentTime = os.time() * 1000 -- Convertir a milisegundos
	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)

	-- Verificar si el combo está habilitado
	if not abilityConfig.comboEnabled then
		return false
	end

	-- Buscar aliados cercanos
	local allies = MonsterAI.findNearbyAllies(monster, abilityConfig.allyNames, abilityConfig.allyRange)

	-- Si hay aliados, aumentar la chance de castear
	if #allies > 0 then
		-- Notificar a los aliados para que también consideren castear
		for _, ally in ipairs(allies) do
			local allyConfig = MonsterAI.Config[ally:getName()]
			if allyConfig then
				-- Marcar que hay un combo disponible
				local allyState = getMonsterState(ally:getId())
				allyState.lastComboCheck = currentTime
			end
		end
		return true
	end

	return false
end

-- Función: Priorizar objetivos
function MonsterAI.getBestTarget(monster, config)
	if not monster or not config or not config.enabled then
		return nil
	end

	local pos = monster:getPosition()
	local range = 10

	local specs = Game.getSpectators(pos, false, false, range, range, range, range)
	local targets = {}

	for _, creature in ipairs(specs) do
		if creature:isPlayer() then
			local priority = 0
			local player = Player(creature)

			-- Prioridad por vocación
			if config.priorityByVocation then
				local vocation = player:getVocation():getId()
				priority = config.priorityByVocation[vocation] or 50
			end

			-- Bonus si tiene poca vida
			if config.priorityLowHealth then
				local healthPercent = MonsterAI.getHealthPercent(player)
				if healthPercent <= config.lowHealthThreshold then
					priority = priority + 30
				end
			end

			table.insert(targets, { creature = creature, priority = priority })
		end
	end

	-- Ordenar por prioridad
	table.sort(targets, function(a, b)
		return a.priority > b.priority
	end)

	if #targets > 0 then
		return targets[1].creature
	end

	return nil
end

-- Función principal: Think del monster
function MonsterAI.onThink(monster)
	if not monster then
		return true
	end

	local monsterName = monster:getName()
	local config = MonsterAI.Config[monsterName]

	if not config or not config.enabled then
		return true
	end

	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)
	local currentTime = os.time() * 1000

	-- 0. Manejar huida (prioridad máxima)
	if state.fleeUntil > currentTime then
		-- El monster está huyendo - remover target para que huya naturalmente
		if monster:getTarget() then
			monster:setTarget(nil)
		end

		local fleeFromCreature = Creature(state.fleeFrom)
		if not fleeFromCreature then
			-- Si el atacante ya no existe, dejar de huir
			state.fleeUntil = 0
			state.fleeFrom = 0
		end

		-- No hacer otras acciones mientras huye (el monster usa su pathfinding natural)
		return true
	end

	-- 1. Manejar curación inteligente
	if config.healing then
		MonsterAI.handleHealing(monster, config.healing)
	end

	-- 2. Manejar magic wall defensiva (si está siendo atacado)
	local target = monster:getTarget()
	if target and config.abilities and config.abilities.magicWall then
		MonsterAI.createDefensiveWall(monster, target, config.abilities.magicWall)
	end

	-- 3. Verificar combos disponibles
	if config.abilities then
		for _, ability in pairs(config.abilities) do
			if type(ability) == "table" and ability.comboEnabled then
				MonsterAI.handleComboAbility(monster, ability)
			end
		end
	end

	-- 4. Priorizar objetivos (solo si no está huyendo)
	if config.targeting then
		local bestTarget = MonsterAI.getBestTarget(monster, config.targeting)
		if bestTarget and monster:getTarget() ~= bestTarget then
			monster:setTarget(bestTarget)
		end
	end

	return true
end

-- Función: Al morir el monster, limpiar su estado
function MonsterAI.onDeath(monster)
	if not monster then
		return true
	end

	cleanupMonsterState(monster:getId())
	return true
end

-- Función: Registrar monster con IA
function MonsterAI.registerMonster(monsterType)
	if not monsterType then
		return false
	end

	local monsterName = monsterType:name()
	local config = MonsterAI.Config[monsterName]

	if not config or not config.enabled then
		return false
	end

	-- Registrar eventos de IA
	monsterType:registerEvent("MonsterAI_Think")
	monsterType:registerEvent("MonsterAI_Death")

	return true
end

-- Función: Obtener configuración de critical/fatal hits de un monster
function MonsterAI.getCriticalConfig(monsterName)
	local config = MonsterAI.Config[monsterName]
	if not config then
		return nil
	end

	return {
		critical = config.criticalHits or { enabled = false },
		fatal = config.fatalHits or { enabled = false },
	}
end

-- Función: Obtener estadísticas de critical/fatal hits
function MonsterAI.getHitTypeStats(monsterName)
	local config = MonsterAI.Config[monsterName]
	if not config then
		return "Monster no encontrado en configuración"
	end

	local stats = string.format(
		"=== %s - Critical/Fatal Stats ===\n" .. "Critical Hit:\n" .. "  - Enabled: %s\n" .. "  - Chance: %d%%\n" .. "  - Damage Bonus: +%d%%\n" .. "Fatal Hit (Outslaugh):\n" .. "  - Enabled: %s\n" .. "  - Chance: %d%%\n" .. "  - Damage Bonus: +%d%%",
		monsterName,
		config.criticalHits and config.criticalHits.enabled and "YES" or "NO",
		config.criticalHits and config.criticalHits.chance or 0,
		config.criticalHits and config.criticalHits.damageBonus or 0,
		config.fatalHits and config.fatalHits.enabled and "YES" or "NO",
		config.fatalHits and config.fatalHits.chance or 0,
		config.fatalHits and config.fatalHits.damageBonus or 0
	)

	return stats
end
