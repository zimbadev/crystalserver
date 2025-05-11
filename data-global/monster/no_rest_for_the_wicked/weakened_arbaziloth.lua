local mType = Game.createMonsterType("Weakened Arbaziloth")
local monster = {}

monster.description = "Weakened Arbaziloth"
monster.experience = 500000
monster.outfit = {
	lookType = 1802,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 360000
monster.maxHealth = 360000
monster.race = "undead"
monster.corpse = 50029
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2594,
	bossRace = RARITY_ARCHFOE,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
}

monster.events = {
	"azzilonCastleArbazilothOnDeath",
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
	staticAttackChance = 90,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I am superior!", yell = false },
	{ text = "You are mad to challange a demon prince!", yell = false },
	{ text = "You can't stop me or my plans!", yell = false },
	{ text = "Pesky humans!", yell = false },
	{ text = "This insolence!", yell = false },
	{ text = "Nobody can stop me!", yell = false },
	{ text = "All will have to bow to me!", yell = false },
	{ text = "With this power I can crush everyone!", yell = false },
	{ text = "All that energy is mine!", yell = false },
	{ text = "Face the power of hell!", yell = false },
	{ text = "AHHH! THE POWER!!", yell = true },
}

monster.loot = {
	{ id = 3043, chance = 100000, maxCount = 3 }, -- crystal coin
	{ id = 3035, chance = 100000, maxCount = 98 }, -- platinum coin
	{ id = 237, chance = 35000, maxCount = 19 }, -- strong mana potion
	{ id = 237, chance = 35000, maxCount = 9 }, -- great mana potion
	{ id = 7642, chance = 35000, maxCount = 4 }, -- great spirit potion
	{ id = 23373, chance = 35000, maxCount = 29 }, -- ultimate mana potion
	{ id = 7643, chance = 35000, maxCount = 14 }, -- ultimate health potion
	{ id = 23375, chance = 35000, maxCount = 8 }, -- supreme health potion
	{ id = 23374, chance = 35000, maxCount = 14 }, -- ultimate spirit potion
	{ id = 3041, chance = 35000, maxCount = 2 }, -- blue gem
	{ id = 3039, chance = 35000, maxCount = 1 }, -- red gem
	{ id = 3037, chance = 35000, maxCount = 2 }, -- yellow gem
	{ id = 3320, chance = 20000, maxCount = 1 }, --  fire axe
	{ id = 3281, chance = 20000, maxCount = 1 }, --  giant sword
	{ id = 3081, chance = 20000, maxCount = 1 }, --  stone skin amulet
	{ id = 817, chance = 20000, maxCount = 1 }, --  magma amulet
	{ id = 6299, chance = 20000, maxCount = 1 }, -- death ring
	{ id = 3052, chance = 20000, maxCount = 1 }, --  life ring
	{ id = 3373, chance = 20000, maxCount = 1 }, --  strange helmet
	{ id = 3356, chance = 20000, maxCount = 1 }, --  devil helmet
	{ id = 3284, chance = 20000, maxCount = 1 }, --  ice rapier
	{ id = 3280, chance = 20000, maxCount = 1 }, --  fire sword
	{ id = 3063, chance = 20000, maxCount = 1 }, --  gold ring
	{ id = 3306, chance = 20000, maxCount = 1 }, --  golden sickle
	{ id = 821, chance = 20000, maxCount = 1 }, --  magma legs
	{ id = 3048, chance = 20000, maxCount = 1 }, --  might ring
	{ id = 3055, chance = 20000, maxCount = 1 }, --  platinum amulet
	{ id = 2848, chance = 20000, maxCount = 1 }, --  purple tome
	{ id = 3098, chance = 20000, maxCount = 1 }, --  ring of healing
	{ id = 3054, chance = 20000, maxCount = 1 }, --  silver amulet
	{ id = 3324, chance = 20000, maxCount = 1 }, --  skull staff
	{ id = 10438, chance = 20000, maxCount = 1 }, --  spellweaver's robe
	{ id = 8082, chance = 20000, maxCount = 1 }, --  underworld rod
	{ id = 3071, chance = 20000, maxCount = 1 }, --  wand of inferno
	{ id = 3420, chance = 10000, maxCount = 1 }, -- demon shield
	{ id = 50067, chance = 10000, maxCount = 1 }, -- arbaziloth shoulder piece
	{ id = 3019, chance = 10000, maxCount = 1 }, -- demonbone amulet
	{ id = 7382, chance = 10000, maxCount = 1 }, -- demonrage sword
	{ id = 32622, chance = 10000, maxCount = 1 }, -- giant amethyst
	{ id = 30060, chance = 10000, maxCount = 1 }, -- giant emerald
	{ id = 30061, chance = 10000, maxCount = 1 }, -- giant sapphire
	{ id = 30059, chance = 10000, maxCount = 1 }, -- giant ruby
	{ id = 3364, chance = 10000, maxCount = 1 }, -- golden legs
	{ id = 3366, chance = 10000, maxCount = 1 }, -- magic plate armor
	{ id = 50060, chance = 700, maxCount = 1 }, -- demon claws
	{ id = 49522, chance = 400, maxCount = 1 }, -- inferniarch arbalest
	{ id = 49523, chance = 400, maxCount = 1 }, -- inferniarch battleaxe
	{ id = 49520, chance = 400, maxCount = 1 }, -- inferniarch bow
	{ id = 49524, chance = 400, maxCount = 1 }, -- inferniarch greataxe
	{ id = 49525, chance = 400, maxCount = 1 }, -- inferniarch flail
	{ id = 49526, chance = 400, maxCount = 1 }, -- inferniarch warhammer
	{ id = 49528, chance = 400, maxCount = 1 }, -- inferniarch wand
	{ id = 49529, chance = 400, maxCount = 1 }, -- inferniarch rod
	{ id = 49530, chance = 400, maxCount = 1 }, -- inferniarch slayer
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 500, maxDamage = -790 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -750, radius = 7, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -1150, radius = 3, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -750, length = 5, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1450, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -1000, maxDamage = -1500, radius = 4, effect = 170, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -1500, radius = 1, effect = 49, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -1300, maxDamage = -1490, length = 6, spread = 0, effect = 6, target = false }, --CONST_ME_YELLOWSMOKE
}

