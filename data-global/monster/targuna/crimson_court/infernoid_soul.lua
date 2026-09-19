local mType = Game.createMonsterType("Infernoid Soul")
local monster = {}

monster.description = "an infernoid soul"
monster.experience = 115
monster.outfit = {
	lookType = 242,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2788
monster.Bestiary = {
	class = "Elemental", -- confirmar classe oficial (Elemental/Demon)
	race = BESTY_RACE_ELEMENTAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 15,
	Stars = 1,
	Occurrence = 0,
	Locations = "Targuna (Crimson Court).",
}

monster.health = 95
monster.maxHealth = 95
monster.race = "fire"
monster.corpse = 53125 -- corpse Targuna (appearances.dat)
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 5,
	color = 199,
}

monster.loot = {
	{ name = "gold coin", chance = 50000, maxCount = 20 },
	{ name = "mana potion", chance = 30000 },
	{ id = 3449, chance = 30000, maxCount = 5 }, -- burst arrow
	{ name = "infernoid ember", chance = 9000 },
	{ id = 2920, chance = 2500 }, -- torch
	{ name = "fire mushroom", chance = 2500 },
	{ id = 12600, chance = 700 }, -- coal
	{ name = "might ring", chance = 150 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -25 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -20, range = 1, effect = CONST_ME_HITBYFIRE, target = true },
}

monster.defenses = {
	defense = 14,
	armor = 2,
	mitigation = 0.40,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
