if not MonsterAI then
	MonsterAI = {}
end

MonsterAI.Config = {
	["Elder Bloodjaw"] = {
		enabled = true,

		criticalHits = {
			enabled = true,
			chance = 15, -- 15%
			damageBonus = 60, -- +60%
		},
		fatalHits = {
			enabled = false,
			chance = 8, -- 8%
			damageBonus = 120, -- +120%
		},

		healing = {
			enabled = false,
		},

		abilities = {},

		targeting = {
			enabled = true,
			priorityByVocation = {
				[1] = 70, -- Sorcerer
				[2] = 70, -- Druid
				[3] = 75, -- Paladin
				[4] = 100, -- Knight
				[5] = 70, -- Master Sorcerer
				[6] = 70, -- Elder Druid
				[7] = 75, -- Royal Paladin
				[8] = 100, -- Elite Knight
				[9] = 70, -- Monk
				[10] = 70, -- Exalted Monk
			},
			priorityLowHealth = true,
			lowHealthThreshold = 30,
		},
	},
}

if not MonsterAI.States then
	MonsterAI.States = {}
end

local function getMonsterState(monsterId)
	if not MonsterAI.States[monsterId] then
		MonsterAI.States[monsterId] = {
			lastHealTime = 0,
			lastWallTime = 0,
			lastComboCheck = 0,
			wallCooldown = 0,
			usedSecondaryHeal = false,
			fleeUntil = 0,
			fleeFrom = 0,
		}
	end
	return MonsterAI.States[monsterId]
end

local function cleanupMonsterState(monsterId)
	MonsterAI.States[monsterId] = nil
end

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

function MonsterAI.getHealthPercent(creature)
	if not creature then
		return 100
	end
	return math.floor((creature:getHealth() / creature:getMaxHealth()) * 100)
end

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

	if config.fatalHits and config.fatalHits.enabled then
		local fatalChance = math.random(1, 100)
		if fatalChance <= config.fatalHits.chance then
			local bonusMultiplier = 1 + (config.fatalHits.damageBonus / 100)
			finalDamage = math.floor(baseDamage * bonusMultiplier)
			isFatal = true
			return finalDamage, false, true
		end
	end

	if config.criticalHits and config.criticalHits.enabled then
		local critChance = math.random(1, 100)
		if critChance <= config.criticalHits.chance then
			local bonusMultiplier = 1 + (config.criticalHits.damageBonus / 100)
			finalDamage = math.floor(baseDamage * bonusMultiplier)
			isCritical = true
			return finalDamage, true, false
		end
	end

	return finalDamage, isCritical, isFatal
end

function MonsterAI.applyDamageWithModifiers(monster, target, baseDamage, damageType, monsterSay)
	if not monster or not target then
		return false
	end

	if monsterSay and type(monsterSay) == "string" then
		monster:say(monsterSay, TALKTYPE_MONSTER_SAY)
	end

	local finalDamage, isCritical, isFatal = MonsterAI.calculateDamageModifier(monster, math.abs(baseDamage))

	local damageValue = -finalDamage
	target:addHealth(damageValue)

	local targetPos = target:getPosition()

	if isFatal then
		targetPos:sendMagicEffect(230)
	elseif isCritical then
		targetPos:sendMagicEffect(173)
	else
		local effect = CONST_ME_DRAWBLOOD
		if damageType then
			effect = damageType
		end
		targetPos:sendMagicEffect(effect)
	end

	return true
end

function MonsterAI.handleHealing(monster, config)
	if not monster or not config or not config.enabled then
		return false
	end

	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)
	local healthPercent = MonsterAI.getHealthPercent(monster)
	local currentTime = os.time() * 1000

	if config.secondary and healthPercent <= config.secondary.healthPercent then
		local timeSinceHeal = currentTime - state.lastHealTime
		if timeSinceHeal >= config.secondary.interval then
			local healAmount = math.random(config.secondary.minHeal, config.secondary.maxHeal)
			monster:addHealth(healAmount)
			monster:getPosition():sendMagicEffect(config.secondary.effect)

			if config.secondary.monsterSay then
				monster:say(config.secondary.monsterSay, TALKTYPE_MONSTER_SAY)
			end

			state.lastHealTime = currentTime
			state.usedSecondaryHeal = true
			return true
		end
	end

	if config.primary and healthPercent <= config.primary.healthPercent then
		local timeSinceHeal = currentTime - state.lastHealTime
		if timeSinceHeal >= config.primary.interval then
			local healAmount = math.random(config.primary.minHeal, config.primary.maxHeal)
			monster:addHealth(healAmount)
			monster:getPosition():sendMagicEffect(config.primary.effect)

			if config.primary.monsterSay then
				monster:say(config.primary.monsterSay, TALKTYPE_MONSTER_SAY)
			end

			state.lastHealTime = currentTime
			return true
		end
	end

	return false
