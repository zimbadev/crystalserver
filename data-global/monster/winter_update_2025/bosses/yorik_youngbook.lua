local mType = Game.createMonsterType("Yorik Youngbook")
local monster = {}

monster.description = "Yorik Youngbook"
monster.experience = 0
monster.outfit = {
	lookType = 268,
	lookHead = 57,
	lookBody = 77,
	lookLegs = 79,
	lookFeet = 114,
	lookAddons = 3,
}

monster.health = 155000
monster.maxHealth = 155000
monster.race = "blood"
monster.corpse = 6081
monster.speed = 135
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2712,
	bossRace = RARITY_ARCHFOE, -- não confirmado
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
	rewardBoss = false, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = true,
	canPushCreatures = true, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 4, -- não confirmado
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

monster.voices = {
	interval = 5000, -- não confirmado
	chance = 10, -- não confirmado
	{ text = "What? How did they get in?", yell = false },
	{ text = "Stand together, team!", yell = false },
	{ text = "It's time to get serious!", yell = false },
	{ text = "You swing like a rookie!", yell = false },
	{ text = "Sorry, my guild needs me!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -700, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -450, maxDamage = -750, length = 6, spread = 3, effect = CONST_ME_ENERGYHIT, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -550, maxDamage = -850, radius = 5, effect = CONST_ME_FIREAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -550, radius = 4, effect = CONST_ME_PURPLEENERGY, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 70, -- não confirmado
	armor = 70, -- não confirmado
	mitigation = 1.90, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 300, maxDamage = 550, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
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
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
