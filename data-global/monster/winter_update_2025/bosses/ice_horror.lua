local mType = Game.createMonsterType("Ice Horror")
local monster = {}

monster.description = "an ice horror"
monster.experience = 259000
monster.outfit = {
	lookType = 1881,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2733,
	bossRace = RARITY_ARCHFOE, -- não confirmado
	storageCooldown = 82072, -- não confirmado
}

monster.health = 550000
monster.maxHealth = 550000
monster.race = "undead"
monster.corpse = 44830 -- não confirmado
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000, -- não confirmado
	chance = 22, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 65, -- não confirmado
	health = 15, -- não confirmado
	damage = 10, -- não confirmado
	random = 10, -- não confirmado
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false, -- não confirmado
	canPushItems = true,
	canPushCreatures = true, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1,
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4, -- não confirmado
	summons = {
		{ name = "Ice Blockade", chance = 15, interval = 4000, count = 2 }, -- não confirmado
		{ name = "Ice Crawler", chance = 12, interval = 5000, count = 2 }, -- não confirmado
	},
}

monster.voices = {
	interval = 5000,
	chance = 12,
	{ text = "COME HERE!!!", yell = true },
	{ text = "KRRRRK!", yell = true },
	{ text = "<SHATER>!", yell = true },
	{ text = "C'HHRRR!", yell = true },
}

monster.loot = {
	{ name = "crystal coin", chance = 100000, maxCount = 51 },
	{ name = "yellow gem", chance = 50000, maxCount = 10 }, -- não confirmado
	{ name = "strong mana potion", chance = 50000, maxCount = 95 }, -- não confirmado
	{ name = "great mana potion", chance = 50000, maxCount = 69 }, -- não confirmado
	{ name = "great spirit potion", chance = 50000, maxCount = 53 }, -- não confirmado
	{ name = "ultimate mana potion", chance = 41670, maxCount = 25 }, -- não confirmado
	{ name = "ultimate spirit potion", chance = 41670, maxCount = 23 }, -- não confirmado
	{ name = "ultimate health potion", chance = 41670, maxCount = 38 }, -- não confirmado
	{ name = "supreme health potion", chance = 41670, maxCount = 15 }, -- não confirmado
	{ name = "blue gem", chance = 25000, maxCount = 3 }, -- não confirmado
	{ id = 3039, chance = 25000, maxCount = 7 }, -- red gem (não confirmado)
	{ name = "giant ruby", chance = 10000, maxCount = 2 }, -- não confirmado
	{ name = "giant emerald", chance = 10000 }, -- não confirmado
	{ name = "giant sapphire", chance = 10000, maxCount = 3 }, -- não confirmado
	{ name = "guardian gem", chance = 5000 }, -- não confirmado
	{ name = "marksman gem", chance = 5000 }, -- não confirmado
	{ name = "mystic gem", chance = 5000 }, -- não confirmado
	{ name = "sage gem", chance = 5000 }, -- não confirmado
	{ name = "spiritualist gem", chance = 5000 }, -- não confirmado
	{ name = "greater guardian gem", chance = 3000 }, -- não confirmado
	{ name = "greater marksman gem", chance = 3000 }, -- não confirmado
	{ name = "greater mystic gem", chance = 3000 }, -- não confirmado
	{ name = "greater sage gem", chance = 3000 }, -- não confirmado
	{ name = "greater spiritualist gem", chance = 3000 }, -- não confirmado
	{ id = 7441, chance = 10000 }, -- ice cube (não confirmado)
	{ id = 2992, chance = 10000, maxCount = 6 }, -- snowball (não confirmado)
	{ name = "frosty heart", chance = 8000 }, -- não confirmado
	{ id = 3007, chance = 5000 }, -- crystal ring (não confirmado)
	{ name = "pair of earmuffs", chance = 5000 }, -- não confirmado
	{ name = "crystal mace", chance = 5000 }, -- não confirmado
	{ name = "glacier mask", chance = 5000 }, -- não confirmado
	{ name = "glacial rod", chance = 5000 }, -- não confirmado
	{ name = "ice rapier", chance = 5000 },
	{ name = "cryptic fossil", chance = 5000 }, -- não confirmado
	{ name = "fetid heart", chance = 5000 }, -- não confirmado
	{ name = "frozen crapace", chance = 5000 },
	{ id = 52729, chance = 3000 }, -- frozen claw (não confirmado)
	{ name = "icy scales", chance = 5000 },
	{ name = "icy horns", chance = 5000 },
	{ name = "icy crypt rune", chance = 100000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 28, type = COMBAT_ICEDAMAGE, minDamage = -900, maxDamage = -1700, length = 9, spread = 3, effect = CONST_ME_ICEAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 24, type = COMBAT_ICEDAMAGE, minDamage = -800, maxDamage = -1500, radius = 6, effect = CONST_ME_ICEATTACK, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -700, maxDamage = -1400, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true }, -- não confirmado
	{ name = "combat", interval = 2800, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -850, maxDamage = -1600, length = 7, spread = 2, effect = CONST_ME_GIANTICE, target = false }, -- não confirmado
	{ name = "combat", interval = 3500, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -1000, maxDamage = -1800, radius = 5, effect = CONST_ME_BIGCLOUDS, target = false }, -- não confirmado
	{ name = "speed", interval = 4000, chance = 15, speedChange = -600, radius = 6, effect = CONST_ME_ICEAREA, target = false, duration = 12000 }, -- não confirmado
	{ name = "condition", type = CONDITION_FREEZING, interval = 4500, chance = 12, minDamage = -200, maxDamage = -400, radius = 5, effect = CONST_ME_ICEATTACK, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 92, -- não confirmado
	armor = 92, -- não confirmado
	mitigation = 3.00, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_HEALING, minDamage = 1200, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }, -- não confirmado
}

mType:register(monster)
