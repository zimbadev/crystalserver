local mType = Game.createMonsterType("Enthralled Dragon")
local monster = {}

monster.description = "an enthralled dragon"
monster.experience = 0
monster.outfit = {
	lookType = 231,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 40000 -- não confirmado
monster.maxHealth = 40000 -- não confirmado
monster.race = "blood"
monster.corpse = 0
monster.speed = 160 -- não confirmado
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
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -1200, length = 8, spread = 3, effect = CONST_ME_FIREATTACK, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1000, radius = 5, effect = CONST_ME_FIREAREA, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 70, -- não confirmado
	armor = 70, -- não confirmado
	mitigation = 2.50, -- não confirmado
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
