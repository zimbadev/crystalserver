local mType = Game.createMonsterType("Fatal Bug")
local monster = {}

monster.description = "a fatal bug"
monster.experience = 668000
monster.outfit = {
	lookType = 79,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 250000
monster.maxHealth = 250000
monster.race = "venom"
monster.corpse = 0
monster.speed = 130 -- não confirmado
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
	pushable = false,
	rewardBoss = false, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = true,
	canPushCreatures = true, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.voices = {
	interval = 5000, -- não confirmado
	chance = 10, -- não confirmado
	{ text = "BZZT", yell = false },
	{ text = "BRRRRMM", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 100000, maxCount = 64 }, -- não confirmado (chance)
	{ name = "yellow gem", chance = 100000, maxCount = 10 }, -- não confirmado (chance)
	{ id = 3039, chance = 100000, maxCount = 10 }, -- red gem (não confirmado (chance))
	{ name = "blue gem", chance = 100000, maxCount = 2 }, -- não confirmado (chance)
	{ name = "giant amethyst", chance = 100000 }, -- não confirmado (chance)
	{ name = "giant sapphire", chance = 100000, maxCount = 3 }, -- não confirmado (chance)
	{ name = "strong mana potion", chance = 100000, maxCount = 92 }, -- não confirmado (chance)
	{ name = "great mana potion", chance = 100000, maxCount = 67 }, -- não confirmado (chance)
	{ name = "great spirit potion", chance = 100000, maxCount = 56 }, -- não confirmado (chance)
	{ name = "ultimate mana potion", chance = 100000, maxCount = 25 }, -- não confirmado (chance)
	{ name = "ultimate spirit potion", chance = 100000, maxCount = 25 }, -- não confirmado (chance)
	{ name = "ultimate health potion", chance = 100000, maxCount = 35 }, -- não confirmado (chance)
	{ name = "supreme health potion", chance = 100000, maxCount = 11 }, -- não confirmado (chance)
	{ name = "guardian gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "marksman gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "mystic gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "sage gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "spiritualist gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater guardian gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater marksman gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater mystic gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater sage gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater spiritualist gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "berserk potion", chance = 100000 }, -- não confirmado (chance)
	{ name = "bullseye potion", chance = 100000 }, -- não confirmado (chance)
	{ name = "transcendence potion", chance = 100000 }, -- não confirmado (chance)
	{ name = "cryptic fossil", chance = 100000 }, -- não confirmado (chance)
	{ name = "fetid heart", chance = 100000 }, -- não confirmado (chance)
	{ name = "wand of everblazing", chance = 100000 }, -- não confirmado (chance)
	{ name = "composite hornbow", chance = 100000 }, -- não confirmado (chance)
	{ name = "muck rod", chance = 100000 }, -- não confirmado (chance)
	{ name = "worn guide book", chance = 100000 }, -- não confirmado (chance)
	{ name = "ancient crypt rune", chance = 100000 }, -- não confirmado (chance)
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -500, range = 5, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -600, radius = 3, effect = CONST_ME_GREEN_RINGS, target = false }, -- não confirmado
	{ name = "condition", interval = 2000, chance = 15, type = CONDITION_POISON, totalDamage = 200, effect = CONST_ME_HITBYPOISON, target = true }, -- não confirmado
}

monster.defenses = {
	defense = 40, -- não confirmado
	armor = 40, -- não confirmado
	mitigation = 1.50, -- não confirmado
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
