local mType = Game.createMonsterType("Corrupted Skeleton")
local monster = {}

monster.description = "a corrupted skeleton"
monster.experience = 34
monster.outfit = {
	lookType = 298,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2709
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Newhaven Crypts.",
}

monster.health = 45
monster.maxHealth = 45
monster.race = "undead"
monster.corpse = 5972
monster.speed = 65
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 5,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
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
	{ text = "Clatter!", yell = false },
	{ text = "Corrupted...", yell = false },
}

-- Loot based on statistics (1,408 kills, avg 9.5 gold)
monster.loot = {
	{ id = 3031, chance = 100000, maxCount = 15 }, -- gold coin (100%)
	{ id = 7618, chance = 26280 }, -- health potion (26.28%)
	{ id = 3723, chance = 15130, maxCount = 2 }, -- white mushroom (15.13%)
	{ id = 3337, chance = 4470 }, -- bone club (4.47%)
	{ id = 3115, chance = 2980 }, -- bone (2.98%)
	{ id = 3447, chance = 2340, maxCount = 14 }, -- simple arrow (2.34%)
	{ id = 3375, chance = 1140 }, -- soldier helmet (1.14%)
	{ id = 10319, chance = 210 }, -- ranger's cloak (0.21%)
	{ id = 8820, chance = 140 }, -- magician's robe (0.14%)
	{ id = 44771, chance = 70 }, -- plain monk robe (0.07%)
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -35 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -10, maxDamage = -20, range = 1, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -8, maxDamage = -18, range = 1, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 12,
	armor = 0,
	mitigation = 0.03,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
