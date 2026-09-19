local mType = Game.createMonsterType("Lizard Henchman")
local monster = {}

monster.description = "a lizard henchman"
monster.experience = 70
monster.outfit = {
	lookType = 1927,
	lookHead = 117,
	lookBody = 4,
	lookLegs = 56,
	lookFeet = 11,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2781
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 15,
	Stars = 1,
	Occurrence = 0,
	Locations = "Targuna (Hidden Lizard Temple).",
}

monster.health = 58
monster.maxHealth = 58
monster.race = "blood"
monster.corpse = 53078 -- corpse Targuna (appearances.dat)
monster.speed = 76
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 5,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Tssss!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 10 },
	{ name = "health potion", chance = 9000 },
	{ name = "spear", chance = 9000 },
	{ name = "arrow", chance = 9000, maxCount = 5 },
	{ name = "sail pass", chance = 9000 },
	{ id = 3457, chance = 2500 }, -- shovel
	{ name = "lizard tail", chance = 2500 },
	{ name = "lizard scale", chance = 700 },
	{ name = "lizard leather", chance = 700 },
	{ name = "sentinel shield", chance = 700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -15 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -10, range = 1, effect = CONST_ME_GREEN_RINGS, target = true },
}

monster.defenses = {
	defense = 10,
	armor = 2,
	mitigation = 0.30,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
