local mType = Game.createMonsterType("Cinder Wyrmling")
local monster = {}

monster.description = "a cinder wyrmling"
monster.experience = 1950
monster.outfit = {
	lookType = 1850,
	lookHead = 77,
	lookBody = 94,
	lookLegs = 94,
	lookFeet = 79,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 2670
monster.Bestiary = {
	class = "Inkborn",
	race = BESTY_RACE_INKBORN,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Crumbling Caverns.",
}

monster.health = 2350
monster.maxHealth = 2350
monster.race = "ink"
monster.corpse = 51509
monster.speed = 125
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Snarrrl!", yell = false },
	{ text = "Fchchch!", yell = false },
	{ text = "Chirp!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 60590, maxCount = 85 },
	{ name = "platinum coin", chance = 40590, maxCount = 10 },
	{ name = "small ruby", chance = 5590 },
	{ name = "red crystal fragment", chance = 3030 },
	{ name = "book with a dragon", chance = 2500 }, -- new item
	{ name = "wand of dragonbreath", chance = 1900 },
	{ name = "magma coat", chance = 1000 },
	{ name = "magma monocle", chance = 1000 },
	{ name = "dragon shield", chance = 1000 },
	{ id = 3039, chance = 800 }, -- red gem
}

monster.attacks = {
	-- Fire: Strike (100-200)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -200, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	-- Fire: Wave (200-300)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -300, radius = 4, effect = CONST_ME_FIREAREA, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 38,
	mitigation = 0.94,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