monster.defenses = {
	defense = 70,
	armor = 70,
	mitigation = 1.18,
	{ name = "combat", interval = 5000, chance = 5, type = COMBAT_HEALING, minDamage = 1100, maxDamage = 2600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true },
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

local aditionalMonsters = {
	{ name = "Overcharged Demon", pos = Position(34029, 32328, 14) },
	{ name = "Overcharged Demon", pos = Position(34037, 32328, 14) },
}

local areaTopLeft = Position(34026, 32325, 14)
local areaBottomRight = Position(34042, 32340, 14)

local effectInterval = 2000
local effectDuration = 5000

local forgemasterAreaTopLeft = Position(34026, 32325, 14)
local forgemasterAreaBottomRight = Position(34042, 32340, 14)

local function countMonstersInArea(fromPos, toPos, monsterName)
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			local tile = Tile(Position(x, y, fromPos.z))
			if tile then
				local creatures = tile:getCreatures()
				for _, creature in ipairs(creatures) do
					if creature:isMonster() and creature:getName():lower() == monsterName:lower() then
						return true
					end
				end
			end
		end
	end
	return false
end

local function healMaster(monster)
	if not monster or not monster:isMonster() then
		return
	end

	local healCount = Game.getStorageValue("globalArbazilothHeal") or 0
	if healCount >= 1 then
		return
	end
	monster:addHealth(monster:getMaxHealth() - monster:getHealth())
	monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	Game.setStorageValue("globalArbazilothHeal", healCount + 1)
end

local function replaceMaster(monster)
	if monster and monster:isMonster() then
		local pos = monster:getPosition()
		monster:remove()
		Game.createMonster("Weakened Arbaziloth", pos)
	end
end

local function countDemonsInArea(fromPos, toPos)
	local count = 0
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			local tile = Tile(Position(x, y, fromPos.z))
			if tile then
				local creatures = tile:getCreatures()
				for _, creature in ipairs(creatures) do
					if creature:isMonster() and creature:getName():lower() == "overcharged demon" then
						count = count + 1
						if count >= 2 then
							return count
						end
					end
				end
			end
		end
	end
	return count
end

local function showEffectsAndSummon(monster)
	local times = 0

	local function effectLoop()
		if times < (effectDuration / effectInterval) then
			for _, monsterData in ipairs(aditionalMonsters) do
				if countDemonsInArea(areaTopLeft, areaBottomRight) < 2 then
					monsterData.pos:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
			times = times + 1
			addEvent(effectLoop, effectInterval)
		else
			local currentCount = countDemonsInArea(areaTopLeft, areaBottomRight)
			if currentCount < 2 then
				local demonsToSummon = 2 - currentCount
				for i = 1, demonsToSummon do
					local monsterData = aditionalMonsters[i]
					if monsterData then
						Game.createMonster(monsterData.name, monsterData.pos)
					end
				end
			end
		end
	end

	effectLoop()
end

local fireSpawnTopLeft = Position(34027, 32328, 14)
local fireSpawnBottomRight = Position(34029, 32336, 14)

local function getRandomPosition(fromPos, toPos)
	local x = math.random(fromPos.x, toPos.x)
	local y = math.random(fromPos.y, toPos.y)
	local z = fromPos.z
	return Position(x, y, z)
end

local function createItemInRandomPosition(itemId, fromPos, toPos)
	local maxAttempts = 10
	for _ = 1, maxAttempts do
		local pos = getRandomPosition(fromPos, toPos)
		local tile = Tile(pos)
		if tile and not tile:getItemById(itemId) then
			if Game.getStorageValue("globalArbazilothFire") >= 1 then
			else
				Game.createItem(itemId, 1, pos)
			end
			return true
		end
	end
	return false
end

mType.onThink = function(monster, interval)
	if countDemonsInArea(areaTopLeft, areaBottomRight) < 2 then
		showEffectsAndSummon(monster)
	end
	if Game.getStorageValue("globalArbazilothHeal") < 1 then
		if monster:getHealth() > 295000 and monster:getHealth() < 300000 then
			monster:registerEvent("ArbazilothImmunity")
			createItemInRandomPosition(49362, fireSpawnTopLeft, fireSpawnBottomRight)
			Game.setStorageValue("globalArbazilothFire", 1)
		elseif monster:getHealth() > 220000 and monster:getHealth() < 225000 then
			monster:registerEvent("ArbazilothImmunity")
			monster:setOutfit({ lookType = 1800 })
			createItemInRandomPosition(49362, fireSpawnTopLeft, fireSpawnBottomRight)
			Game.setStorageValue("globalArbazilothFire", 1)
		elseif monster:getHealth() > 145000 and monster:getHealth() < 150000 then
			monster:registerEvent("ArbazilothImmunity")
			monster:setOutfit({ lookType = 1801 })
			createItemInRandomPosition(49362, fireSpawnTopLeft, fireSpawnBottomRight)
			Game.setStorageValue("globalArbazilothFire", 1)
		elseif monster:getHealth() > 70000 and monster:getHealth() < 75000 then
			monster:registerEvent("ArbazilothImmunity")
			monster:setOutfit({ lookType = 1802 })
			createItemInRandomPosition(49362, fireSpawnTopLeft, fireSpawnBottomRight)
			Game.setStorageValue("globalArbazilothFire", 1)
		end
	end
end
mType:register(monster)
