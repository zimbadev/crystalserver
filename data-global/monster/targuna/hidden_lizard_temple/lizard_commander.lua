local mType = Game.createMonsterType("Lizard Commander")
local monster = {}

monster.description = "a lizard commander"
monster.experience = 240
monster.outfit = {
	lookType = 1930,
	lookHead = 117,
	lookBody = 6,
	lookLegs = 11,
	lookFeet = 79,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2785
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Targuna (Hidden Lizard Temple).",
}

monster.events = {
	"TargunaLizardCommanderDeath",
}

monster.health = 160
monster.maxHealth = 160
monster.race = "blood"
monster.corpse = 53090 -- corpse Targuna (appearances.dat)
monster.speed = 88
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
	{ name = "health potion", chance = 40000, maxCount = 2 },
	{ name = "mana potion", chance = 40000, maxCount = 2 },
	{ name = "gold coin", chance = 50000, maxCount = 40 },
	{ name = "dragon necklace", chance = 30000 },
	{ name = "scale armor", chance = 9000 },
	{ name = "lizard tail", chance = 9000 },
	{ name = "small emerald", chance = 2500, maxCount = 2 },
	{ name = "green dragon leather", chance = 700 },
	{ name = "lizard scale", chance = 700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -30 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -25, range = 1, effect = CONST_ME_GREEN_RINGS, target = true },
}

monster.defenses = {
	defense = 22,
	armor = 4,
	mitigation = 0.70,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
