local mType = Game.createMonsterType("Chagorz")
local monster = {}

monster.description = "Chagorz"
monster.experience = 3250000
monster.outfit = {
	lookType = 1666,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"RottenBloodBossDeath",
	"ChagorzMechanicsDeath",
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "undead"
monster.corpse = 44024
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2366,
	bossRace = RARITY_ARCHFOE,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "The ... light ... that ... drains!", yell = true },
	{ text = "Light ... that ... isn't!", yell = true },
	{ text = "WILL ... PUNISH ... YOU!", yell = true },
	{ text = "RAAAR!", yell = true },
	{ text = "Darkness ... devours!!", yell = true },
}

monster.loot = {
	{ id = 43895, chance = 360, unique = true }, ---bag you covet
	{ name = "berserk potion", chance = 22758, minCount = 24, maxCount = 31 },
	{ id = 3041, chance = 14702, minCount = 0, maxCount = 1 }, -- blue gem,
	{ name = "bullseye potion", chance = 13972, minCount = 21, maxCount = 23 },
	{ name = "crystal coin", chance = 28018, minCount = 0, maxCount = 89 },
	{ name = "darklight figurine", chance = 23164 },
	{ name = "giant topaz", chance = 55000, maxCount = 1 },
	{ name = "giant sapphire", chance = 45000, minCount = 1, maxCount = 3 },
	{ name = "gold ingot", chance = 18000, minCount = 1, maxCount = 1 },
	{ name = "green gem", chance = 9100, minCount = 1, maxCount = 1 },
	{ name = "mastermind potion", chance = 23945, minCount = 13, maxCount = 13 },
	{ name = "raw watermelon tourmaline", chance = 21876, minCount = 0, maxCount = 1 },
	{ id = 3039, chance = 22121, minCount = 1, maxCount = 29 }, -- red gem,
	{ name = "supreme health potion", chance = 22303, minCount = 24, maxCount = 164 },
	{ name = "unicorn figurine", chance = 23030 },
	{ name = "ultimate mana potion", chance = 22519, minCount = 9, maxCount = 100 },
	{ name = "ultimate spirit potion", chance = 55000, minCount = 16, maxCount = 198 },
	{ name = "violet gem", chance = 24963, minCount = 1, maxCount = 4 },
	{ name = "white gem", chance = 24927, minCount = 1, maxCount = 4 },
	{ name = "yellow gem", chance = 22940, minCount = 1, maxCount = 3 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1300, maxDamage = -1600 },
	{ name = "chagorzring", interval = 2000, chance = 25, minDamage = -3200, maxDamage = -4000, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -500, range = 7, radius = 6, effect = 18, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -500, radius = 6, effect = 18, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -500, radius = 6, effect = 32, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -1600, radius = 7, effect = 20, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -1500, maxDamage = -2000, length = 8, spread = 0, effect = 221, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1000, length = 8, spread = 0, effect = 18, target = false },
}

monster.defenses = {
	defense = 305,
	armor = 305,
	mitigation = 7.16,
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 4700, maxDamage = 6500, effect = 249, target = false },
}

monster.elements = {
	{ type = "COMBAT_PHYSICALDAMAGE", percent = 0 },
	{ type = "COMBAT_DEATHDAMAGE", percent = 0 },
	{ type = "COMBAT_HOLYDAMAGE", percent = 0 },
	{ type = "COMBAT_ICEDAMAGE", percent = 0 },
	{ type = "COMBAT_FIREDAMAGE", percent = 0 },
	{ type = "COMBAT_ENERGYDAMAGE", percent = 0 },
	{ type = "COMBAT_EARTHDAMAGE", percent = 10 },
	{ type = "COMBAT_LIFEDRAIN", percent = 0 },
	{ type = "COMBAT_MANADRAIN", percent = 0 },
	{ type = "COMBAT_DROWNDAMAGE", percent = 0 },
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

local RottenBloodMechanics = dofile(DATA_DIRECTORY .. "/scripts/quests/rotten_blood_quest/rotten_blood_boss_mechanics.lua")

local function ensureSummons(monster)
	local pos = monster:getPosition()
	local radiusX, radiusY = 16, 16

	local existingPillars = 0

	for _, cid in ipairs(Game.getSpectators(pos, false, false, radiusX, radiusX, radiusY, radiusY)) do
		if cid:isMonster() then
			local name = cid:getName():lower()
			if name == "pillar of dark energy" then
				existingPillars = existingPillars + 1
			end
		end
	end

	RottenBloodMechanics.handleElderBloodjawSpawn("Chagorz", monster)

	for i = 1, 4 - existingPillars do
		local summonPos = getClosePosition(pos)
		Game.createMonster("pillar of dark energy", summonPos)
	end
end

local playerTracking = {}
local checkInterval = 1000
local checkTime = 0

local bossInitialized = false

local bossStates = {
	["Chagorz"] = {
		teleportTimer = nil,
	},
}

local function initializeBoss()
	if bossStates["Chagorz"].teleportTimer then
		stopEvent(bossStates["Chagorz"].teleportTimer)
	end

	local function startTeleportCycle()
		bossStates["Chagorz"].teleportTimer = addEvent(function()
			local centerPos = Position(33043, 32366, 15)

			if Game.getStorageValue("ChagorzTeleportPaused") == 1 then
				logger.debug("Chagorz teleport system paused, skipping cycle")
				startTeleportCycle()
				return
			end

			local spectators = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
			local bossAlive = false
			local elderBloodjawExists = false

			for _, creature in ipairs(spectators) do
				if creature:isMonster() then
					if creature:getName() == "Chagorz" then
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
					logger.debug("Teleport created for Chagorz with ActionId {}", teleport:getActionId())

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
				logger.debug("No Elder Bloodjaw found, skipping teleport creation for Chagorz")
			end

			startTeleportCycle()
		end, 90000)
	end

	startTeleportCycle()
end

mType.onThink = function(monster, interval)
	if not bossInitialized then
		initializeBoss()
		bossInitialized = true
	end

	if not RottenBloodMechanics.areMechanicsDisabled("Chagorz") then
		accumulatedTime = accumulatedTime + interval
		checkTime = checkTime + interval
		ensureSummons(monster)
	end

	if accumulatedTime >= summonInterval then
		-- heavy abuse of AI deleted the content here
	end

	if checkTime >= checkInterval then
		checkTime = 0
		local spectators = Game.getSpectators(monster:getPosition(), false, true, 16, 16, 16, 16)

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
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(_, creature, fromPos, toPos)
	if not creature or not creature:isPlayer() or creature:isInGhostMode() then
		return
	end

	local tile = Tile(toPos)
	if not tile then
		return
	end

	local item = tile:getTopDownItem()
	local itemId = item and item:getId() or 0

	if itemId == 43589 or itemId == 43590 or itemId == 43625 then
		return
	end

	local newItem = Game.createItem(43589, 1, toPos)
	if newItem then
		addEvent(function()
			local tile = Tile(toPos)
			local decayItem = tile and tile:getItemById(43589)
			if decayItem then
				decayItem:transform(43590)

				addEvent(function()
					local updatedItem = tile and tile:getItemById(43590)
					if updatedItem then
						updatedItem:transform(43625)

						addEvent(function()
							local finalItem = tile and tile:getItemById(43625)
							if finalItem then
								finalItem:remove()
							end
						end, 3000)
					end
				end, 3000)
			end
		end, 1000)
	end
end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
