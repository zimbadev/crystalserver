local mType = Game.createMonsterType("Adventurer Group")
local monster = {}

monster.description = "an adventurer group"
monster.experience = 100000
monster.outfit = {
	lookTypeEx = 52836,
}

monster.bosstiary = {
	bossRaceId = 2773,
	bossRace = RARITY_ARCHFOE, -- não confirmado
}

monster.health = 80000
monster.maxHealth = 80000
monster.race = "blood"
monster.corpse = 52836 -- não confirmado
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000, -- não confirmado
	chance = 20, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 60, -- não confirmado
	health = 20, -- não confirmado
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
	staticAttackChance = 85, -- não confirmado
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
	interval = 5000, -- não confirmado
	chance = 10, -- não confirmado
	{ text = "Together we are unstoppable!", yell = true }, -- não confirmado
	{ text = "Cover me, allies!", yell = false }, -- não confirmado
	{ text = "For glory and treasure!", yell = true }, -- não confirmado
	{ text = "Work together, team!", yell = false }, -- não confirmado
	{ text = "No beast can defeat us united!", yell = true }, -- não confirmado
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 60 }, -- não confirmado
	{ name = "crystal coin", chance = 35000, maxCount = 5 }, -- não confirmado
	{ name = "gold ingot", chance = 25000, maxCount = 3 }, -- não confirmado
	{ name = "blue gem", chance = 18000 }, -- não confirmado
	{ name = "green gem", chance = 16000 }, -- não confirmado
	{ name = "violet gem", chance = 14000 }, -- não confirmado
	{ name = "yellow gem", chance = 12000 }, -- não confirmado
	{ id = 3039, chance = 10000 }, -- red gem (não confirmado)
	{ name = "crown armor", chance = 5000 }, -- não confirmado
	{ name = "crown shield", chance = 5500 }, -- não confirmado
	{ name = "crown helmet", chance = 4500 }, -- não confirmado
	{ name = "crown legs", chance = 4000 }, -- não confirmado
	{ name = "mastermind shield", chance = 2000 }, -- não confirmado
	{ name = "great shield", chance = 1500 }, -- não confirmado
	{ name = "giant sword", chance = 3000 }, -- não confirmado
	{ name = "magic longsword", chance = 2500 }, -- não confirmado
	{ name = "small diamond", chance = 30000, maxCount = 5 }, -- não confirmado
	{ name = "small ruby", chance = 28000, maxCount = 5 }, -- não confirmado
	{ name = "small sapphire", chance = 26000, maxCount = 5 }, -- não confirmado
	{ name = "small emerald", chance = 24000, maxCount = 5 },
	{ name = "ancient crypt rune", chance = 100000 }, -- não confirmado
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000 }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1300, range = 5, shootEffect = CONST_ANI_ARROW, target = true }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1100, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true }, -- não confirmado
	{ name = "combat", interval = 2800, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -500, maxDamage = -900, radius = 4, effect = CONST_ME_HOLYAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 3500, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -550, maxDamage = -1000, length = 6, spread = 2, effect = CONST_ME_ICEAREA, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 90, -- não confirmado
	armor = 90, -- não confirmado
	mitigation = 2.80, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
	{ name = "speed", interval = 4000, chance = 12, speedChange = 350, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 6000 }, -- não confirmado
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
