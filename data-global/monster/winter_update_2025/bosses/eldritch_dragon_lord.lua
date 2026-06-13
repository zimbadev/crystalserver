local mType = Game.createMonsterType("Eldritch Dragon Lord")
local monster = {}

monster.description = "an eldritch dragon lord"
monster.experience = 750000
monster.outfit = {
	lookType = 1879,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2739,
	bossRace = RARITY_ARCHFOE,
	storageCooldown = 82071, -- não confirmado
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "blood"
monster.corpse = 44828 -- não confirmado
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000, -- não confirmado
	chance = 20, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 60, -- não confirmado
	health = 20, -- não confirmado
	damage = 10, -- não confirmado
	random = 10, -- não confirmado
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false, -- não confirmado
	canPushItems = true,
	canPushCreatures = true, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1,
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

monster.summon = {
	maxSummons = 3, -- não confirmado
	summons = {
		{ name = "Eruption", chance = 12, interval = 4000, count = 2 }, -- não confirmado
		{ name = "Flame Totem", chance = 10, interval = 5000, count = 1 }, -- não confirmado
	},
}

monster.voices = {
	interval = 5000,
	chance = 12,
	{ text = "THIS HOARD IS MINE NOW!", yell = true },
	{ text = "ALL MIIINE!", yell = true },
	{ text = "RISE UP MY COMPANIONS!!!", yell = true },
	{ text = "RISE UP MY FELLOWS!!!", yell = true },
	{ text = "THIEFS!", yell = true },
}

monster.loot = {
	{ name = "crystal coin", chance = 100000, maxCount = 61 },
	{ name = "dragon ham", chance = 50000, maxCount = 4 }, -- não confirmado
	{ name = "strong mana potion", chance = 54550, maxCount = 93 }, -- não confirmado
	{ name = "great mana potion", chance = 54550, maxCount = 69 },
	{ name = "great spirit potion", chance = 54550, maxCount = 57 },
	{ name = "ultimate mana potion", chance = 45450, maxCount = 24 },
	{ name = "ultimate spirit potion", chance = 63640, maxCount = 25 },
	{ name = "ultimate health potion", chance = 54550, maxCount = 37 },
	{ name = "supreme health potion", chance = 54550, maxCount = 18 },
	{ id = 3039, chance = 36360, maxCount = 9 }, -- red gem
	{ name = "yellow gem", chance = 27270, maxCount = 8 },
	{ name = "blue gem", chance = 18180, maxCount = 3 },
	{ name = "giant ruby", chance = 9090, maxCount = 2 },
	{ name = "giant amethyst", chance = 9090 }, -- não confirmado
	{ name = "giant emerald", chance = 9090 },
	{ name = "guardian gem", chance = 5000 }, -- não confirmado
	{ name = "marksman gem", chance = 5000 }, -- não confirmado
	{ name = "mystic gem", chance = 5000 }, -- não confirmado
	{ name = "sage gem", chance = 5000 }, -- não confirmado
	{ name = "spiritualist gem", chance = 5000 }, -- não confirmado
	{ name = "greater guardian gem", chance = 3000 }, -- não confirmado
	{ name = "greater marksman gem", chance = 3000 }, -- não confirmado
	{ name = "greater mystic gem", chance = 3000 }, -- não confirmado
	{ name = "greater sage gem", chance = 3000 }, -- não confirmado
	{ name = "greater spiritualist gem", chance = 3000 }, -- não confirmado
	{ name = "dragon tongue", chance = 10000 }, -- não confirmado
	{ name = "golden claw", chance = 5000 }, -- não confirmado
	{ name = "cryptic fossil", chance = 5000 }, -- não confirmado
	{ name = "fetid heart", chance = 5000 }, -- não confirmado
	{ name = "dragonbone staff", chance = 5000 }, -- não confirmado
	{ name = "dragon shield", chance = 5000 }, -- não confirmado
	{ name = "wand of inferno", chance = 5000 }, -- não confirmado
	{ name = "fire sword", chance = 5000 }, -- não confirmado
	{ name = "dragon slayer", chance = 27270 }, -- não confirmado
	{ name = "fiery crypt rune", chance = 100000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1400 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 28, type = COMBAT_FIREDAMAGE, minDamage = -1000, maxDamage = -1800, length = 10, spread = 3, effect = CONST_ME_FIREAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 24, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = -1500, radius = 6, effect = CONST_ME_PURPLEENERGY, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1600, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true }, -- não confirmado
	{ name = "combat", interval = 2800, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -1300, length = 8, spread = 2, effect = CONST_ME_ENERGYHIT, target = false }, -- não confirmado
	{ name = "combat", interval = 3500, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -1100, maxDamage = -2000, radius = 7, effect = CONST_ME_EXPLOSIONAREA, target = false }, -- não confirmado
	{ name = "condition", type = CONDITION_FIRE, interval = 4000, chance = 12, minDamage = -300, maxDamage = -500, radius = 5, effect = CONST_ME_HITBYFIRE, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 95, -- não confirmado
	armor = 95, -- não confirmado
	mitigation = 3.20, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
	{ name = "speed", interval = 5000, chance = 10, speedChange = 400, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000 }, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }, -- não confirmado
}

mType:register(monster)
