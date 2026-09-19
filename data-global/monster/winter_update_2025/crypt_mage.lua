local mType = Game.createMonsterType("Crypt Mage")
local monster = {}

monster.description = "a crypt mage"
monster.experience = 14700
monster.outfit = {
	lookType = 1905,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2766
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Forsaken Crypt.",
}

monster.health = 14000
monster.maxHealth = 14000
monster.race = "undead"
monster.corpse = 52563
monster.speed = 180
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
	canPushCreatures = true,
	staticAttackChance = 90,
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
	chance = 10,
	{ text = "Maaahhh!", yell = false },
	{ text = "Czchhh!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 23660, minCount = 10, maxCount = 20 },
	{ name = "crystal coin", chance = 11180 },
	{ name = "green crystal fragment", chance = 4090, maxCount = 4 },
	{ name = "green crystal shard", chance = 3440, maxCount = 4 },
	{ name = "skull staff", chance = 3230 },
	{ name = "small emerald", chance = 2580, maxCount = 15 },
	{ name = "crystallized death", chance = 2150 },
	{ name = "toe nails", chance = 1940 },
	{ name = "spellbook of mind control", chance = 860 },
	{ name = "cryptic fossil", chance = 650 },
	{ name = "green gem", chance = 650, maxCount = 3 },
	{ name = "necromantic core", chance = 650 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 30, minDamage = -100, maxDamage = -700 },
	{ name = "Crypt X", interval = 2000, chance = 20, minDamage = -350, maxDamage = -1050, target = false },
	{ name = "Energy Cruz", interval = 2000, chance = 20, minDamage = -300, maxDamage = -1200, target = false },
	{ name = "Wave Death Crypt", interval = 2000, chance = 15, minDamage = -1000, maxDamage = -1700, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -900, maxDamage = -1480, radius = 3, effect = CONST_ME_GREEN_ENERGYPULSE, target = false },
}

monster.defenses = {
	defense = 105,
	armor = 105,
	mitigation = 3.04,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
