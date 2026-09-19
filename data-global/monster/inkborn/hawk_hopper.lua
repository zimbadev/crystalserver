local mType = Game.createMonsterType("Hawk Hopper")
local monster = {}

monster.description = "a hawk hopper"
monster.experience = 1770
monster.outfit = {
	lookType = 1858,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2674
monster.Bestiary = {
	class = "Inkborn",
	race = BESTY_RACE_INKBORN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 2,
	Locations = "Book World.",
}

monster.health = 2180
monster.maxHealth = 2180
monster.race = "ink"
monster.corpse = 51560
monster.speed = 150
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
	{ text = "Coo?", yell = false },
	{ text = "Sniff, sniff.", yell = false },
	{ text = "Chipper!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60590, maxCount = 100 },
	{ name = "platinum coin", chance = 40590, maxCount = 18 },
	{ name = "earth arrow", chance = 5590, maxCount = 5 },
	{ name = "small topaz", chance = 3030, maxCount = 3 },
	{ name = "rainbow quartz", chance = 2500, maxCount = 4 },
	-- { name = "pressed flower", chance = 1900 }, -- new item ( DOUBLE CHECK FOR ID )
	{ id = 3578, chance = 1560 }, -- fish
	{ id = 3595, chance = 1540 }, -- carrot
	{ name = "opal", chance = 1000 },
	{ name = "royal star", chance = 1000, maxCount = 5 },
	{ name = "butterfly ring", chance = 800 },
	{ name = "etcher", chance = 800 }, -- new item
	{ name = "elvish bow", chance = 600 },
}

monster.attacks = {
	-- Physical: Claw Attack (200-240)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -240 },
	-- Earth: Strike (150-200)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -200, range = 7, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_SMALLPLANTS, target = true },
	-- Earth: Stone Shower (190-230)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -190, maxDamage = -230, radius = 4, effect = CONST_ME_STONES, target = false },
}

monster.defenses = {
	defense = 58,
	armor = 36,
	mitigation = 0.94,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
