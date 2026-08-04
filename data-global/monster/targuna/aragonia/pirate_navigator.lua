local mType = Game.createMonsterType("Pirate Navigator")
local monster = {}

monster.description = "a pirate navigator"
monster.experience = 75
monster.outfit = {
	lookType = 93,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2776
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 15,
	Stars = 1,
	Occurrence = 0,
	Locations = "Targuna (Aragonia).",
}

monster.events = {
	"TargunaPirateDeath",
}

monster.health = 64
monster.maxHealth = 64
monster.race = "blood"
monster.corpse = 53098 -- corpse Targuna (appearances.dat)
monster.speed = 77
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Set the course!", yell = false },
}

monster.loot = {
	{ name = "mana potion", chance = 30000 },
	{ name = "gold coin", chance = 50000, maxCount = 15 },
	{ name = "arrow", chance = 9000, maxCount = 5 },
	{ name = "sail pass", chance = 9000 },
	{ id = 3003, chance = 2500 }, -- rope
	{ name = "spear", chance = 2500 },
	{ name = "gold tooth", chance = 2500 },
	{ name = "bandana", chance = 700 },
	{ name = "empty goldfish bowl", chance = 700 },
	{ name = "eye patch", chance = 150 },
	{ name = "hook", chance = 150 },
	{ name = "peg leg", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -22 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -13, range = 1, effect = CONST_ME_ICEATTACK, target = true },
}

monster.defenses = {
	defense = 12,
	armor = 2,
	mitigation = 0.32,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
