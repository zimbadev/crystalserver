local mType = Game.createMonsterType("Grendel Greenlunch")
local monster = {}

monster.description = "Grendel Greenlunch"
monster.experience = 0
monster.outfit = {
	lookType = 144,
	lookHead = 22,
	lookBody = 62,
	lookLegs = 101,
	lookFeet = 58,
	lookAddons = 3,
}

monster.health = 155000
monster.maxHealth = 155000
monster.race = "blood"
monster.corpse = 6081
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2714,
	bossRace = RARITY_ARCHFOE, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 70, -- não confirmado
	health = 10, -- não confirmado
	damage = 10, -- não confirmado
	random = 10, -- não confirmado
}

monster.flags = {
	summonable = false, -- não confirmado
	attackable = true, -- não confirmado
	hostile = true, -- não confirmado
	convinceable = false, -- não confirmado
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
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.voices = {
	interval = 5000, -- não confirmado
	chance = 10, -- não confirmado
	{ text = "As long as I live, my friends have nothing to fear.", yell = false },
	{ text = "Let me invoke the fear of nature in you!", yell = false },
	{ text = "Let's kill those noobs an' loot 'em!", yell = false },
	{ text = "Nature heals.", yell = false },
	{ text = "Don't worry, I'll heal you!", yell = false },
	{ text = "You woke the beast, now deal with it!", yell = false },
	{ text = "I'm out of there!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -450, maxDamage = -700, range = 7, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_CARNIPHILA, target = true }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -650, length = 7, spread = 3, effect = CONST_ME_POISONAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -550, maxDamage = -850, radius = 5, effect = CONST_ME_BIGPLANTS, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -500, radius = 4, effect = CONST_ME_MAGIC_GREEN, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 85, -- não confirmado
	armor = 85, -- não confirmado
	mitigation = 2.20, -- não confirmado
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HEALING, minDamage = 500, maxDamage = 800, effect = CONST_ME_MAGIC_GREEN, target = false }, -- não confirmado
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
