local mType = Game.createMonsterType("Zharvorin's Spirit")
local monster = {}

monster.description = "Zharvorin's Spirit"
monster.experience = 0
monster.outfit = {
	lookType = 1883,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 120000
monster.maxHealth = 120000
monster.race = "undead"
monster.corpse = 0
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70, -- não confirmado
	health = 10, -- não confirmado
	damage = 10, -- não confirmado
	random = 10, -- não confirmado
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
	staticAttackChance = 90, -- não confirmado
	targetDistance = 4, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.loot = {}

-- Ice Wave (900+), Ice Strike (1700+)
monster.attacks = {
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ICEDAMAGE, minDamage = -650, maxDamage = -900, length = 8, spread = 3, effect = CONST_ME_ICEAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -1200, maxDamage = -1700, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true }, -- não confirmado
}

monster.defenses = {
	defense = 75, -- não confirmado
	armor = 75, -- não confirmado
	mitigation = 2.30, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
