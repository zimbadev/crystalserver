local mType = Game.createMonsterType("Vemiath")
local monster = {}

monster.description = "Vemiath"
monster.experience = 3250000
monster.outfit = {
	lookType = 1668,
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
	bossRaceId = 2365,
	bossRace = RARITY_NEMESIS
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

monster.summon = {
	maxSummons = 8,
	summons = {
		{ name = "Pillar of Dark Energy", chance = 38, interval = 1713, count = 7 }
	}
}

monster.voices = {
}

monster.loot = {
	{ name = "crystal coin", chance = 2832, minCount = 1, maxCount = 125},
	{ name = "ultimate mana potion", chance = 3676, minCount = 1, maxCount = 211},
	{ name = "ultimate spirit potion", chance = 4373, minCount = 1, maxCount = 35},
	{ name = "supreme health potion", chance = 3446, minCount = 1, maxCount = 179},
	{ name = "bullseye potion", chance = 3542, minCount = 1, maxCount = 42},
	{ name = "berserk potion", chance = 4060, minCount = 1, maxCount = 45},
	{ name = "mastermind potion", chance = 2891, minCount = 1, maxCount = 44},
	{ id = 3041, chance = 3992, minCount = 0, maxCount = 5}, -- blue gem,
	{ name = "green gem", chance = 1989, minCount = 0, maxCount = 5},
	{ id = 3039, chance = 2491, minCount = 0, maxCount = 5}, -- red gem,
	{ name = "yellow gem", chance = 3194, minCount = 0, maxCount = 5},
	{ name = "violet gem", chance = 2163, minCount = 0, maxCount = 5},
	{ name = "gold ingot", chance = 2249},
	{ name = "giant emerald", chance = 2434},
	{ name = "giant topaz", chance = 1850},
	{ name = "giant amethyst", chance = 1698},
	{ name = "raw watermelon tourmaline", chance = 4768},
	{ name = "vemiath's infused basalt", chance = 3249, minCount = 0, maxCount = 1},
	{ name = "dragon figurine", chance = 3595},
	{ name = "darklight figurine", chance = 4829},
	{ name = "the essence of vemiath", chance = 4167},
	{ name = "spiritual horseshoe", chance = 1813},
	{ id = 43895, chance = 2280}, -- bag you covet
}

monster.attacks = {
	{ name ="melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -2500 },
	{ name ="combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -1000, length = 10, spread = 3, effect = 244, target = false },
	{ name ="speed", interval = 2000, chance = 25, speedChange = -600, radius = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },
	{ name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -700, radius = 5, effect = 243, target = false },
	{ name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -800, length = 10, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -800, length = 8, spread = 3, effect = CONST_ME_FIREATTACK, target = false }
}

monster.defenses = {
	defense = 105,
	armor = 105,
	{ name ="combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1500, effect = 236, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
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
