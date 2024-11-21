local mType = Game.createMonsterType("Sopping Carcass")
local monster = {}

monster.description = "a sopping carcass"
monster.experience = 23425
monster.outfit = {
	lookType = 1658,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2396
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
    toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 2,
	Locations = "Putrefactory",
}

monster.health = 32700
monster.maxHealth = 32700
monster.race = "venom"
monster.corpse = 43832
monster.speed = 210
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 60,
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
	{ name = "crystal coin", chance = 90000 },
	{ name = "soul orb", chance = 9500, maxCount = 3 },
	{ name = "lichen gobbler", chance = 3500 },
	{ name = "decayed finger bone", chance = 4500, maxCount = 6 },
	{ name = "rotten roots", chance = 3500, maxCount = 8 },
	{ name = "yellow gem", chance = 7250 },
	{ name = "underworld rod", chance = 4250 },
	{ id = 3039, chance = 9220 }, -- red gem
	{ name = "ripper lance", chance = 14250 },
	{ name = "ultimate health potion", chance = 22860, maxCount = 5 },
	{ name = "gold ingot", chance = 3860 },
	{ name = "cyan crystal fragment", chance = 4430 },
	{ name = "red crystal fragment", chance = 1430 },
	{ name = "blue crystal shard", chance = 710 },
	{ name = "small diamond", chance = 4570 },
	{ name = "mercenary sword", chance = 2860 },
	{ name = "onyx chip", chance = 2860 },
	{ name = "giant sword", chance = 658 },
	{ name = "magma boots", chance = 865 },
	{ name = "might ring", chance = 570 },
	{ id = 23531, chance = 930 }, -- ring of green plasma
	{ name = "metal bat", chance = 760 },
	{ name = "diabolic skull", chance = 590 },
	{ name = "fire axe", chance = 590 },
	{ id = 43895, chance = 20 } -- bag you covet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1450 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -1150, maxDamage = -1400, range = 7, shootEffect = CONST_ME_GREEN_RINGS, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -800, maxDamage = -1250, length = 8, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -1000, maxDamage = -1350, radius = 4, effect = CONST_ME_POISONAREA, target = false },
	{ name = "death chain", interval = 2000, chance = 20, minDamage = -1100, maxDamage = -1380, target = true },
}

monster.defenses = {
	defense = 60,
	armor = 112,
	mitigation = 3.25
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 35 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 60 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)

