local mType = Game.createMonsterType("Sopping Corpus")
local monster = {}

monster.description = "a sopping corpus"
monster.experience = 22465
monster.outfit = {
	lookType = 1659,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2397
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_HUMANOID,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 2,
	Locations = "Jaded Roots",
}

monster.health = 33400
monster.maxHealth = 33400
monster.race = "venom"
monster.corpse = 43836
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
	{ name = "crystal coin", chance = 35200 },
	{ name = "ultimate mana potion", chance = 13921, maxCount = 3 },
	{ id = 7385, chance = 17375 }, -- crimson sword
	{ name = "ultimate health potion", chance = 8375, maxCount = 3 },
	{ name = "organic acid", chance = 3458, maxCount = 2 },
	{ name = "rotten roots", chance = 3375, maxCount = 2 },
	{ name = "emerald bangle", chance = 4319 },
	{ name = "underworld rod", chance = 5889 },
	{ name = "violet gem", chance = 4989 },
	{ name = "blue gem", chance = 6189 },
	{ name = "relic sword", chance = 3439 },
	{ name = "skullcracker armor", chance = 7439 },
	{ name = "gold ingot", chance = 18860 },
	{ name = "blue crystal shard", chance = 5710 },
	{ name = "small diamond", chance = 4570 },
	{ name = "green crystal fragment", chance = 3430 },
	{ name = "magma amulet", chance = 3430 },
	{ name = "onyx chip", chance = 2860 },
	{ name = "giant sword", chance = 356 },
	{ name = "magma boots", chance = 125 },
	{ name = "might ring", chance = 570 },
	{ id = 23531, chance = 930 }, -- ring of green plasma
	{ name = "metal bat", chance = 760 },
	{ name = "diabolic skull", chance = 590 },
	{ name = "fire axe", chance = 590 },
	{ id = 23531, chance = 5119 }, -- ring of green plasma
	{ id = 43895, chance = 20 }, -- bag you covet
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
	mitigation = 3.25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)

