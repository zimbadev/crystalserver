local mType = Game.createMonsterType("Ink Splash")
local monster = {}

monster.description = "an ink splash"
monster.experience = 1450
monster.outfit = {
	lookType = 1064,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2639
monster.Bestiary = {
	class = "Inkborn",
	race = BESTY_RACE_INKBORN,
	toKill = 1000,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 1,
	Locations = "Fields of Glory.",
}

monster.health = 1950
monster.maxHealth = 1950
monster.race = "ink"
monster.corpse = 28601
monster.speed = 190
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 60000, minCount = 1, maxCount = 100 },
	{ name = "platinum coin", chance = 45000, minCount = 1, maxCount = 5 },
	{ name = "star ink", chance = 2800 },
	{ id = 281, chance = 2690 }, -- giant shimmering pearl
	{ name = "poisonous slime", chance = 1800 },
	{ id = 3509, chance = 1600 }, -- inkwell
	{ name = "candlestick", chance = 1200 },
	{ name = "black pearl", chance = 1000 },
	{ name = "terra amulet", chance = 800 },
	{ name = "terra hood", chance = 800 },
	{ name = "terra legs", chance = 800 },
}

monster.attacks = {
	-- Physical: Melee (45-130)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -45, maxDamage = -130 },
	-- Physical: Death Strike (210-220)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -210, maxDamage = -220, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	-- Earth: Ball (205-270)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -205, maxDamage = -270, range = 7, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_SMALLPLANTS, target = true },
	-- Earth: Wave (320-370)
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -320, maxDamage = -370, radius = 3, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 36,
	mitigation = 0.99,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
