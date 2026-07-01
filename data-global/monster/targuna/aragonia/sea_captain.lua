local mType = Game.createMonsterType("Sea Captain")
local monster = {}

monster.description = "a sea captain"
monster.experience = 280
monster.outfit = {
	lookType = 98,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2780
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Targuna (Aragonia).",
}

monster.events = {
	"TargunaPirateDeath",
}

monster.health = 190
monster.maxHealth = 190
monster.race = "blood"
monster.corpse = 53119 -- corpse Targuna (appearances.dat)
monster.speed = 92
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
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I am the master of this ship!", yell = false },
}

monster.loot = {
	{ name = "health potion", chance = 40000, maxCount = 2 },
	{ name = "mana potion", chance = 40000, maxCount = 2 },
	{ name = "gold coin", chance = 50000, maxCount = 50 },
	{ name = "sabre", chance = 9000 },
	{ name = "gold tooth", chance = 9000 },
	{ name = "sailor's burn cure", chance = 2500 },
	{ name = "pirate boots", chance = 700 },
	{ name = "rum flask", chance = 700 },
	{ name = "pirate backpack", chance = 700 },
	{ name = "pirate bag", chance = 700 },
	{ name = "pirate hat", chance = 700 },
	{ name = "piggy bank", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -35 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_ICEDAMAGE, minDamage = 0, maxDamage = -25, range = 1, effect = CONST_ME_ICEATTACK, target = true },
}

monster.defenses = {
	defense = 24,
	armor = 4,
	mitigation = 0.72,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
