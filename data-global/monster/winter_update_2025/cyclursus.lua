local mType = Game.createMonsterType("Cyclursus")
local monster = {}

monster.description = "a cyclursus"
monster.experience = 13375
monster.outfit = {
	lookType = 1884,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2757
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Forsaken Crypt.",
}

monster.health = 13500
monster.maxHealth = 13500
monster.race = "undead"
monster.corpse = 52551
monster.speed = 200
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
	{ text = "Crrrrk!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 24010, minCount = 10, maxCount = 20 },
	{ name = "crystal coin", chance = 9820 },
	{ name = "cyan crystal fragment", chance = 5950, maxCount = 4 },
	{ name = "crystallized death", chance = 4070 },
	{ name = "small sapphire", chance = 3470, maxCount = 15 },
	{ name = "blue crystal shard", chance = 2380, maxCount = 4 },
	{ name = "deadly fangs", chance = 1090 },
	{ name = "crystal crossbow", chance = 890 },
	{ name = "blue gem", chance = 790, maxCount = 4 },
	{ name = "necromantic core", chance = 690 },
	{ name = "skull helmet", chance = 400 },
	{ name = "honeycomb", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -700 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -900, maxDamage = -1480, radius = 3, effect = CONST_ME_PINK_ENERGYPULSE, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -1480, range = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -900, maxDamage = -1480, range = 4, shootEffect = CONST_ANI_ENERGY, target = true },
}

monster.defenses = {
	defense = 95,
	armor = 95,
	mitigation = 3.19,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -3 },
	{ type = COMBAT_EARTHDAMAGE, percent = -3 },
	{ type = COMBAT_FIREDAMAGE, percent = -3 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -3 },
	{ type = COMBAT_HOLYDAMAGE, percent = -3 },
	{ type = COMBAT_DEATHDAMAGE, percent = -12 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
