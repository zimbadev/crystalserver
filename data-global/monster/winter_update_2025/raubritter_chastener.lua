local mType = Game.createMonsterType("Raubritter Chastener")
local monster = {}

monster.name = "Raubritter Chastener"
monster.description = "a raubritter chastener"
monster.experience = 9500
monster.outfit = {
	lookType = 1902,
	lookHead = 94,
	lookBody = 19,
	lookLegs = 21,
	lookFeet = 78,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2752
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Adaean Shore, Adaean Silver Mines, Arean Outskirts, Bloodfire Gorge, Isle of Ada, Stag Bastion, Adaean Crystal Mines.",
}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "blood"
monster.corpse = 52692
monster.speed = 150
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
	pushable = false,
	rewardBoss = false,
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
	{ text = "This is ours now!", yell = false },
	{ text = "Purification! Sal... vation! Deliver...", yell = false },
	{ text = "I'll... hunt you... down!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 4, maxCount = 10 },
	{ name = "small amethyst", chance = 9810 },
	{ name = "small ruby", chance = 7700 },
	{ id = 3039, chance = 5350 }, -- red gem
	{ name = "magma monocle", chance = 3710 },
	{ name = "wand of cosmic energy", chance = 2520 },
	{ name = "stag parchment", chance = 2050 },
	{ name = "silver poniard", chance = 1530 },
	{ name = "wand of starstorm", chance = 1390 },
	{ name = "violet gem", chance = 1090 },
	{ name = "wooden spellbook", chance = 1050 },
	{ name = "lightning robe", chance = 780 },
	{ id = 23531, chance = 580 }, -- ring of green plasma
	{ name = "shockwave amulet", chance = 560 },
	{ name = "magma amulet", chance = 280 },
	{ name = "bottle of raubritter lager", chance = 110 },
	{ name = "crystal coin", chance = 50, minCount = 56, maxCount = 128 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 80, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -380, radius = 4, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -380, range = 1, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -380, radius = 3, effect = CONST_ME_HOLYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -380, radius = 3, effect = CONST_ME_BLOOD_RAIN, target = false },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	mitigation = 2.31,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -12 },
	{ type = COMBAT_FIREDAMAGE, percent = -6 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
