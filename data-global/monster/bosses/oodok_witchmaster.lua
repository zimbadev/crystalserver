local mType = Game.createMonsterType("Oodok Witchmaster")
local monster = {}

monster.description = "a oodok witchmaster"
monster.experience = 550
monster.outfit = {
	lookType = 214,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1129,
	bossRace = RARITY_NEMESIS,
}

monster.health = 450
monster.maxHealth = 450
monster.race = "blood"
monster.corpse = 22002
monster.speed = 75
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 80,
	targetDistance = 4,
	runHealth = 15,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {
	{ name = "gold coin", chance = 52000, maxCount = 98 },
	{ name = "platinum coin", chance = 94000, maxCount = 2 },
	{ id = 268, chance = 53000, maxCount = 3 }, -- mana potion
	{ id = 266, chance = 47000, maxCount = 3 }, -- health potion
	{ id = 3027, chance = 12900, maxCount = 2 }, -- black pearl
	{ id = 5910, chance = 11300 }, -- black pearl
	{ id = 5910, chance = 11300 }, -- green piece of cloth
	{ name = "leather armor", chance = 10000 },
	{ id = 3065, chance = 4800 }, -- terra rod
	{ name = "strange symbol", chance = 4800 },
	{ id = 3115, chance = 3200 }, -- bone
	{ name = "poison dagger", chance = 4800 },
	{ id = 5911, chance = 1600 }, -- green piece of cloth
	{ id = 3116, chance = 1600 }, -- big bone
	{ name = "tribal mask", chance = 1600 },
	{ name = "bast skirt", chance = 100 },
	{ id = 3002, chance = 100 }, -- voodoo doll
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -20 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = 0, maxDamage = -40, range = 1, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "outfit", interval = 2000, chance = 10, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 5000, outfitMonster = "chicken" },
	{ name = "speed", interval = 2000, chance = 10, speedChange = -800, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "drunk", interval = 2000, chance = 10, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_TELEPORT, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -6, maxDamage = -18, radius = 6, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "poisonfield", interval = 2000, chance = 10, range = 7, radius = 1, shootEffect = CONST_ANI_POISON, target = true },
}

monster.defenses = {
	defense = 10,
	armor = 3,
	mitigation = 0.20,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 3, maxDamage = 9, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 200, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000 },
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 35 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
