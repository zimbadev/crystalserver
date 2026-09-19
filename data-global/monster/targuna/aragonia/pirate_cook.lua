local mType = Game.createMonsterType("Pirate Cook")
local monster = {}

monster.description = "a pirate cook"
monster.experience = 105
monster.outfit = {
	lookType = 96,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2778
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

monster.health = 90
monster.maxHealth = 90
monster.race = "blood"
monster.corpse = 53113 -- corpse Targuna (appearances.dat)
monster.speed = 70
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
	targetDistance = 1,
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
	{ text = "Get in my pot!", yell = false },
}

monster.loot = {
	{ name = "health potion", chance = 30000 },
	{ name = "gold coin", chance = 50000, maxCount = 20 },
	{ name = "gold tooth", chance = 9000 },
	{ name = "light shovel", chance = 2500 },
	{ name = "rum flask", chance = 700 },
	{ name = "pirate knee breeches", chance = 700 },
	{ name = "eye patch", chance = 150 },
	{ name = "hook", chance = 150 },
	{ name = "peg leg", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -25 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -20, range = 1, effect = CONST_ME_ICEATTACK, target = true },
}

monster.defenses = {
	defense = 18,
	armor = 0,
	mitigation = 0.42,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
