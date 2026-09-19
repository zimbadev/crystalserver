local mType = Game.createMonsterType("Poisoned Raubritter")
local monster = {}

monster.name = "Poisoned Raubritter"
monster.description = "a poisoned raubritter"
monster.experience = 0
monster.outfit = {
	lookType = 1902,
	lookHead = 82,
	lookBody = 120,
	lookLegs = 102,
	lookFeet = 120,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 35000
monster.maxHealth = 35000
monster.race = "undead"
monster.corpse = 0
monster.speed = 150
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

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 200, maxDamage = -1000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -1200, target = false, radius = 3, effect = CONST_ME_GREEN_RINGS },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -1200, range = 7, radius = 3, effect = CONST_ME_CARNIPHILA, shootEffect = CONST_ANI_EARTHARROW, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -600, maxDamage = -1000, range = 7, radius = 1, effect = CONST_ME_BIGPLANTS, shootEffect = CONST_ANI_EARTH, target = true },
	{ name = "poison chain", interval = 2000, chance = 15, minDamage = -600, maxDamage = -1500 },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	mitigation = 2.31,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
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
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
