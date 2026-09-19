local mType = Game.createMonsterType("Pirate Gunner")
local monster = {}

monster.description = "a pirate gunner"
monster.experience = 80
monster.outfit = {
	lookType = 97,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2777
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

monster.health = 68
monster.maxHealth = 68
monster.race = "blood"
monster.corpse = 53110 -- corpse Targuna (appearances.dat)
monster.speed = 75
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
	{ text = "Fire!", yell = false },
}

monster.loot = {
	{ name = "health potion", chance = 30000 },
	{ name = "gold coin", chance = 50000, maxCount = 15 },
	{ name = "throwing knife", chance = 9000, maxCount = 3 },
	{ name = "sabre", chance = 2500 },
	{ name = "gold tooth", chance = 2500 },
	{ id = 2920, chance = 700 }, -- torch
	{ name = "pirate shirt", chance = 700 },
	{ name = "eye patch", chance = 150 },
	{ name = "hook", chance = 150 },
	{ name = "peg leg", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -25 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -25, range = 7, shootEffect = CONST_ANI_THROWINGKNIFE, target = true },
}

monster.defenses = {
	defense = 12,
	armor = 2,
	mitigation = 0.34,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
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
