local mType = Game.createMonsterType("Bakragore")
local monster = {}

monster.description = "Bakragore"
monster.experience = 15000000
monster.outfit = {
	lookType = 1671,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"RottenBloodBossDeath",
	"BakragoreMechanicsDeath",
}

monster.bosstiary = {
	bossRaceId = 2367,
	bossRace = RARITY_NEMESIS,
}

monster.health = 660000
monster.maxHealth = 660000
monster.race = "undead"
monster.corpse = 44012
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 20,
}

monster.strategiesTarget = {
	nearest = 100,
	health = 0,
	damage = 0,
	random = 0,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Light ... darkens!", yell = false },
	{ text = "Light .. the ... darkness!", yell = false },
	{ text = "Darkness ... is ... light!", yell = false },
	{ text = "WILL ... PUNISH ... YOU!", yell = false },
	{ text = "RAAAR!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 28938, maxCount = 209 },
	{ name = "ultimate mana potion", chance = 21433, maxCount = 320 },
	{ name = "supreme health potion", chance = 50000, maxCount = 242 },
	{ name = "giant amethyst", chance = 34000, maxCount = 6 },
	{ name = "giant topaz", chance = 27570, maxCount = 6 },
	{ name = "ultimate spirit potion", chance = 48000, maxCount = 220 },
	{ name = "giant ruby", chance = 30570, maxCount = 7 },
	{ name = "giant sapphire", chance = 27570, maxCount = 6 },
	{ name = "mastermind potion", chance = 14310, maxCount = 79 },
	{ id = 3039, chance = 20570, maxCount = 30 }, -- red gem
	{ name = "Cobalt Ridge", chance = 25000, maxCount = 1 },
	{ name = "Dragon Figurine", chance = 25000, maxCount = 1 },
	{ name = "Fiery Tear", chance = 360, maxCount = 1 },
	{ name = "violet gem", chance = 20970, maxCount = 8 },
	{ name = "yellow gem", chance = 20970, maxCount = 9 },
	{ name = "figurine of bakragore", chance = 7970 },
	{ name = "bakragore's amalgamation", chance = 7100 },
	{ name = "spiritual horseshoe", chance = 360 },
	{ id = 39038, chance = 360, maxCount = 1 }, -- royal almandine
	{ id = 43946, chance = 180, maxCount = 1 }, -- scroll 1
	{ id = 43947, chance = 180, maxCount = 1 }, -- scroll 2
	{ id = 43950, chance = 180, maxCount = 1 }, -- scroll 5
	{ id = 43895, chance = 360 }, ---bag you covet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1100, maxDamage = -3000 },
	{ name = "speed", interval = 2000, chance = 27, speedChange = -1600, radius = 7, effect = CONST_ME_SOUND_RED, target = false, duration = 10000 },
	{ name = "murcionring", interval = 2000, chance = 17, minDamage = -1200, maxDamage = -3000, target = false },
	{ name = "chagorzring", interval = 2000, chance = 17, minDamage = -1200, maxDamage = -3000, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -1100, maxDamage = -1250, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -2100, maxDamage = -2650, radius = 6, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = -2500, radius = 6, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -2200, maxDamage = -2400, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -1500, maxDamage = -2450, radius = 7, effect = CONST_ME_DRAWBLOOD, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_MANADRAIN, minDamage = -2200, maxDamage = -2450, radius = 7, effect = CONST_ME_STUN, target = false },
}

