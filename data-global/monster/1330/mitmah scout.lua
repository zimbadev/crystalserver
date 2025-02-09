local mType = Game.createMonsterType("Mitmah Scout")
local monster = {}

monster.description = "a mitmah scout"
monster.experience = 3230
monster.outfit = {
	lookType = 1709,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2460
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Demonwar Crypt.",
}

monster.health = 3940
monster.maxHealth = 3940
monster.race = "blood"
monster.corpse = 44671
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 80,
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
	staticAttackChance = 80,
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
	chance = 20,
	{ text = "Die for us!", yell = true },
	{ text = "Humans ought to be extinct!", yell = true },
	{ text = "This belongs to us now!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 5000, maxCount = 10 },
	{ name = "Strong Health Potion", chance = 1200, maxCount = 3 },
	{ name = "Green Crystal Splinter", chance = 1000, maxCount = 1 },
	{ name = "Brown Crystal Splinter", chance = 1000, maxCount = 1 },
	{ name = "Broken Mitmah Necklace", chance = 500, maxCount = 1 },
	{ name = "Ruby Necklace", chance = 1000, maxCount = 1 },
	{ name = "Yellow Gem", chance = 900, maxCount = 3 },
	{ name = "Gold Ingot", chance = 1000, maxCount = 1 },
	{ name = "Drill Bolt", chance = 1000, maxCount = 10 },
	{ name = "Onyx Chip", chance = 1000, maxCount = 1 },
	{ name = "Opal", chance = 1000, maxCount = 1 },
	{ name = "Prismatic Quartz", chance = 1000, maxCount = 1 },
	{ name = "Gold-Brocaded Cloth", chance = 1000, maxCount = 1 },
	{ name = "Ornate Crossbow", chance = 400, maxCount = 1 },
	{ name = "Broken Mitmah Necklace", chance = 500, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 190, maxDamage = -390 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -550, range = 7, radius = 1, shootEffect = 2, effect = 38, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 45,
	mitigation = 2.02,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