end

function MonsterAI.createDefensiveWall(monster, attacker, config)
	if not monster or not attacker or not config or not config.enabled then
		return false
	end

	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)
	local currentTime = os.time() * 1000
	local healthPercent = MonsterAI.getHealthPercent(monster)

	if healthPercent > config.healthPercent then
		return false
	end

	if currentTime < state.wallCooldown then
		return false
	end

	local monsterPos = monster:getPosition()
	local attackerPos = attacker:getPosition()
	local distance = monsterPos:getDistance(attackerPos)

	if distance > config.maxDistance then
		return false
	end

	local wallPos = Position(math.floor((monsterPos.x + attackerPos.x) / 2), math.floor((monsterPos.y + attackerPos.y) / 2), monsterPos.z)

	local wallItemId = config.itemId or 1497

	local tile = Tile(wallPos)
	if tile then
		local item = Game.createItem(wallItemId, 1, wallPos)
		if item then
			addEvent(function()
				local wall = Tile(wallPos):getItemById(wallItemId)
				if wall then
					wall:remove()
				end
			end, config.wallDuration)

			local nextCooldown = math.random(config.minCooldown, config.maxCooldown)
			state.wallCooldown = currentTime + nextCooldown

			wallPos:sendMagicEffect(CONST_ME_ENERGYAREA)

			if config.fleeAfterWall then
				state.fleeUntil = currentTime + (config.fleeDuration or 5000)
				state.fleeFrom = attacker:getId()
			end

			return true
		end
	end

	return false
end

function MonsterAI.handleComboAbility(monster, abilityConfig)
	if not monster or not abilityConfig or not abilityConfig.enabled then
		return false
	end

	local currentTime = os.time() * 1000
	local monsterId = monster:getId()
	local state = getMonsterState(monsterId)

	if not abilityConfig.comboEnabled then
		return false
	end

	local allies = MonsterAI.findNearbyAllies(monster, abilityConfig.allyNames, abilityConfig.allyRange)

	if #allies > 0 then
		for _, ally in ipairs(allies) do
			local allyConfig = MonsterAI.Config[ally:getName()]
			if allyConfig then
				local allyState = getMonsterState(ally:getId())
				allyState.lastComboCheck = currentTime
			end
		end
		return true
	end

	return false
end

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

			if config.priorityByVocation then
				local vocation = player:getVocation():getId()
				priority = config.priorityByVocation[vocation] or 50
			end

			if config.priorityLowHealth then
				local healthPercent = MonsterAI.getHealthPercent(player)
				if healthPercent <= config.lowHealthThreshold then
					priority = priority + 30
				end
			end

			table.insert(targets, { creature = creature, priority = priority })
		end
	end

	table.sort(targets, function(a, b)
		return a.priority > b.priority
	end)

	if #targets > 0 then
		return targets[1].creature
	end

	return nil
end

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

	if state.fleeUntil > currentTime then
		if monster:getTarget() then
			monster:setTarget(nil)
		end

		local fleeFromCreature = Creature(state.fleeFrom)
		if not fleeFromCreature then
			state.fleeUntil = 0
			state.fleeFrom = 0
		end

		return true
	end

	if config.healing then
		MonsterAI.handleHealing(monster, config.healing)
	end

	local target = monster:getTarget()
	if target and config.abilities and config.abilities.magicWall then
		MonsterAI.createDefensiveWall(monster, target, config.abilities.magicWall)
	end

	if config.abilities then
		for _, ability in pairs(config.abilities) do
			if type(ability) == "table" and ability.comboEnabled then
				MonsterAI.handleComboAbility(monster, ability)
			end
		end
	end

	if config.targeting then
		local bestTarget = MonsterAI.getBestTarget(monster, config.targeting)
		if bestTarget and monster:getTarget() ~= bestTarget then
			monster:setTarget(bestTarget)
		end
	end

	return true
end

function MonsterAI.onDeath(monster)
	if not monster then
		return true
	end

	cleanupMonsterState(monster:getId())
	return true
end

function MonsterAI.registerMonster(monsterType)
	if not monsterType then
		return false
	end

	local monsterName = monsterType:name()
	local config = MonsterAI.Config[monsterName]

	if not config or not config.enabled then
		return false
	end

	monsterType:registerEvent("MonsterAI_Think")
	monsterType:registerEvent("MonsterAI_Death")

	return true
end

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
