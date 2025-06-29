local mType = Game.createMonsterType("Bulltaur Brute")
local monster = {}

monster.description = "a bulltaur brute"
monster.experience = 4700
monster.outfit = {
	lookType = 1717,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2447
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 2000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Demonwar Crypt.",
}

monster.health = 6560
monster.maxHealth = 6560
monster.race = "blood"
monster.corpse = 44708
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 60,
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
	chance = 30,
	{ text = "This will be a smash hit!!", yell = true },
	{ text = "It's hammer time!", yell = true },
	{ text = "I'll do some downsizing!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 5000, maxCount = 6 },
	{ name = "small topaz", chance = 1200, maxCount = 5 },
	{ name = "platinum coin", chance = 3533, maxCount = 7 },
	{ id = 44736, chance = 4545 }, -- stealth ring
	{ id = 44737, chance = 4545 }, -- stealth ring
	{ id = 44738, chance = 4545 }, -- stealth ring
	{ name = "might ring", chance = 14285 },
	{ name = "mino shield", chance = 840 },
	{ name = "dragon hammer", chance = 420 },
	{ id = 3041, chance = 4545 }, -- stealth ring
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 90, maxDamage = -290 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -550, range = 3, radius = 1, shootEffect = 11, effect = 18, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -500, length = 1, spread = 0, effect = 216, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 78,
	mitigation = 1.22,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
