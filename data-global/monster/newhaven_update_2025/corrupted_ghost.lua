local mType = Game.createMonsterType("Corrupted Ghost")
local monster = {}

monster.description = "a corrupted ghost"
monster.experience = 29
monster.outfit = {
	lookType = 48,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2708
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 250,
	FirstUnlock = 17,
	SecondUnlock = 175,
	CharmsPoints = 5,
	Stars = 1,
	Occurrence = 2,
	Locations = "Corrupted Mines, Yalahar Cemetery Quarter",
}

monster.health = 30
monster.maxHealth = 30
monster.race = "undead"
monster.corpse = 5993
monster.speed = 58
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "Vaia!", yell = true },
	{ text = "Swishh!", yell = true },
}

-- Loot based on statistics (1,449 kills, avg 19.59 gold)
monster.loot = {
	{ id = 3031, chance = 100000, maxCount = 14 }, -- gold coin (100%)
	{ id = 7618, chance = 21390 }, -- health potion (21.39%)
	{ id = 7620, chance = 20010 }, -- mana potion (20.01%)
	{ id = 3723, chance = 11530, maxCount = 2 }, -- white mushroom (11.53%)
	{ id = 2643, chance = 3040 }, -- cape (3.04%)
	{ id = 3178, chance = 1790, maxCount = 2 }, -- light stone shower rune (1.79%)
	{ id = 3174, chance = 1520, maxCount = 5 }, -- lightest missile rune (1.52%)
	{ id = 10319, chance = 140 }, -- ranger's cloak (0.14%)
	{ id = 3375, chance = 140 }, -- soldier helmet (0.14%)
	{ id = 3081, chance = 70 }, -- stone skin amulet (0.07%)
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -100 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -30, maxDamage = -60, range = 1, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -25, maxDamage = -55, range = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 8,
	armor = 0,
	mitigation = 0.03,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
