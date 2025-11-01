local mType = Game.createMonsterType("Vampiric Essence")
local monster = {}

monster.description = "a vampiric essence"
monster.experience = 0
monster.outfit = {
	lookType = 1841,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 20000
monster.maxHealth = 20000
monster.race = "undead"
monster.corpse = 51595 -- Transforms to 51594 93 92 0
monster.speed = 200
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
	staticAttackChance = 90,
	targetDistance = 1,
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
}

-- no loot
monster.loot = {}

-- Unknown attacks
monster.attacks = {
	-- { name = "melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -750 },
	-- { name = "combat", interval = 2000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -1100, maxDamage = -1400, range = 7, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_HOLYAREA, target = true },
	-- { name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -900, maxDamage = -1300, radius = 5, effect = CONST_ME_BIGPLANTS, target = false },
	-- --{ name = "energy chain rotten", interval = 2000, chance = 6, minDamage = -1050, maxDamage = -1300, radius = 7, effect = CONST_ME_BIGPLANTS, target = false },
	-- { name = "root", interval = 2000, chance = 2, target = true },
}

monster.defenses = {
	defense = 108,
	armor = 108,
	mitigation = 3.04,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
