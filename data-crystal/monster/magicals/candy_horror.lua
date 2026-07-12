local mType = Game.createMonsterType("Candy Horror")
local monster = {}

monster.description = "a candy horror"
monster.experience = 3000
monster.outfit = {
	lookType = 1739,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2535
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Chocolate Mines.",
}

monster.health = 3100
monster.maxHealth = 3100
monster.race = "chocolate"
monster.corpse = 48268
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "We will devour you ...", yell = false },
	{ text = "Wait for us, little treat ...", yell = false },
	{ text = "Horrraa!", yell = false },
}

monster.loot = {
	{ name = "Gold Coin", chance = 100000, maxCount = 30 },
	{ name = "Platinum Coin", chance = 81910, maxCount = 6 },
	{ id = 281, chance = 6419, maxCount = 1 },
	{ id = 3039, chance = 5510, maxCount = 1 },
	{ name = "Energy Bar", chance = 5309, maxCount = 1 },
	{ name = "Black Shield", chance = 2730, maxCount = 1 },
	{ name = "Gummy Rotworm", chance = 2530, maxCount = 2 },
	{ name = "Wand of Decay", chance = 1620, maxCount = 1 },
	{ id = 3591, chance = 1310, maxCount = 4 },
	{ name = "Brigadeiro", chance = 1160, maxCount = 1 },
	{ name = "Violet Gem", chance = 810, maxCount = 1 },
	{ name = "Dark Chocolate Coin", chance = 510, maxCount = 11 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -352 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = 0, maxDamage = -170, range = 1, effect = 215, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -400, radius = 4, effect = 270, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -252, range = 7, radius = 3, effect = 52, shootEffect = CONST_ANI_EARTH, target = true },
	{ name = "candy horror wave", interval = 2000, chance = 20, minDamage = 0, maxDamage = -352, target = false },
}

monster.defenses = {
	defense = 43,
	armor = 43,
	mitigation = 1.21,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 30, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, effect = CONST_ME_PIXIE_EXPLOSION, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, effect = CONST_ME_SOUND_WHITE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
