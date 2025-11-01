local mType = Game.createMonsterType("Crusader")
local monster = {}

monster.description = "a crusader"
monster.experience = 3050
monster.outfit = {
	lookType = 1847,
	lookHead = 95,
	lookBody = 0,
	lookLegs = 43,
	lookFeet = 78,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2677
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

monster.health = 3400
monster.maxHealth = 3400
monster.race = "ink"
monster.corpse = 51497
monster.speed = 120
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Surrender or die!", yell = false },
	{ text = "You will bleach out!", yell = false },
	{ text = "The pen is *not* mightier than the sword!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 60590, maxCount = 99 },
	{ name = "platinum coin", chance = 40590, maxCount = 20 },
	{ name = "torn page", chance = 5590 }, -- new item
	{ name = "small topaz", chance = 3030 },
	{ name = "great health potion", chance = 2500 },
	{ id = 281, chance = 1900 },
	{ name = "knight axe", chance = 1900 },
	{ name = "ancient shield", chance = 1560 },
	{ id = 3234, chance = 1540 }, -- cookbook
	{ name = "warrior helmet", chance = 400 },
}

monster.attacks = {
	-- Physical: Melee (100-330)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -330 },
	-- Physical: Exori Hur (0-250)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -250, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	-- Death: Death Strike (180-220)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -180, maxDamage = -220, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	-- Death: Death Ball (200-230)
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -230, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 52,
	mitigation = 0.99,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
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
