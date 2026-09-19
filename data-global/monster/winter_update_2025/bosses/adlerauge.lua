local mType = Game.createMonsterType("Adlerauge")
local monster = {}

monster.description = "Adlerauge"
monster.experience = 75000
monster.outfit = {
	lookType = 1901,
	lookHead = 94,
	lookBody = 38,
	lookLegs = 67,
	lookFeet = 19,
	lookAddons = 2,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2754,
	bossRace = RARITY_BANE,
}

monster.health = 45000
monster.maxHealth = 45000
monster.race = "blood"
monster.corpse = 52853
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000, -- não confirmado
	chance = 15, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 70, -- não confirmado
	health = 10, -- não confirmado
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
	targetDistance = 2,
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Bull's Eye!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ id = 3039, chance = 32560 }, -- red gem
	{ name = "yellow gem", chance = 29070 },
	{ name = "small sapphire", chance = 22090, maxCount = 5 },
	{ name = "repair kit for boats", chance = 22090 },
	{ name = "assassin star", chance = 19770, maxCount = 20 },
	{ name = "small diamond", chance = 19770, maxCount = 5 },
	{ name = "small ruby", chance = 18600, maxCount = 5 },
	{ name = "black pearl", chance = 18600 },
	{ name = "blue gem", chance = 16280 },
	{ name = "prismatic bolt", chance = 12790, maxCount = 17 },
	{ name = "stag parchment", chance = 11630 },
	{ name = "white pearl", chance = 11630 },
	{ name = "green gem", chance = 11630 },
	{ id = 6299, chance = 11630 }, -- death ring
	{ name = "cuirass plate", chance = 10470 },
	{ name = "personal letter of adlerauge i", chance = 9300 },
	{ name = "gold ingot", chance = 9300 },
	{ name = "assassin dagger", chance = 8140 },
	{ name = "dark armor", chance = 8140 },
	{ name = "salvaged silver parts", chance = 6980 },
	{ name = "violet gem", chance = 6980 },
	{ name = "white gem", chance = 3490 },
	{ name = "red quiver", chance = 3490 },
	{ name = "strange helmet", chance = 3490 },
	{ name = "terra mantle", chance = 3490 },
	{ name = "ornate crossbow", chance = 3490 },
	{ name = "composite hornbow", chance = 2330 },
	{ name = "crystalline arrow", chance = 1160, maxCount = 30 },
	{ name = "personal letter of adlerauge ii", chance = 4170 }, -- não confirmado
	{ name = "personal letter of adlerauge iii", chance = 2080 }, -- não confirmado
	{ name = "stag shield refinement plans", chance = 5000 }, -- não confirmado
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -900 }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -1100, range = 5, shootEffect = CONST_ANI_ROYALSPEAR, target = true }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -950, length = 6, spread = 2, effect = CONST_ME_ENERGYHIT, target = false }, -- não confirmado
	{ name = "combat", interval = 2800, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1200, radius = 4, effect = CONST_ME_EXPLOSIONHIT, target = true }, -- não confirmado
	{ name = "speed", interval = 4000, chance = 12, speedChange = -400, radius = 5, effect = CONST_ME_POFF, target = false, duration = 8000 }, -- não confirmado
}

monster.defenses = {
	defense = 85, -- não confirmado
	armor = 85, -- não confirmado
	mitigation = 2.50, -- não confirmado
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1500, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
