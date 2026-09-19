local mType = Game.createMonsterType("Tamed Frazzlemaw")
local monster = {}

monster.description = "a tamed frazzlemaw"
monster.experience = 0
monster.outfit = {
	lookType = 594,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1000
monster.maxHealth = 1000
monster.race = "blood"
monster.corpse = 0
monster.speed = 165 -- não confirmado
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true, -- não confirmado
	canWalkOnFire = true, -- não confirmado
	canWalkOnPoison = true, -- não confirmado
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -900, radius = 4, effect = CONST_ME_HITAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -700, range = 1, effect = CONST_ME_DRAWBLOOD, target = true }, -- não confirmado
}

monster.defenses = {
	defense = 90, -- não confirmado
	armor = 90, -- não confirmado
	mitigation = 2.60, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true }, -- não confirmado
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true }, -- não confirmado
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
