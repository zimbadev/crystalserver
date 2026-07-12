local mType = Game.createMonsterType("Raubritter Marksman")
local monster = {}

monster.name = "Raubritter Marksman"
monster.description = "a raubritter marksman"
monster.experience = 9025
monster.outfit = {
	lookType = 1901,
	lookHead = 94,
	lookBody = 19,
	lookLegs = 118,
	lookFeet = 2,
	lookAddons = 2,
	lookMount = 0,
}

monster.raceId = 2751
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

monster.health = 10500
monster.maxHealth = 10500
monster.race = "blood"
monster.corpse = 52688
monster.speed = 170
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
	targetDistance = 4,
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
	{ text = "Gnnnah!!!", yell = false },
	{ text = "I'll... hunt you... down!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 6, maxCount = 12 },
	{ name = "cuirass plate", chance = 5210 },
	{ name = "stag parchment", chance = 2490, maxCount = 2 },
	{ name = "blue crystal shard", chance = 1850 },
	{ name = "violet crystal shard", chance = 1840 },
	{ name = "green crystal shard", chance = 1770 },
	{ name = "terra mantle", chance = 850 },
	{ name = "green gem", chance = 820 },
	{ name = "blue gem", chance = 810 },
	{ id = 23529, chance = 520 }, -- ring of blue plasma
	{ name = "crystalline arrow", chance = 480, minCount = 10, maxCount = 20 },
	{ name = "composite hornbow", chance = 310 },
	{ name = "violet gem", chance = 210 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 80, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -450, range = 4, shootEffect = CONST_ANI_INFERNALBOLT, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_HOLYDAMAGE, minDamage = -350, maxDamage = -450, range = 4, shootEffect = CONST_ANI_BOLT, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -450, range = 4, shootEffect = CONST_ANI_VORTEXBOLT, effect = CONST_ME_DRAWBLOOD, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -450, range = 4, radius = 3, shootEffect = CONST_ANI_POWERBOLT, effect = CONST_ME_ENERGYAREA, target = true },
}

monster.defenses = {
	defense = 100,
	armor = 100,
	mitigation = 2.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -16 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 12 },
	{ type = COMBAT_EARTHDAMAGE, percent = -12 },
	{ type = COMBAT_FIREDAMAGE, percent = -12 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
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
