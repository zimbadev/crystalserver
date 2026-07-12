local mType = Game.createMonsterType("Michael the Stalwart")
local monster = {}

monster.description = "Michael the Stalwart"
monster.experience = 75000
monster.outfit = {
	lookType = 1900,
	lookHead = 94,
	lookBody = 31,
	lookLegs = 19,
	lookFeet = 38,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2753,
	bossRace = RARITY_BANE,
}

monster.health = 60000
monster.maxHealth = 60000
monster.race = "blood"
monster.corpse = 44832 -- não confirmado
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 3500, -- não confirmado
	chance = 20, -- não confirmado
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
	targetDistance = 1,
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
	{ text = "Fight me, outsider!", yell = false },
	{ text = "You think you have this under control?", yell = false },
	{ text = "This will be the end of you", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ id = 3039, chance = 34000 }, -- red gem
	{ name = "yellow gem", chance = 29330 },
	{ name = "small ruby", chance = 20670, maxCount = 5 },
	{ name = "repair kit for boats", chance = 19330 },
	{ name = "small sapphire", chance = 19330, maxCount = 5 },
	{ id = 6299, chance = 18670 }, -- death ring
	{ name = "small diamond", chance = 18670, maxCount = 5 },
	{ name = "black pearl", chance = 18000 },
	{ name = "green gem", chance = 17330 },
	{ name = "dark armor", chance = 16000 },
	{ name = "cuirass plate", chance = 14000 },
	{ name = "white pearl", chance = 14000 },
	{ id = 3091, chance = 12670 }, -- sword ring
	{ name = "silver poniard", chance = 11330 },
	{ name = "blue gem", chance = 10000 },
	{ name = "personal letter of michael the stalwart i", chance = 10000 },
	{ name = "gold ingot", chance = 9330 },
	{ name = "dark shield", chance = 8670 },
	{ name = "violet gem", chance = 6670 },
	{ name = "salvaged bronze parts", chance = 6000 },
	{ name = "fur armor", chance = 4670 },
	{ name = "mercenary sword", chance = 4000 },
	{ name = "strange helmet", chance = 4000 },
	{ name = "terra legs", chance = 2670 },
	{ name = "white gem", chance = 2670 },
	{ name = "crown shield", chance = 1330 },
	{ name = "crystalline armor", chance = 1330 },
	{ name = "crown armor", chance = 670 },
	{ name = "personal letter of michael the stalwart ii", chance = 670 },
	{ name = "personal letter of michael the stalwart iii", chance = 670 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1100 }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = -1400, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 22, type = COMBAT_HOLYDAMAGE, minDamage = -600, maxDamage = -1200, range = 5, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_HOLYAREA, target = true }, -- não confirmado
	{ name = "combat", interval = 2800, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1300, length = 6, spread = 2, effect = CONST_ME_HITAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 3500, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -650, maxDamage = -1150, radius = 5, effect = CONST_ME_HOLYAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -900, maxDamage = -1500, radius = 3, effect = CONST_ME_EXPLOSIONHIT, target = true }, -- não confirmado
}

monster.defenses = {
	defense = 92, -- não confirmado
	armor = 92, -- não confirmado
	mitigation = 2.80, -- não confirmado
	{ name = "combat", interval = 3000, chance = 18, type = COMBAT_HEALING, minDamage = 1100, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
	{ name = "speed", interval = 5000, chance = 12, speedChange = 350, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 6000 }, -- não confirmado
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
