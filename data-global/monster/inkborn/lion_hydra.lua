local mType = Game.createMonsterType("Lion Hydra")
local monster = {}

monster.description = "a lion hydra"
monster.experience = 2450
monster.outfit = {
	lookType = 1859,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2678
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

monster.health = 2760
monster.maxHealth = 2760
monster.race = "ink"
monster.corpse = 51564
monster.speed = 115
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
	{ text = "Roarrr!", yell = false },
	{ text = "Roar-hiss ... hiss ... roarrr!", yell = false },
	{ text = "Hissss!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60000, minCount = 1, maxCount = 100 },
	{ name = "platinum coin", chance = 45000, minCount = 1, maxCount = 15 },
	{ name = "sealing wax", chance = 2800 },
	{ name = "silver brooch", chance = 2000 },
	{ name = "small diamond", chance = 1800, minCount = 1, maxCount = 3 },
	{ name = "ham", chance = 1600, minCount = 1, maxCount = 2 },
	{ name = "hydra head", chance = 1400 },
	{ name = "onyx chip", chance = 1200 },
	{ name = "titan axe", chance = 1000 },
	{ name = "sacred tree amulet", chance = 1000 },
	{ name = "medusa shield", chance = 1000 },
	{ name = "gold ingot", chance = 800 },
}

monster.attacks = {
	-- Fire: Melee (80-200)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -80, maxDamage = -200 },
	-- Fire: Flam Strike (210-280)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -210, maxDamage = -280, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	-- Fire: Claw Attack (220-280)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -220, maxDamage = -280, range = 1, effect = CONST_ME_FIREAREA, target = true },
	-- Holy: Explosion (230-290)
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -230, maxDamage = -290, radius = 4, effect = CONST_ME_HOLYAREA, target = false },
}

monster.defenses = {
	defense = 68,
	armor = 42,
	mitigation = 1.15,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
