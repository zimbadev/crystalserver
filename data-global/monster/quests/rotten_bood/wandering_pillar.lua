local mType = Game.createMonsterType("Wandering Pillar")
local monster = {}

monster.description = "a wandering pillar"
monster.experience = 23200
monster.outfit = {
	lookType = 1657,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2395
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_HUMANOID,
	toKill = 5000,
	FirstUnlock = 50,
	SecondUnlock = 5000,
	CharmsPoints = 100,
	Stars = 3,
	Occurrence = 2,
	Locations = "Gloom Pillars",
}

monster.health = 37000
monster.maxHealth = 37000
monster.race = "venom"
monster.corpse = 43828
monster.speed = 220
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
}

monster.loot = {
	{ name = "crystal coin", chance = 125000 },
	{ name = "darklight obsidian axe", chance = 3500 },
	{ name = "basalt crumbs", chance = 9500 },
	{ name = "sulphurous stone", chance = 3500 },
	{ name = "dark helmet", chance = 12500 },
	{ name = "darklight core", chance = 4500 },
	{ name = "magma boots", chance = 7250 },
	{ id = 12600, chance = 1250, maxCount = 4 },
	{ name = "magma coat", chance = 9250 },
	{ name = "onyx chip", chance = 3250, maxCount = 2 },
	{ name = "fire sword", chance = 5250 },
	{ name = "magma clump", chance = 11250 },
	{ id = 3039, chance = 1250 }, -- red gem
	{ name = "green gem", chance = 5250 },
	{ name = "basalt core", chance = 6299 },
	{ name = "giant sword", chance = 658 },
	{ name = "magma legs", chance = 865 },
	{ name = "might ring", chance = 570 },
	{ name = "spellbook of mind control", chance = 1180 },
	{ id = 23531, chance = 930 }, -- ring of green plasma
	{ name = "metal bat", chance = 760 },
	{ name = "diabolic skull", chance = 590 },
	{ name = "fire axe", chance = 590 },
	{ id = 43895, chance = 20 } -- bag you covet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1450 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -1150, range = 7, radius = 4, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -720, maxDamage = -900, radius = 3, shootEffect = CONST_ANI_ENVENOMEDARROW, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -800, maxDamage = -1250, length = 8, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -400, maxDamage = -640, range = 7, radius = 7, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -650, maxDamage = -1325, radius = 3, effect = CONST_ME_POISONAREA, target = false },
	{ name = "root", interval = 2000, chance = 1, target = true },
}

monster.defenses = {
	defense = 60,
	armor = 104,
	mitigation = 3.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -40 },
	{ type = COMBAT_FIREDAMAGE, percent = -25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)

