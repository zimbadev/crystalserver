local mType = Game.createMonsterType("Broodrider Inferniarch")
local monster = {}

monster.description = "a broodrider inferniarch"
monster.experience = 7850
monster.outfit = {
	lookType = 1796,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2603
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Azzilon Castle.",
}

monster.health = 9600
monster.maxHealth = 9600
monster.race = "undead"
monster.corpse = 50006
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	canPushCreatures = false,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyable = true,
	isPreyExclusive = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Mah...Hun Hur...!", yell = true },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 26500, maxCount = 40 },
	{ name = "Demonic Core Essence", chance = 1000, maxCount = 1 },
	{ name = "Blue Crystal Splinter", chance = 24500, maxCount = 2 },
	{ name = "Mummified Demon Finger", chance = 500, maxCount = 1 },
	{ name = "Demonic Matter", chance = 1000, maxCount = 1 },
	{ name = "Magma Legs", chance = 2000, maxCount = 1 },
	{ name = "Arbalest", chance = 1500, maxCount = 1 },
	{ name = "Drill Bolt", chance = 24500, maxCount = 25 },
	{ name = "Power Bolt", chance = 24500, maxCount = 35 },
	{ name = "Onyx Chip", chance = 24500, maxCount = 5 },
	{ name = "Broodrider Saddle", chance = 24500, maxCount = 1 },
	{ name = "broodrider inferniarch soul core", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 250, maxDamage = -400 },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -470, range = 1, effect = CONST_ME_BITE, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -340, maxDamage = -370, range = 7, shootEffect = CONST_ANI_INFERNALBOLT, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 70,
	armor = 70,
	mitigation = 2.05,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
