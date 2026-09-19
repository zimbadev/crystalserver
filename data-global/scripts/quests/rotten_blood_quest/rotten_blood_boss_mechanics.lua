local RottenBloodMechanics = {}

local BOSS_CONFIG = {
	["Vemiath"] = {
		centerPos = Position(33043, 32335, 15),
		specPos = { from = Position(33035, 32327, 15), to = Position(33052, 32344, 15) },
	},
	["Chagorz"] = {
		centerPos = Position(33043, 32366, 15),
		specPos = { from = Position(33035, 32358, 15), to = Position(33052, 32375, 15) },
	},
	["Murcion"] = {
		centerPos = Position(33008, 32367, 15),
		specPos = { from = Position(33000, 32360, 15), to = Position(33017, 32375, 15) },
	},
	["Ichgahal"] = {
		centerPos = Position(33008, 32334, 15),
		specPos = { from = Position(32998, 32326, 15), to = Position(33018, 32343, 15) },
	},
	["Bakragore"] = {
		centerPos = Position(33043, 32397, 15),
		specPos = { from = Position(33034, 32389, 15), to = Position(33053, 32410, 15) },
	},
}

local bossStates = {}

local function getPlayerTaintLevel(player)
	local kv = player:kv():scoped("rotten-blood-quest")
	local currentTaintKV = kv:get("taints") or 0
	local currentTaintCondition = 0
	local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
	end
	return math.max(currentTaintKV, currentTaintCondition)
end

local function getClosePosition(centerPos)
	local tries = 10
	for i = 1, tries do
		local offsetX = math.random(-2, 2)
		local offsetY = math.random(-2, 2)
		local tryPos = Position(centerPos.x + offsetX, centerPos.y + offsetY, centerPos.z)
		local tile = Tile(tryPos)
		if tile and tile:isWalkable() then
			return tryPos
		end
	end
	return centerPos
end

local function calculateElderBloodjawCount(bossName)
	local config = BOSS_CONFIG[bossName]
	if not config then
		return 2
	end

	local maxTaintLevel = 0
	local spectators = Game.getSpectators(config.centerPos, false, true, 15, 15, 15, 15)

	for _, player in ipairs(spectators) do
		if player:isPlayer() then
			local taintLevel = getPlayerTaintLevel(player)
			maxTaintLevel = math.max(maxTaintLevel, taintLevel)
		end
	end

	local baseCount = 2
	local extraCount = 0

	if maxTaintLevel >= 5 then
		extraCount = extraCount + 1
	end
	if maxTaintLevel >= 8 then
		extraCount = extraCount + 1
	end
	if maxTaintLevel >= 9 then
		extraCount = extraCount + 1
	end

	return math.min(baseCount + extraCount, 5)
end

local function spawnElderBloodjaws(bossName, monster)
	local config = BOSS_CONFIG[bossName]
	if not config then
		logger.debug("No config found for boss {}", bossName)
		return
	end

	if Game.getStorageValue(bossName .. "ElderBloodjawSpawnPaused") == 1 then
		logger.debug("Boss {} Elder Bloodjaw spawn paused in spawnElderBloodjaws", bossName)
		return
	end

	local targetCount = calculateElderBloodjawCount(bossName)
	local pos = monster:getPosition()
	local radiusX, radiusY = 15, 15

	local existingCount = 0
	for _, creature in ipairs(Game.getSpectators(pos, false, false, radiusX, radiusX, radiusY, radiusY)) do
		if creature:isMonster() and creature:getName():lower() == "elder bloodjaw" then
			existingCount = existingCount + 1
		end
	end

	for i = 1, targetCount - existingCount do
		local summonPos = getClosePosition(pos)
		Game.createMonster("Elder Bloodjaw", summonPos)
	end
end

local function createCenterTeleport(bossName)
	local config = BOSS_CONFIG[bossName]
	if not config then
		logger.warn("No config found for boss {} in createCenterTeleport", bossName)
		return
	end

	local centerPos = config.centerPos

	local tile = Tile(centerPos)
	if tile then
		local existingTeleport = tile:getItemById(37000)
		if existingTeleport then
			logger.debug("Teleport already exists at center for boss {}, removing old one", bossName)
			existingTeleport:remove()
		end
	end

	local teleport = Game.createItem(37000, 1, centerPos)
	if teleport then
		logger.debug("Teleport successfully created at center for boss {} at {},{},{}", bossName, centerPos.x, centerPos.y, centerPos.z)

		centerPos:sendMagicEffect(CONST_ME_TELEPORT)

		addEvent(function()
			local tile = Tile(centerPos)
			if tile then
				local item = tile:getItemById(37000)
				if item then
					item:remove()
					logger.debug("Teleport automatically removed from center for boss {}", bossName)
				end
			end
		end, 15000)

		return teleport
	else
		logger.error("Failed to create teleport for boss {} at {},{},{}", bossName, centerPos.x, centerPos.y, centerPos.z)
	end
	return nil
end

local function removeAllElderBloodjaws(bossName)
	local config = BOSS_CONFIG[bossName]
	if not config then
		return
	end

	local spectators = Game.getSpectators(config.centerPos, false, false, 15, 15, 15, 15)
	local removedCount = 0

	for _, creature in ipairs(spectators) do
		if creature:isMonster() and creature:getName():lower() == "elder bloodjaw" then
			creature:remove()
			removedCount = removedCount + 1
		end
	end

	logger.debug("Removed {} Elder Bloodjaws from {} room", removedCount, bossName)
	return removedCount > 0
