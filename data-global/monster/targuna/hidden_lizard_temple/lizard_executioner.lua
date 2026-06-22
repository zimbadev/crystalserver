local mType = Game.createMonsterType("Lizard Executioner")
local monster = {}

monster.description = "a lizard executioner"
monster.experience = 90
monster.outfit = {
	lookType = 1929,
	lookHead = 114,
	lookBody = 57,
	lookLegs = 75,
	lookFeet = 75,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2784
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

monster.health = 74
monster.maxHealth = 74
monster.race = "blood"
monster.corpse = 53094 -- corpse Targuna (appearances.dat)
monster.speed = 82
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
	{ name = "gold coin", chance = 50000, maxCount = 18 },
	{ name = "health potion", chance = 9000 },
	{ name = "lizard tail", chance = 9000 },
	{ name = "lizard scale", chance = 700 },
	{ name = "lizard leather", chance = 700 },
	{ name = "mace", chance = 700 },
	{ name = "salamander shield", chance = 700 },
	{ name = "templar scytheblade", chance = 700 },
	{ name = "hatchet", chance = 700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -25 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -25, range = 1, effect = CONST_ME_GREEN_RINGS, target = true },
}

monster.defenses = {
	defense = 16,
	armor = 3,
	mitigation = 0.40,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
