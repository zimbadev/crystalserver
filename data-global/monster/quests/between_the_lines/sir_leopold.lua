local mType = Game.createMonsterType("Sir Leopold")
local monster = {}

monster.description = "sir leopold"
monster.experience = 26000
monster.outfit = {
	lookType = 1847,
	lookHead = 78,
	lookBody = 19,
	lookLegs = 94,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2694,
	bossRace = RARITY_NEMESIS,
}

monster.health = 18000
monster.maxHealth = 18000
monster.race = "undead"
monster.corpse = 28601
monster.speed = 85
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 2,
	color = 132,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 7500, maxCount = 74 },
	{ id = 3041, chance = 5000, maxCount = 2 }, -- blue gem
	{ id = 32769, chance = 5000 }, -- white gem
	{ name = "etcher", chance = 6000 },
	{ id = 6299, chance = 4500 }, -- death ring
	{ name = "silver amulet", chance = 4800 },
	{ name = "bronze amulet", chance = 4000 },
	{ id = 3092, chance = 3800 }, -- axe ring
	{ name = "knight armor", chance = 3800 },
	{ name = "colourful quill", chance = 3500 },
	{ name = "blank imbuement scroll", chance = 3000 },
	{ name = "proficiency catalyst", chance = 3000 },
}

-- missing spells
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -350, range = 5, radius = 2, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICETORNADO, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -250, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 15,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 40, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
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
