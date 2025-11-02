local mType = Game.createMonsterType("Bramble Wyrmling")
local monster = {}

monster.description = "a bramble wyrmling"
monster.experience = 1950
monster.outfit = {
	lookType = 1850,
	lookHead = 43,
	lookBody = 43,
	lookLegs = 52,
	lookFeet = 72,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 2671
monster.Bestiary = {
	class = "Inkborn",
	race = BESTY_RACE_INKBORN,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Book World.",
}

monster.health = 2350
monster.maxHealth = 2350
monster.race = "ink"
monster.corpse = 51501
monster.speed = 125
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Fchchch!", yell = false },
	{ text = "Snarrrl!", yell = false },
	{ text = "Chirp!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 60590, maxCount = 85 },
	{ name = "platinum coin", chance = 40590, maxCount = 10 },
	{ name = "small emerald", chance = 2500, maxCount = 4 },
	{ name = "green crystal fragment", chance = 1900, maxCount = 2 },
	{ name = "book with a dragon", chance = 1600 },
	{ name = "terra hood", chance = 1200 },
	{ id = 3038, chance = 800 }, -- green gem
}

monster.attacks = {
	-- Physical: Bite (180-250)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -180, maxDamage = -250 },
	-- Earth: Poison condition
	--{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -25, maxDamage = -40, length = 5000, spread = 3, effect = CONST_ME_SMALLPLANTS, target = true },
	-- Earth: Melee (100-200)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -200, range = 1, effect = CONST_ME_SMALLPLANTS, target = true },
	-- Earth: Bite (200-280)
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -280, range = 1, effect = CONST_ME_POISONAREA, target = true },
	-- Earth: Wave (200-280)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -280, radius = 4, effect = CONST_ME_SMALLPLANTS, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 38,
	mitigation = 0.94,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
