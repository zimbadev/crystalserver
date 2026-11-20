local mType = Game.createMonsterType("True Frostnight Asura")
local monster = {}

monster.description = "a true frostnight asura"
monster.experience = 9500
monster.outfit = {
	lookType = 1068,
	lookHead = 9,
	lookBody = 95,
	lookLegs = 86,
	lookFeet = 95,
	lookAddons = 1,
	lookMount = 0,
}

monster.health = 12500
monster.maxHealth = 12500
monster.race = "blood"
monster.corpse = 0
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
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
	{ text = "The cold darkness shall consume you!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -450, maxDamage = -950, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -850, length = 6, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -350, radius = 3, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.defenses = {
	defense = 85,
	armor = 80,
	mitigation = 2.40,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