end

local function disableBossMechanics(bossName)
	if not bossStates[bossName] then
		bossStates[bossName] = {}
	end
	bossStates[bossName].mechanicsDisabled = true
	logger.debug("Boss mechanics disabled for {}", bossName)
end

local function enableBossMechanics(bossName)
	if not bossStates[bossName] then
		bossStates[bossName] = {}
	end
	bossStates[bossName].mechanicsDisabled = false
	logger.debug("Boss mechanics enabled for {}", bossName)
end

function RottenBloodMechanics.areMechanicsDisabled(bossName)
	return bossStates[bossName] and bossStates[bossName].mechanicsDisabled or false
end

local function handleExplosion(bossName)
	local config = BOSS_CONFIG[bossName]
	if not config then
		return
	end

	local centerPos = config.centerPos

	centerPos:sendMonsterSay("The rotten charge is going to explode!", TALKTYPE_MONSTER_SAY)

	addEvent(function()
		local spectators = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
		local bossAlive = false

		for _, creature in ipairs(spectators) do
			if creature:isMonster() and creature:getName() == bossName then
				bossAlive = true
				break
			end
		end

		if not bossAlive then
			logger.debug("Boss {} died, cancelling explosion", bossName)
			return
		end

		centerPos:sendMonsterSay("THE ROTTEN CHARGE WILL EXPLODE SOON!", TALKTYPE_MONSTER_SAY)

		addEvent(function()
			local spectators2 = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
			local bossStillAlive = false

			for _, creature in ipairs(spectators2) do
				if creature:isMonster() and creature:getName() == bossName then
					bossStillAlive = true
					break
				end
			end

			if not bossStillAlive then
				logger.debug("Boss {} died, cancelling explosion", bossName)
				return
			end

			centerPos:sendMagicEffect(CONST_ME_EXPLOSIONHIT)

			for _, creature in ipairs(spectators2) do
				if creature:isPlayer() then
					local player = creature
					local maxHealth = player:getMaxHealth()
					local damage = math.ceil(maxHealth * 0.4)

					player:addHealth(-damage, COMBAT_AGONYDAMAGE)
					player:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)

					logger.debug("Player {} received {} agony damage from explosion", player:getName(), damage)
				end
			end

			addEvent(function()
				enableBossMechanics(bossName)
			end, 15000)
		end, 5000)
	end, 10000)
end

local function startTeleportCycle(bossName)
	if not bossStates[bossName] then
		bossStates[bossName] = {}
	end

	logger.debug("Starting teleport cycle for boss {}", bossName)

	bossStates[bossName].teleportTimer = addEvent(function()
		local config = BOSS_CONFIG[bossName]
		if not config then
			logger.warn("No config found for boss {}", bossName)
			return
		end

		local spectators = Game.getSpectators(config.centerPos, false, false, 15, 15, 15, 15)
		local bossAlive = false

		for _, creature in ipairs(spectators) do
			if creature:isMonster() and creature:getName() == bossName then
				bossAlive = true
				break
			end
		end

		if not bossAlive then
			logger.debug("Boss {} not found, stopping teleport cycle", bossName)
			return
		end

		logger.debug("Creating teleport for boss {} at position {},{},{}", bossName, config.centerPos.x, config.centerPos.y, config.centerPos.z)
		createCenterTeleport(bossName)

		startTeleportCycle(bossName)
	end, 30000)
end

function RottenBloodMechanics.initializeBoss(bossName, monster)
	logger.debug("Initializing mechanics for boss {}", bossName)

	if not bossStates[bossName] then
		bossStates[bossName] = {}
	end

	bossStates[bossName].mechanicsDisabled = false

	spawnElderBloodjaws(bossName, monster)

	startTeleportCycle(bossName)
end

function RottenBloodMechanics.cleanupBoss(bossName)
	logger.debug("Cleaning up mechanics for boss {}", bossName)

	if bossStates[bossName] then
		if bossStates[bossName].teleportTimer then
			stopEvent(bossStates[bossName].teleportTimer)
		end
		bossStates[bossName] = nil
	end
end

function RottenBloodMechanics.handleElderBloodjawSpawn(bossName, monster)
	if RottenBloodMechanics.areMechanicsDisabled(bossName) then
		logger.debug("Boss {} mechanics disabled, not spawning Elder Bloodjaw", bossName)
		return
	end

	local spawnPaused = Game.getStorageValue(bossName .. "ElderBloodjawSpawnPaused")
	if spawnPaused == 1 then
		logger.debug("Boss {} Elder Bloodjaw spawn paused by teleport system", bossName)
		return
	end

	logger.debug("Boss {} spawning Elder Bloodjaw (spawn paused value: {})", bossName, spawnPaused)
	spawnElderBloodjaws(bossName, monster)
end

function RottenBloodMechanics.handleTeleportStep(creature, item, position, fromPosition)
	if not creature:isMonster() or creature:getName():lower() ~= "elder bloodjaw" then
		return true
	end

	if item.itemid ~= 37000 then
		return true
	end

	for bossName, config in pairs(BOSS_CONFIG) do
		if config.centerPos.x == position.x and config.centerPos.y == position.y and config.centerPos.z == position.z then
			logger.debug("Elder Bloodjaw stepped on teleport for boss {} (StepIn)", bossName)

			if removeAllElderBloodjaws(bossName) then
				disableBossMechanics(bossName)

				item:remove()

				handleExplosion(bossName)
			end
			break
		end
	end

	return true
end

return RottenBloodMechanics
