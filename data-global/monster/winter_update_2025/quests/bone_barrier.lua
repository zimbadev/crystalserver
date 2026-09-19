local mType = Game.createMonsterType("Bone Barrier")
local monster = {}

monster.description = "a bone barrier"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 6973,
}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "undead"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100, -- não confirmado
}

monster.flags = {
	summonable = false, -- não confirmado
	attackable = true, -- não confirmado
	hostile = false, -- não confirmado
	convinceable = false, -- não confirmado
	pushable = false, -- não confirmado
	rewardBoss = false, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = false, -- não confirmado
	canPushCreatures = false, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = true, -- não confirmado
	canWalkOnEnergy = true, -- não confirmado
	canWalkOnFire = true, -- não confirmado
	canWalkOnPoison = true, -- não confirmado
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.loot = {}

monster.attacks = {} -- não confirmado

monster.defenses = {
	defense = 100, -- não confirmado
	armor = 100, -- não confirmado
	mitigation = 3.00, -- não confirmado
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
