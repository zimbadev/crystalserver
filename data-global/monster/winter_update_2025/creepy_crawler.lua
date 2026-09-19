local mType = Game.createMonsterType("Creepy Crawler")
local monster = {}

monster.description = "a creepy crawler"
monster.experience = 23000
monster.outfit = {
	lookType = 1890,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2763
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Unhallowed Crypt.",
}

monster.health = 27000
monster.maxHealth = 27000
monster.race = "undead"
monster.corpse = 52575
monster.speed = 260
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
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
}

monster.loot = {
	{ name = "crystal coin", chance = 39120 },
	{ name = "crystallized death", chance = 5190 },
	{ name = "giant tusk", chance = 5030 },
	{ name = "cyan crystal fragment", chance = 4380, maxCount = 4 },
	{ name = "blue crystal shard", chance = 3080, maxCount = 4 },
	{ name = "necromantic core", chance = 2270 },
	{ name = "amber", chance = 1790 },
	{ name = "cluster of crystallized death", chance = 970 },
	{ name = "blue gem", chance = 810, maxCount = 4 },
	{ name = "amber with a bug", chance = 650 },
	{ name = "amber with a dragonfly", chance = 650 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -380, maxDamage = -800, spread = 5, effect = CONST_ME_WHITE_ENERGYPULSE, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -1200, range = 1, effect = CONST_ME_BIG_SCRATCH, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -320, maxDamage = -1050, range = 7, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_SMALL_WHITE_ENERGYSHOCK, target = true },
}

monster.defenses = {
	defense = 100,
	armor = 100,
	mitigation = 4.11,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 6 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 12 },
	{ type = COMBAT_EARTHDAMAGE, percent = -12 },
	{ type = COMBAT_FIREDAMAGE, percent = -12 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 6 },
	{ type = COMBAT_HOLYDAMAGE, percent = -6 },
	{ type = COMBAT_DEATHDAMAGE, percent = 3 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
