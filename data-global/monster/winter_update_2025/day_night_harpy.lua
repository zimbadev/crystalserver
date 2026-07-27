local mType = Game.createMonsterType("Day Night Harpy")
local monster = {}

monster.name = "Night Harpy"
monster.description = "a night harpy"
monster.experience = 21000
monster.outfit = {
	lookType = 1899,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2764
monster.Bestiary = {
	class = "Bird",
	race = BESTY_RACE_BIRD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 2,
	Locations = "Arean Outskirts, Isle of Ada, Stag Bastion",
}

monster.health = 14000
monster.maxHealth = 14000
monster.race = "blood"
monster.corpse = 52680
monster.speed = 190
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
	targetDistance = 3,
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
	{ text = "WHEEE!!! WHEEE!!!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 70, minCount = 100 },
	{ name = "strong mana potion", chance = 9090, minCount = 8, maxCount = 12 },
	{ id = 238, chance = 10630, minCount = 8, maxCount = 12 }, -- great mana potion
	{ name = "great spirit potion", chance = 9840, minCount = 4, maxCount = 8 },
	{ name = "giant ruby", chance = 220, maxCount = 1 },
	{ name = "giant emerald", chance = 130, maxCount = 1 },
	{ name = "giant topaz", chance = 130, maxCount = 1 },
	{ name = "giant topaz", chance = 130, maxCount = 1 },
	{ name = "night harpy feathers", chance = 570, minCount = 5, maxCount = 10 },
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 1000, type = COMBAT_DEATHDAMAGE, minDamage = -0, maxDamage = -350, range = 5, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2200, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -850, maxDamage = -930, radius = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "deathcircle", interval = 2500, chance = 25 },
	{ name = "night harpy shielding ball", interval = 5000, chance = 25 },
	{ name = "night harpy cone wave", interval = 2000, chance = 23, minDamage = -570, maxDamage = -870 },
	{ name = "combat", interval = 2000, chance = 27, type = COMBAT_DEATHDAMAGE, minDamage = -610, maxDamage = -810, range = 5, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "night harpy scratch", interval = 2000, chance = 25, minDamage = -700, maxDamage = -890 },
}

monster.defenses = {
	defense = 90,
	armor = 90,
	mitigation = 2.45,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -12 },
	{ type = COMBAT_HOLYDAMAGE, percent = -9 },
	{ type = COMBAT_DEATHDAMAGE, percent = -9 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
