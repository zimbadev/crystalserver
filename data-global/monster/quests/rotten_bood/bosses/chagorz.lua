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
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "undead"
monster.corpse = 44021
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2366,
	bossRace = RARITY_NEMESIS,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
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
}

monster.loot = {
	{ id = 43895, chance = 4996 }, -- bag you covet,
	{ name = "berserk potion", chance = 2758, minCount = 0, maxCount = 40 },
	{ id = 3041, chance = 4702, minCount = 0, maxCount = 1 }, -- blue gem,
	{ name = "bullseye potion", chance = 3972, minCount = 0, maxCount = 31 },
	{ name = "crystal coin", chance = 4018, minCount = 0, maxCount = 100 },
	{ name = "darklight figurine", chance = 3164 },
	{ name = "giant topaz", chance = 3744, minCount = 0, maxCount = 1 },
	{ name = "giant sapphire", chance = 4917, minCount = 0, maxCount = 1 },
	{ name = "gold ingot", chance = 2250, minCount = 0, maxCount = 1 },
	{ name = "green gem", chance = 4373, minCount = 0, maxCount = 1 },
	{ name = "mastermind potion", chance = 3945, minCount = 0, maxCount = 27 },
	{ name = "raw watermelon tourmaline", chance = 1876, minCount = 0, maxCount = 1 },
	{ id = 3039, chance = 2121, minCount = 0, maxCount = 1 }, -- red gem,
	{ name = "supreme health potion", chance = 2303, minCount = 0, maxCount = 164 },
	{ name = "the essence of chagorz", chance = 4820 },
	{ name = "unicorn figurine", chance = 3030 },
	{ name = "ultimate mana potion", chance = 2519, minCount = 0, maxCount = 98 },
	{ name = "ultimate spirit potion", chance = 2047, minCount = 0, maxCount = 127 },
	{ name = "violet gem", chance = 4963, minCount = 0, maxCount = 1 },
	{ name = "white gem", chance = 4927, minCount = 0, maxCount = 3 },
	{ name = "yellow gem", chance = 1940, minCount = 0, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1300, maxDamage = -2250 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -900, radius = 4, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -900, range = 4, radius = 4, effect = 241, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -1000, maxDamage = -1200, length = 10, spread = 3, effect = CONST_ME_POFF, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -1500, maxDamage = -1900, length = 10, spread = 3, effect = 225, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -600, radius = 7, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 20000 },
}

monster.defenses = {
	defense = 105,
	armor = 105,
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 700, maxDamage = 1500, effect = 236, target = false },
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

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
