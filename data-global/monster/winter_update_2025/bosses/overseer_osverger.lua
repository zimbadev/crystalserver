local mType = Game.createMonsterType("Overseer Osverger")
local monster = {}

monster.description = "Overseer Osverger"
monster.experience = 75000
monster.outfit = {
	lookType = 1902,
	lookHead = 114,
	lookBody = 76,
	lookLegs = 57,
	lookFeet = 57,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2756,
	bossRace = RARITY_BANE,
}

monster.health = 75000
monster.maxHealth = 75000
monster.race = "blood"
monster.corpse = 52861
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000, -- não confirmado
	chance = 15, -- não confirmado
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
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.summon = {
	maxSummons = 2, -- não confirmado
	summons = {
		{ name = "Raubritter", chance = 15, interval = 6000, count = 2 }, -- não confirmado
	},
}

monster.voices = {
	interval = 5000, -- não confirmado
	chance = 10, -- não confirmado
	{ text = "Raubritters, to me!", yell = true }, -- não confirmado
	{ text = "You will not disrupt my operations!", yell = false }, -- não confirmado
	{ text = "I oversee your destruction!", yell = true }, -- não confirmado
	{ text = "Fall in line or fall in battle!", yell = false }, -- não confirmado
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "yellow gem", chance = 36670 },
	{ id = 3039, chance = 30000 }, -- red gem
	{ name = "battle tactics", chance = 28330 },
	{ name = "crystal coin", chance = 25830, maxCount = 10 },
	{ name = "small sapphire", chance = 24170, maxCount = 5 },
	{ name = "dark armor", chance = 22500 },
	{ name = "small diamond", chance = 20000, maxCount = 5 },
	{ name = "small ruby", chance = 20000, maxCount = 5 },
	{ name = "white pearl", chance = 16670 },
	{ name = "black pearl", chance = 14170 },
	{ name = "repair kit for boats", chance = 14170 },
	{ name = "stag parchment", chance = 14170 },
	{ name = "blue gem", chance = 11670 },
	{ name = "green gem", chance = 11670 },
	{ id = 6299, chance = 10000 }, -- death ring
	{ name = "silver poniard", chance = 9170 },
	{ name = "wand of cosmic energy", chance = 9170 },
	{ name = "white gem", chance = 7500 },
	{ id = 3059, chance = 6670 }, -- spellbook
	{ name = "gold ingot", chance = 5000 },
	{ name = "strange helmet", chance = 5000 },
	{ name = "wand of starstorm", chance = 5000 },
	{ name = "terra hood", chance = 4170 },
	{ name = "clerical mace", chance = 3330 },
	{ name = "wooden spellbook", chance = 3330 }, -- não confirmado
	{ name = "magma monocle", chance = 2500 },
	{ name = "violet gem", chance = 2500 },
	{ name = "terra helmet", chance = 2000 }, -- não confirmado
	{ name = "lightning robe", chance = 1670 },
	{ name = "magma amulet", chance = 1670 }, -- não confirmado
	{ name = "shockwave amulet", chance = 1670 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -950 }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 24, type = COMBAT_PHYSICALDAMAGE, minDamage = -650, maxDamage = -1150, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -550, maxDamage = -1000, range = 6, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true }, -- não confirmado
	{ name = "combat", interval = 2800, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1200, length = 6, spread = 2, effect = CONST_ME_HITAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 3500, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1100, radius = 4, effect = CONST_ME_FIREAREA, target = false }, -- não confirmado
	{ name = "speed", interval = 4000, chance = 12, speedChange = -400, radius = 5, effect = CONST_ME_POFF, target = false, duration = 8000 }, -- não confirmado
}

monster.defenses = {
	defense = 86, -- não confirmado
	armor = 86, -- não confirmado
	mitigation = 2.55, -- não confirmado
	{ name = "combat", interval = 3000, chance = 16, type = COMBAT_HEALING, minDamage = 850, maxDamage = 1500, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
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
	{ type = "outfit", condition = false }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }, -- não confirmado
}

mType:register(monster)
