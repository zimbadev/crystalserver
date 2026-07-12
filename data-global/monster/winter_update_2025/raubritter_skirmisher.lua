local mType = Game.createMonsterType("Raubritter Skirmisher")
local monster = {}

monster.name = "Raubritter Skirmisher"
monster.description = "a raubritter skirmisher"
monster.experience = 8550
monster.outfit = {
	lookType = 1900,
	lookHead = 94,
	lookBody = 19,
	lookLegs = 3,
	lookFeet = 19,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2750
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Adaean Shore, Adaean Silver Mines, Arean Outskirts, Bloodfire Gorge, Isle of Ada, Stag Bastion, Adaean Crystal Mines.",
}

monster.health = 11000
monster.maxHealth = 11000
monster.race = "blood"
monster.corpse = 52684
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	{ text = "I'll... hunt you... down!", yell = false },
	{ text = "This is ours now!", yell = false },
	{ text = "Purification! Sal... vation! Deliver...", yell = false },
	{ text = "Nnnooo... not... yesss, KILL!", yell = false },
	{ text = "Out... sider, hrngh!", yell = false },
	{ text = "Must... resist!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 5, maxCount = 10 },
	{ name = "cuirass plate", chance = 4150 },
	{ name = "silver poniard", chance = 1950 },
	{ name = "gold ring", chance = 1910 },
	{ name = "fur armor", chance = 1180 },
	{ name = "mercenary sword", chance = 1050 },
	{ name = "crown shield", chance = 1030 },
	{ name = "gold ingot", chance = 840 },
	{ name = "crown armor", chance = 720 },
	{ name = "marinated sturgeon", chance = 270 },
	{ id = 50150, chance = 170 }, -- ring of orange plasma
	{ id = 23533, chance = 120 }, -- ring of red plasma
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 80, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -380, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -450, range = 4, shootEffect = CONST_ANI_WHIRLWINDSWORD, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -250, range = 4, shootEffect = CONST_ANI_THROWINGKNIFE, target = true },
	{ name = "Skirmisher Wave", interval = 2000, chance = 15, minDamage = -220, maxDamage = -300, target = false },
}

monster.defenses = {
	defense = 120,
	armor = 120,
	mitigation = 2.45,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -12 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 9 },
	{ type = COMBAT_EARTHDAMAGE, percent = -6 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
