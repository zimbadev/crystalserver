local mType = Game.createMonsterType("Crypt Construct")
local monster = {}

monster.description = "a crypt construct"
monster.experience = 20500
monster.outfit = {
	lookType = 1887,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2760
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Forgotten Crypt, Outer Crypt.",
}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "undead"
monster.corpse = 52563
monster.speed = 240
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
	{ name = "crystal coin", chance = 41980 },
	{ name = "cyan crystal fragment", chance = 7390, maxCount = 4 },
	{ name = "blue crystal shard", chance = 5700, maxCount = 4 },
	{ name = "small sapphire", chance = 5210, maxCount = 15 },
	{ name = "crystallized death", chance = 4390 },
	{ name = "toe nails", chance = 2750 },
	{ name = "cluster of crystallized death", chance = 1750 },
	{ name = "blue gem", chance = 1460, maxCount = 4 },
	{ name = "amber", chance = 1090 },
	{ name = "amber staff", chance = 710 },
	{ name = "amber with a bug", chance = 490 },
	{ name = "amber with a dragonfly", chance = 180 },
	{ name = "fetid heart", chance = 160 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -800 },
	{ name = "Crypt Construct Wave", interval = 2000, chance = 30, minDamage = -1000, maxDamage = -1700, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -900, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -900, range = 7, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_SMALL_WHITE_ENERGYSHOCK, target = true },
}

monster.defenses = {
	defense = 100,
	armor = 100,
	mitigation = 3.34,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -6 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 18 },
	{ type = COMBAT_EARTHDAMAGE, percent = -9 },
	{ type = COMBAT_FIREDAMAGE, percent = -6 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 12 },
	{ type = COMBAT_HOLYDAMAGE, percent = 8 },
	{ type = COMBAT_DEATHDAMAGE, percent = 8 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
