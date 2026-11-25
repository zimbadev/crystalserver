local healthMultiplier = configManager.getFloat(configKeys.RATE_BOSS_HEALTH)
if not healthMultiplier or healthMultiplier <= 0 then
	healthMultiplier = 1.0
end

local stages = {
	{ name = "Urmahlullu the Immaculate", threshold = 400000, nextName = "Wildness of Urmahlullu" },
	{ name = "Wildness of Urmahlullu", threshold = 300000, nextName = "Urmahlullu the Tamed" },
	{ name = "Urmahlullu the Tamed", threshold = 200000, nextName = "Wisdom of Urmahlullu" },
	{ name = "Wisdom of Urmahlullu", threshold = 100000, nextName = "Urmahlullu the Weakened" },
	{ name = "Urmahlullu the Weakened", threshold = 0, nextName = nil },
}

local stageByName = {}
for i, stage in ipairs(stages) do
	stageByName[stage.name] = {
		index = i,
		threshold = stage.threshold * healthMultiplier,
		nextName = stage.nextName,
	}
end

local changingStages = {}

local urmahlulluChanges = CreatureEvent("UrmahlulluChanges")

function urmahlulluChanges.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:isMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local stageInfo = stageByName[creature:getName()]
	if not stageInfo or not stageInfo.nextName then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local bossId = creature:getId()

	-- Proteção contra múltiplos hits concorrentes durante a transição
	if changingStages[bossId] then
		return 0, primaryType, 0, secondaryType
	end

	local totalDamage = primaryDamage + secondaryDamage
	local currentHealth = creature:getHealth()
	local resultingHealth = currentHealth - totalDamage

	if resultingHealth <= stageInfo.threshold then
		changingStages[bossId] = true

		local nextStageName = stageInfo.nextName
		local attackerId = attacker and attacker:getId() or nil
		local targetHealth = math.max(1, resultingHealth)

		addEvent(function(cid, nextName, newHealth, atkId)
			changingStages[cid] = nil

			local oldBoss = Monster(cid)
			if not oldBoss then
				return
			end

			local spawnPos = oldBoss:getPosition()
			oldBoss:remove()

			local newBoss = Game.createMonster(nextName, spawnPos, true, true)
			if not newBoss then
				return
			end

			newBoss:setHealth(newHealth)
			spawnPos:sendMagicEffect(CONST_ME_MAGIC_RED)
			spawnPos:sendMagicEffect(CONST_ME_POFF)
			newBoss:say("You think you can defeat me?! Feel my true power!", TALKTYPE_MONSTER_YELL)

			if atkId then
				local target = Creature(atkId)
				if target then
					newBoss:setTarget(target)
				end
			end
		end, 100, bossId, nextStageName, targetHealth, attackerId)

		return 0, primaryType, 0, secondaryType
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

urmahlulluChanges:register()
