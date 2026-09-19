local mType = Game.createMonsterType("The Corruptor")
local monster = {}

monster.description = "The Corruptor"
monster.experience = 170
monster.outfit = {
	lookType = 233,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 100
monster.maxHealth = 100
monster.race = "undead"
monster.corpse = 52113
monster.speed = 25
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15,
}

monster.strategiesTarget = {
	nearest = 60,
	health = 20,
	damage = 20,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
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
	{ text = "Let me corrupt you!", yell = false },
	{ text = "Glonk!", yell = false },
}

-- Loot based on statistics (21 kills, avg 88.57 gold)
monster.loot = {
	{ id = 3031, chance = 100000, minCount = 13, maxCount = 46 }, -- gold coin (100%)
	{ id = 7618, chance = 23810, minCount = 1, maxCount = 3 }, -- health potion (23.81%)
	{ id = 7620, chance = 23810, minCount = 1, maxCount = 3 }, -- mana potion (23.81%)
	{ id = 3338, chance = 14290 }, -- bone sword (14.29%)
	{ id = 3359, chance = 4760 }, -- brass armor (4.76%)
	{ id = 8820, chance = 4760 }, -- magician's robe (4.76%)
	{ id = 3375, chance = 4760 }, -- soldier helmet (4.76%)
	{ id = 3074, chance = 4760 }, -- wand of vortex (4.76%)
	{ id = 3723, chance = 4760, maxCount = 2 }, -- white mushroom (4.76%)
	{ id = 44773, chance = 4760 }, -- refined bow (4.76%)
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -5, maxDamage = -15 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -5, maxDamage = -15, range = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -5, maxDamage = -10, length = 4, spread = 0, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 10,
	armor = 0,
	mitigation = 0.03,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
