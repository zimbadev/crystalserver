local mType = Game.createMonsterType("Ice Crawler")
local monster = {}

monster.description = "an ice crawler"
monster.experience = 0
monster.outfit = {
	lookType = 263,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 12000 -- não confirmado
monster.maxHealth = 12000 -- não confirmado
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
	summonable = false, -- não confirmado
	attackable = true, -- não confirmado
	hostile = true, -- não confirmado
	convinceable = false, -- não confirmado
	pushable = false, -- não confirmado
	rewardBoss = false, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = true, -- não confirmado
	canPushCreatures = true, -- não confirmado
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
	level = 0,
	color = 0,
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -400, maxDamage = -700, range = 5, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -800, radius = 4, effect = CONST_ME_ICEAREA, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 55, -- não confirmado
	armor = 55, -- não confirmado
	mitigation = 2.00, -- não confirmado
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
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
