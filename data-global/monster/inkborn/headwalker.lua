local mType = Game.createMonsterType("Headwalker")
local monster = {}

monster.description = "a headwalker"
monster.experience = 2050
monster.outfit = {
	lookType = 1856,
	lookHead = 94,
	lookBody = 80,
	lookLegs = 97,
	lookFeet = 42,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2672
monster.Bestiary = {
	class = "Inkborn",
	race = BESTY_RACE_INKBORN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Book World.",
}

monster.health = 2460
monster.maxHealth = 2460
monster.race = "ink"
monster.corpse = 51552
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	canPushCreatures = false,
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
	{ text = "Too ... much ... knowledge ...", yell = false },
	{ text = "Knowledge is power!", yell = false },
	{ text = "I will drink your thoughts!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60000, minCount = 1, maxCount = 150 },
	{ name = "platinum coin", chance = 45000, minCount = 1, maxCount = 8 },
	{ name = "torn page", chance = 2800 },
	{ name = "great health potion", chance = 2000 },
	{ id = 281, chance = 1800 }, -- giant shimmering pearl
	{ name = "white pearl", chance = 1800 },
	{ name = "black pearl", chance = 1800 },
	{ name = "protection amulet", chance = 1400 },
	{ name = "book with an hourglass", chance = 1200 }, -- new item
	{ name = "blank imbuement scroll", chance = 1000 },
}

monster.attacks = {
	-- Fire: Melee (90-250)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -90, maxDamage = -250 },
	-- Fire: Wave (200-270)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -270, radius = 4, effect = CONST_ME_FIREAREA, target = false },
	-- Death: Strike (200-260)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -260, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	-- Life Drain: Strike (200-220)
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -220, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MAGIC_RED, target = true },
	-- Drunk effect
	{ name = "drunk", interval = 2000, chance = 10, range = 7, shootEffect = CONST_ANI_ENERGY, target = true },
}

monster.defenses = {
	defense = 58,
	armor = 38,
	mitigation = 0.96,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
