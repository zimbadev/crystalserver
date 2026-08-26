local BOSS_CONFIG = {
	["Vemiath"] = Position(33043, 32335, 15),
	["Chagorz"] = Position(33043, 32366, 15),
	["Bakragore"] = Position(33043, 32397, 15),
}

if not GlobalRottenBloodStates then
	GlobalRottenBloodStates = {}
end

local function isNearTeleport(pos1, pos2)
	local dx = math.abs(pos1.x - pos2.x)
	local dy = math.abs(pos1.y - pos2.y)
	return dx <= 1 and dy <= 1 and pos1.z == pos2.z
end

local function getDamageTypeForBoss(bossName)
	if bossName == "Vemiath" or bossName == "Chagorz" then
		return COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA, "energy"
	else
		return COMBAT_AGONYDAMAGE, CONST_ME_AGONY, "agony"
	end
end

local teleportStepCallback = MoveEvent()

function teleportStepCallback.onStepIn(creature, item, position, fromPosition)
	logger.debug("Something stepped on item {} at position {},{},{}", item.itemid, position.x, position.y, position.z)

	if not creature:isPlayer() then
		logger.debug("Not a player, ignoring")
		return true
	end

	logger.debug("Player {} stepped on item {} with ActionId {}", creature:getName(), item.itemid, item:getActionId())

	for bossName, centerPos in pairs(BOSS_CONFIG) do
		if centerPos.x == position.x and centerPos.y == position.y and centerPos.z == position.z then
			logger.debug("Player stepped on teleport for boss {}", bossName)

			local elderBloodjawsNearby = {}
			local spectators = Game.getSpectators(centerPos, false, false, 2, 2, 2, 2)

			for _, specCreature in ipairs(spectators) do
				if specCreature:isMonster() and specCreature:getName():lower() == "elder bloodjaw" then
					table.insert(elderBloodjawsNearby, specCreature)
				end
			end

			if #elderBloodjawsNearby > 0 then
				logger.debug("Found {} Elder Bloodjaw near teleport for boss {}", #elderBloodjawsNearby, bossName)

				local allSpectators = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
				local removedCount = 0

				for _, specCreature in ipairs(allSpectators) do
					if specCreature:isMonster() and specCreature:getName():lower() == "elder bloodjaw" then
						specCreature:remove()
						removedCount = removedCount + 1
					end
				end

				Game.setStorageValue(bossName .. "TeleportPaused", 1)
				Game.setStorageValue(bossName .. "ElderBloodjawSpawnPaused", 1)
				logger.debug("Boss {} teleport and Elder Bloodjaw spawn systems paused (removed {} Elder Bloodjaw)", bossName, removedCount)

				item:remove()

				local boss = nil
				local allSpectators2 = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
				for _, specCreature in ipairs(allSpectators2) do
					if specCreature:isMonster() and specCreature:getName() == bossName then
						boss = specCreature
						break
					end
				end

				if not boss then
					logger.debug("Boss {} not found, canceling attack sequence", bossName)
					return
				end

				local mainTarget = boss:getTarget()
				if not mainTarget or not mainTarget:isPlayer() then
					logger.debug("Boss {} has no valid main target, canceling attack sequence", bossName)
					return
				end

				local messageSpectators = Game.getSpectators(centerPos, false, true, 15, 15, 15, 15)
				for _, spectator in ipairs(messageSpectators) do
					if spectator:isPlayer() then
						spectator:say("the discharge of energy weakened the resistance of the boss shortly! PREPARE FOR 2 MASSIVE ATTACKS ON THE MAIN TARGET!", TALKTYPE_MONSTER_SAY, false, spectator, centerPos)
					end
				end

				addEvent(function()
					local currentBoss = nil
					local spectators2 = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
					for _, specCreature in ipairs(spectators2) do
						if specCreature:isMonster() and specCreature:getName() == bossName then
							currentBoss = specCreature
							break
						end
					end

					if not currentBoss then
						logger.debug("Boss {} died, canceling first attack", bossName)
						return
					end

					local currentTarget = currentBoss:getTarget()
					if not currentTarget or not currentTarget:isPlayer() then
						logger.debug("Boss {} has no valid target for first attack", bossName)
						return
					end

					local maxHealth = currentTarget:getMaxHealth()
					local damage1 = math.ceil(maxHealth * 0.15)

					local damageType, effectType, damageTypeName = getDamageTypeForBoss(bossName)

					doTargetCombatHealth(currentBoss, currentTarget, damageType, -damage1, -damage1, effectType)
					currentTarget:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. damage1 .. " " .. damageTypeName .. " damage from the first massive attack!")
				end, 5000)

				addEvent(function()
					local currentBoss = nil
					local spectators3 = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
					for _, specCreature in ipairs(spectators3) do
						if specCreature:isMonster() and specCreature:getName() == bossName then
							currentBoss = specCreature
							break
						end
					end

					if not currentBoss then
						logger.debug("Boss {} died, canceling second attack", bossName)
						return
					end

					local currentTarget = currentBoss:getTarget()
					if not currentTarget or not currentTarget:isPlayer() then
						logger.debug("Boss {} has no valid target for second attack", bossName)
						return
					end

					local maxHealth = currentTarget:getMaxHealth()
					local damage2 = math.ceil(maxHealth * 0.25)

					local damageType, effectType, damageTypeName = getDamageTypeForBoss(bossName)

					doTargetCombatHealth(currentBoss, currentTarget, damageType, -damage2, -damage2, effectType)
					currentTarget:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. damage2 .. " " .. damageTypeName .. " damage from the second massive attack!")

					local spectators4 = Game.getSpectators(centerPos, false, true, 15, 15, 15, 15)
					local requiredBloodjaws = 2
					local maxTaint = 0

					for _, spectator in ipairs(spectators4) do
						if spectator:isPlayer() then
							local kv = spectator:kv():scoped("rotten-blood-quest")
							local currentTaintKV = kv:get("taints") or 0
							local currentTaintCondition = 0
							local taintCondition = spectator:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
							if taintCondition then
								currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
							end
							local taint = math.max(currentTaintKV, currentTaintCondition)
							if taint > maxTaint then
								maxTaint = taint
							end
						end
					end

					local extraBloodjaws = 0
					if maxTaint >= 5 then
						extraBloodjaws = extraBloodjaws + 1
					end
					if maxTaint >= 8 then
						extraBloodjaws = extraBloodjaws + 1
					end
					if maxTaint >= 9 then
						extraBloodjaws = extraBloodjaws + 1
					end

					requiredBloodjaws = math.min(requiredBloodjaws + extraBloodjaws, 5)

					for i = 1, requiredBloodjaws do
						local offsetX = math.random(-1, 1)
						local offsetY = math.random(-1, 1)
						local spawnPos = Position(centerPos.x + offsetX, centerPos.y + offsetY, centerPos.z)

						local tile = Tile(spawnPos)
						if tile and tile:isWalkable() then
							Game.createMonster("Elder Bloodjaw", spawnPos)
						else
							Game.createMonster("Elder Bloodjaw", centerPos)
						end
					end

					logger.debug("Respawned {} Elder Bloodjaw at center for boss {}", requiredBloodjaws, bossName)

					Game.setStorageValue(bossName .. "TeleportPaused", -1)
					Game.setStorageValue(bossName .. "ElderBloodjawSpawnPaused", -1)
					logger.debug("Boss {} teleport and Elder Bloodjaw spawn systems reactivated", bossName)
				end, 15000)
			else
				logger.debug("No Elder Bloodjaw found near teleport for boss {}", bossName)
			end
			break
		end
	end

	return true
end

teleportStepCallback:aid(50001)
teleportStepCallback:register()
