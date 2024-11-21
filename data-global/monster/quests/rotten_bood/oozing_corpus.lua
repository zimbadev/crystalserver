local mType = Game.createMonsterType("Oozing Corpus")
local monster = {}

monster.description = "an oozing corpus"
monster.experience = 20600
monster.outfit = {
	lookType = 1625,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2381
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_HUMANOID,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 2,
	Locations = "Jaded Roots",
}

monster.health = 28700
monster.maxHealth = 28700
monster.race = "venom"
monster.corpse = 43579
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
	{ name = "crystal coin", chance = 75930 },
	{ name = "organic acid", chance = 8750 },
	{ name = "terra boots", chance = 9375 },
	{ name = "small amethyst", chance = 10375, maxCount = 3 },
	{ name = "rotten roots", chance = 11375, maxCount = 2 },
	{ name = "blue gem", chance = 5375 },
	{ name = "dragonbone staff", chance = 4375 },
	{ name = "worm sponge", chance = 3375, maxCount = 3 },
	{ name = "violet gem", chance = 6879 },
	{ name = "jade hammer", chance = 3439 },
	{ name = "ultimate health potion", chance = 22860, maxCount = 5 },
	{ name = "cyan crystal fragment", chance = 4430 },
	{ name = "blue crystal shard", chance = 3710 },
	{ name = "green crystal fragment", chance = 2430 },
	{ name = "onyx chip", chance = 2860 },
	{ name = "war axe", chance = 2860 },
	{ name = "might ring", chance = 570 },
	{ name = "spellbook of mind control", chance = 652 },
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
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)

