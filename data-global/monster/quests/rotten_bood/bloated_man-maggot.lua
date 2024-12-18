local mType = Game.createMonsterType("Bloated Man-Maggot")
local monster = {}

monster.description = "a bloated man-maggot"
monster.experience = 21570
monster.outfit = {
	lookType = 1654,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2392
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_HUMANOID,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 2,
	Locations = "Jaded Roots",
}

monster.health = 31700
monster.maxHealth = 31700
monster.race = "venom"
monster.corpse = 43816
monster.speed = 195
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
	staticAttackChance = 80,
	targetDistance = 4,
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
	chance = 30,
}

monster.loot = {
	{ name = "crystal coin", chance = 12961, maxCount = 1 },
	{ name = "organic acid", chance = 11678, maxCount = 1 },
	{ name = "might ring", chance = 10020, maxCount = 1 },
	{ name = "small emerald", chance = 9133, maxCount = 5 },
	{ name = "rotten roots", chance = 8637, maxCount = 1 },
	{ name = "bloated maggot", chance = 8133, maxCount = 1 },
	{ name = "terra rod", chance = 8078, maxCount = 1 },
	{ name = "butcher's axe", chance = 7967, maxCount = 1 },
	{ name = "blue gem", chance = 7808, maxCount = 1 },
	{ name = "violet gem", chance = 7084, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -1400, maxDamage = -1700, radius = 5, effect = CONST_ME_GHOSTLY_BITE, target = true },
	{ name = "combat", interval = 2500, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -1400, maxDamage = -1900, radius = 5, effect = CONST_ME_BIGPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1400, maxDamage = -1550, length = 8, spread = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "largefirering", interval = 2500, chance = 15, minDamage = -1400, maxDamage = -1800, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 104,
	mitigation = 3.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 55 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = 85 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