monster.defenses = {
	defense = 305,
	armor = 305,
	mitigation = 8.16,
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 1700, maxDamage = 4500, effect = 249, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

local aditionalMonsters = {
	{ name = "pillar of dark energy" },
	{ name = "pillar of dark energy" },
	{ name = "pillar of dark energy" },
	{ name = "mushroom" },
	{ name = "mushroom" },
	{ name = "mushroom" },
}
local ElderBloodjaws = {
	{ name = "Elder Bloodjaw" },
	{ name = "Elder Bloodjaw" },
}

local accumulatedTime = 0
local summonInterval = 0
local activeSummons = {}

local function getRandomPosition(monsterPosition)
	local offsetX = math.random(-1, 1)
	local offsetY = math.random(-1, 1)
	local offsetZ = monsterPosition.z

	return Position(monsterPosition.x + offsetX, monsterPosition.y + offsetY, offsetZ)
end

local function getClosePosition(centerPos)
	local tries = 10
	for i = 1, tries do
		local offsetX = math.random(-1, 1)
		local offsetY = math.random(-1, 1)
		local tryPos = Position(centerPos.x + offsetX, centerPos.y + offsetY, centerPos.z)
		local tile = Tile(tryPos)
		if tile and tile:isWalkable() then
			return tryPos
		end
	end
	return centerPos
end

local bossStates = {}
local bossInitialized = false

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

local function calculateElderBloodjawCount()
	local centerPos = Position(33043, 32397, 15)
	local spectators = Game.getSpectators(centerPos, false, true, 15, 15, 15, 15)
	local baseBloojaws = 2
	local maxTaint = 0

	for _, spectator in ipairs(spectators) do
		if spectator:isPlayer() then
			local taintLevel = getPlayerTaintLevel(spectator)
			if taintLevel > maxTaint then
				maxTaint = taintLevel
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

	return math.min(baseBloojaws + extraBloodjaws, 5)
end

local function areMechanicsDisabled()
	return GlobalRottenBloodStates and GlobalRottenBloodStates["Bakragore"] and GlobalRottenBloodStates["Bakragore"].mechanicsDisabled or false
end

local function initializeBoss()
	if not bossStates["Bakragore"] then
		bossStates["Bakragore"] = {}
	end
	bossStates["Bakragore"].mechanicsDisabled = false

	local function startTeleportCycle()
		bossStates["Bakragore"].teleportTimer = addEvent(function()
			local centerPos = Position(33043, 32397, 15)

			if Game.getStorageValue("BakragoreTeleportPaused") == 1 then
				logger.debug("Bakragore teleport system paused, skipping cycle")
				startTeleportCycle()
				return
			end

			local spectators = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
			local bossAlive = false
			local elderBloodjawExists = false

			for _, creature in ipairs(spectators) do
				if creature:isMonster() then
					if creature:getName() == "Bakragore" then
						bossAlive = true
					elseif creature:getName():lower() == "elder bloodjaw" then
						elderBloodjawExists = true
					end
				end
			end

			if not bossAlive then
				return
			end

			if elderBloodjawExists then
				local teleport = Game.createItem(37000, 1, centerPos)
				if teleport then
					teleport:setActionId(50001)
					centerPos:sendMagicEffect(CONST_ME_TELEPORT)
					logger.debug("Teleport created for Bakragore with ActionId {}", teleport:getActionId())

					addEvent(function()
						local tile = Tile(centerPos)
						if tile then
							local item = tile:getItemById(37000)
							if item then
								item:remove()
							end
						end
					end, 15000)
				end
			else
				logger.debug("No Elder Bloodjaw found, skipping teleport creation for Bakragore")
			end

			startTeleportCycle()
		end, 90000)
	end

	startTeleportCycle()
end

local function cleanupBoss()
	if bossStates["Bakragore"] then
		if bossStates["Bakragore"].teleportTimer then
			stopEvent(bossStates["Bakragore"].teleportTimer)
		end
		bossStates["Bakragore"] = nil
	end

	if GlobalRottenBloodStates and GlobalRottenBloodStates["Bakragore"] then
		if GlobalRottenBloodStates["Bakragore"].teleportTimer then
			stopEvent(GlobalRottenBloodStates["Bakragore"].teleportTimer)
		end
		GlobalRottenBloodStates["Bakragore"] = nil
	end
end

local function ensureSummons(monster)
	local pos = monster:getPosition()
	local radiusX, radiusY = 20, 20

	local existingBloodjaws = 0
	local existingPillars = 0
	local existingMushrooms = 0

	for _, cid in ipairs(Game.getSpectators(pos, false, false, radiusX, radiusX, radiusY, radiusY)) do
		if cid:isMonster() then
			local name = cid:getName():lower()
			if name == "elder bloodjaw" then
				existingBloodjaws = existingBloodjaws + 1
			elseif name == "pillar of dark energy" then
				existingPillars = existingPillars + 1
			elseif name == "mushroom" then
				existingMushrooms = existingMushrooms + 1
			end
		end
	end

	if not areMechanicsDisabled() and Game.getStorageValue("BakragoreElderBloodjawSpawnPaused") ~= 1 then
		local targetCount = calculateElderBloodjawCount()
		for i = 1, targetCount - existingBloodjaws do
			local summonPos = getClosePosition(pos)
			Game.createMonster("Elder Bloodjaw", summonPos)
		end
	else
		logger.debug("Bakragore mechanics disabled or Elder Bloodjaw spawn paused, not spawning Elder Bloodjaw")
	end

	for i = 1, 4 - existingMushrooms do
		local summonPos = getClosePosition(pos)
		Game.createMonster("Mushroom", summonPos)
	end

	for i = 1, 4 - existingPillars do
		local summonPos = getClosePosition(pos)
		Game.createMonster("pillar of dark energy", summonPos)
	end
end

local playerTracking = {}
local checkInterval = 1000
local checkTime = 0
local lastPlayerCleanup = os.time()

local function cleanupPlayerTracking()
	for playerId, _ in pairs(playerTracking) do
		local player = Player(playerId)
		if not player or not player:isPlayer() then
			playerTracking[playerId] = nil
			logger.debug("Bakragore: Cleaned up disconnected player {} from tracking", playerId)
		end
	end
end

local pillarAndFlames = {
	[1] = {
		globalstr = "essenceOfMurcion",
		monster = "Echo Of Murcion",
		monsterPosition = Position(33047, 32398, 15),
		flamePos = Position(33085, 32398, 15),
		flameID = 43984,
		flameResetID = 43983,
		pillarPos = Position(33081, 32398, 15),
		pillarID = 43508,
		pillarResetID = 43507,
	},
	[2] = {
		globalstr = "essenceOfIchgahal",
		monster = "Echo Of Ichgahal",
		monsterPosition = Position(33044, 32393, 15),
		flamePos = Position(33076, 32389, 15),
		flameID = 43498,
		flameResetID = 43497,
		pillarPos = Position(33076, 32395, 15),
		pillarID = 43508,
		pillarResetID = 43507,
	},
	[3] = {
		globalstr = "essenceOfChagorz",
		monster = "Echo Of Chagorz",
		monsterPosition = Position(33044, 32399, 15),
		flamePos = Position(33067, 32398, 15),
		flameID = 43988,
		flameResetID = 43987,
		pillarPos = Position(33071, 32398, 15),
		pillarID = 43508,
		pillarResetID = 43507,
	},
	[4] = {
		globalstr = "essenceOfVemiath",
		monster = "Echo Of Vemiath",
		monsterPosition = Position(33039, 32396, 15),
		flamePos = Position(33076, 32407, 15),
		flameID = 43986,
		flameResetID = 43985,
		pillarPos = Position(33076, 32401, 15),
		pillarID = 43508,
		pillarResetID = 43507,
	},
}

local bossInitialized = false

mType.onThink = function(monster, interval)
	if not bossInitialized then
		initializeBoss()
		bossInitialized = true
	end

	if not areMechanicsDisabled() then
		accumulatedTime = accumulatedTime + interval
		checkTime = checkTime + interval
		ensureSummons(monster)
	end

	if accumulatedTime >= summonInterval then
		-- heavy abuse of AI deleted the content here
	end

	if checkTime >= checkInterval then
		checkTime = 0

		local currentTime = os.time()
		if currentTime - lastPlayerCleanup >= 300 then
			cleanupPlayerTracking()
			lastPlayerCleanup = currentTime
		end

		local spectators = Game.getSpectators(Position(33044, 32398, 15), false, true, 20, 20, 0, 0)

		local currentPlayers = {}
		for _, player in ipairs(spectators) do
			if player:isPlayer() then
				currentPlayers[player:getId()] = true
			end
		end

		for playerId, _ in pairs(playerTracking) do
			if not currentPlayers[playerId] then
				playerTracking[playerId] = nil
				logger.debug("Bakragore: Removed player {} who left the room", playerId)
			end
		end

		for _, player in ipairs(spectators) do
			if player:isPlayer() then
				local cid = player:getId()
				local currentPos = player:getPosition()
				local tile = Tile(currentPos)
				local tileItem = tile and tile:getItemByType(ITEM_TYPE_MAGICFIELD)
				local damage = 0

				if not playerTracking[cid] then
					playerTracking[cid] = {
						lastPos = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
						iconCount = 0,
					}
					if player.setIcon then
						player:setIcon("agony-stacks", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, 0)
					end
				end

				local data = playerTracking[cid]
				local samePosition = (currentPos.x == data.lastPos.x and currentPos.y == data.lastPos.y and currentPos.z == data.lastPos.z)

				if samePosition then
					if data.iconCount <= 20 then
						data.iconCount = math.max(data.iconCount + 1, 0)
					elseif data.iconCount > 21 then
						data.iconCount = 21
					end

					if data.iconCount > 0 and data.iconCount < 15 then
						damage = damage + math.floor(player:getMaxHealth() * 0.03)
						if player.setIcon then
							player:setIcon("agony-stacks", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, data.iconCount)
						end
					elseif data.iconCount >= 15 and data.iconCount < 20 then
						damage = damage + math.floor(player:getMaxHealth() * 0.07)
						if player.setIcon then
							player:setIcon("agony-stacks", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, data.iconCount)
						end
					elseif data.iconCount >= 20 then
						damage = damage + math.floor(player:getMaxHealth() * 0.15)
						if player.setIcon then
							player:setIcon("agony-stacks", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, data.iconCount)
						end
					else
					end
				else
					if data.iconCount > 0 then
						data.iconCount = data.iconCount - 1
					else
						data.iconCount = data.iconCount
					end
					if player.setIcon then
						player:setIcon("agony-stacks", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, data.iconCount)
					end
				end

				data.lastPos.x = currentPos.x
				data.lastPos.y = currentPos.y
				data.lastPos.z = currentPos.z

				if tileItem then
					-- heavy abuse of AI deleted the content here
				end

				if damage > 0 then
					doTargetCombatHealth(monster, player, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_AGONY)
				end
			end
		end
	end

	if monster:getStorageValue(99999) ~= 1 then
		local essenceCount = 0
		local activeEssences = {}

		for _, data in pairs(pillarAndFlames) do
			if Game.getStorageValue(data.globalstr) > 0 then
				table.insert(activeEssences, data)
				essenceCount = essenceCount + 1
			end
		end

		monster:setStorageValue(88888, essenceCount)

		if essenceCount > 0 then
			local centerPos = Position(33043, 32397, 15)
			local spectators = Game.getSpectators(centerPos, false, true, 15, 15, 15, 15)
			local allHaveFinalTaint = true
			local playerCount = 0

			for _, player in ipairs(spectators) do
				if player:isPlayer() then
					playerCount = playerCount + 1
					local kv = player:kv():scoped("rotten-blood-quest")
					local currentTaintKV = kv:get("taints") or 0
					local currentTaintCondition = 0
					local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
					if taintCondition then
						currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
					end
					local currentTaint = math.max(currentTaintKV, currentTaintCondition)

					if currentTaint < 5 then
						allHaveFinalTaint = false
						logger.debug("Player {} does not have Final Taint (taint: {}), Echos will not spawn", player:getName(), currentTaint)
						break
					end
				end
			end

			if allHaveFinalTaint and playerCount > 0 then
				local resistanceBonus = essenceCount * 5

				for _, data in pairs(activeEssences) do
					Game.createMonster(data.monster, data.monsterPosition)

					Game.setStorageValue(data.globalstr, 0)

					local flame = Tile(data.flamePos):getItemById(data.flameID)
					if flame then
						flame:transform(data.flameResetID)
					end

					local pillar = Tile(data.pillarPos):getItemById(data.pillarID)
					if pillar then
						pillar:transform(data.pillarResetID)
					end
				end

				logger.debug("Bakragore: All {} players have Final Taint (5+), {} Echos spawned with +{}% resistances", playerCount, essenceCount, resistanceBonus)
			else
				logger.warn("Bakragore: Not all players have Final Taint (5+), NO Echos spawned despite {} essences available", essenceCount)

				for _, data in pairs(activeEssences) do
					Game.setStorageValue(data.globalstr, 0)

					local flame = Tile(data.flamePos):getItemById(data.flameID)
					if flame then
						flame:transform(data.flameResetID)
					end

					local pillar = Tile(data.pillarPos):getItemById(data.pillarID)
					if pillar then
						pillar:transform(data.pillarResetID)
					end
				end
			end
		end

		monster:setStorageValue(99999, 1)
	end

	return true
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end

	addEvent(function()
		local essenceCount = monster:getStorageValue(88888) or 0
		if essenceCount > 0 then
			local resistanceBonus = essenceCount * 5
			local baseResistance = 15
			local newResistance = math.min(baseResistance + resistanceBonus, 50)

			logger.debug("Bakragore resistances increased to {}% (base {}% + {}% from {} essences)", newResistance, baseResistance, resistanceBonus, essenceCount)
		end
	end, 1000)
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(_, creature, fromPos, toPos)
	if not creature or creature:isInGhostMode() then
		return
	end

	local tile = Tile(toPos)
	if not tile then
		return
	end

	local item = tile:getTopDownItem()
	local itemId = item and item:getId() or 0

	if itemId ~= 43589 and itemId ~= 43590 and itemId ~= 43297 then
		if creature:isPlayer() then
			local newItem = Game.createItem(43589, 1, toPos)
			if newItem then
				local posX, posY, posZ = toPos.x, toPos.y, toPos.z
				addEvent(function(x, y, z)
					local checkTile = Tile(Position(x, y, z))
					if not checkTile then
						return
					end

					local phase1Item = checkTile:getItemById(43589)
					if phase1Item then
						phase1Item:transform(43590)

						addEvent(function(px, py, pz)
							local phaseTile = Tile(Position(px, py, pz))
							if not phaseTile then
								return
							end

							local phase2Item = phaseTile:getItemById(43590)
							if phase2Item then
								phase2Item:transform(43297)

								addEvent(function(fx, fy, fz)
									local finalTile = Tile(Position(fx, fy, fz))
									if finalTile then
										local finalItem = finalTile:getItemById(43297)
										if finalItem then
											finalItem:remove()
										end
									end
								end, 3000, px, py, pz)
							end
						end, 3000, x, y, z)
					end
				end, 1000, posX, posY, posZ)
			end
		end
	end

	if creature:isMonster() and creature:getName():lower() == "bakragore" then
		local spore = Game.createItem(43294, 1, toPos)
		if spore then
			local spX, spY, spZ = toPos.x, toPos.y, toPos.z
			addEvent(function(sx, sy, sz)
				local sporeTile = Tile(Position(sx, sy, sz))
				if sporeTile then
					local decayItem = sporeTile:getItemById(43294)
					if decayItem then
						decayItem:transform(43295)
					end
				end
			end, 5000, spX, spY, spZ)
		end
	end
end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
