local mType = Game.createMonsterType("Bluebeak")
local monster = {}

monster.description = "a bluebeak"
monster.experience = 2070
monster.outfit = {
	lookType = 1849,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2673
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

monster.health = 2430
monster.maxHealth = 2430
monster.race = "ink"
monster.corpse = 51505
monster.speed = 120
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Shriiiiek!", yell = false },
	{ text = "Screeech!", yell = false },
	{ text = "Squawk!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60590, maxCount = 100 },
	{ name = "platinum coin", chance = 40590, maxCount = 15 },
	{ name = "small sapphire", chance = 1600, maxCount = 2 },
	{ name = "paper boat", chance = 2000 }, -- new item
	{ name = "star ink", chance = 1400 }, -- new item
	{ name = "hailstorm rod", chance = 1000 },
	{ name = "grapes", chance = 800 },
	{ name = "blue crystal splinter", chance = 600 },
	{ name = "glacier amulet", chance = 600 },
	{ name = "glacier shoes", chance = 600 },
	{ name = "blue crystal shard", chance = 600 },
	{ name = "etcher", chance = 600 },
	{ name = "blue gem", chance = 400 },
}

monster.attacks = {
	-- Physical: Spear (200-230)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -230, range = 7, shootEffect = CONST_ANI_SPEAR, effect = CONST_ME_DRAWBLOOD, target = true },
	-- Ice: Melee (80-240)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -80, maxDamage = -240 },
	-- Ice: Cross (240-260)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -240, maxDamage = -260, radius = 3, effect = CONST_ME_ICEAREA, target = false },
}

monster.defenses = {
	defense = 58,
	armor = 40,
	mitigation = 1.04,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
