local mType = Game.createMonsterType("Converter")
local monster = {}

monster.description = "a converter"
monster.experience = 21425
monster.outfit = {
	lookType = 1623,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2379
monster.Bestiary = {
	class = "Elemental",
	race = BESTY_RACE_ELEMENTAL,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 2,
	Locations = "Gloom Pillars",
}

monster.health = 29600
monster.maxHealth = 29600
monster.race = "venom"
monster.corpse = 43567
monster.speed = 210
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
	targetDistance = 4,
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
	{ name = "crystal coin", chance = 65000 },
	{ name = "darklight obsidian axe", chance = 3500 },
	{ name = "darklight core", chance = 1565, maxCount = 5  },
	{ name = "wand of starstorm", chance = 6050 },
	{ name = "darklight matter", chance = 4250, maxCount = 7 },
	{ name = "ultimate health potion", chance = 25146, maxCount = 5 },
	{ name = "focus cape", chance = 2565 },
	{ name = "white gem", chance = 3586 },
	{ name = "gold ingot", chance = 1860 },
	{ name = "cyan crystal fragment", chance = 4430 },
	{ name = "red crystal fragment", chance = 5430 },
	{ name = "blue crystal shard", chance = 3710 },
	{ name = "small diamond", chance = 4570 },
	{ name = "blue gem", chance = 4570 },
	{ name = "green crystal fragment", chance = 3430 },
	{ name = "mercenary sword", chance = 965 },
	{ name = "onyx chip", chance = 2860 },
	{ name = "war axe", chance = 236 },
	{ name = "giant sword", chance = 896 },
	{ name = "stone skin amulet", chance = 570 },
	{ name = "crystal mace", chance = 1690 },
	{ name = "noble axe", chance = 1600 },
	{ id = 23531, chance = 930 }, -- ring of green plasma
	{ name = "diabolic skull", chance = 590 },
	{ id = 43895, chance = 20 }, -- bag you covet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1450 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -1150, maxDamage = -1400, range = 7, shootEffect = CONST_ME_GREEN_RINGS, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -800, maxDamage = -1250, length = 8, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -1000, maxDamage = -1350, radius = 4, effect = CONST_ME_POISONAREA, target = false },
	{ name = "death chain", interval = 2000, chance = 20, minDamage = -1100, maxDamage = -1380, target = true },
}

monster.defenses = {
	defense = 60,
	armor = 112,
	mitigation = 3.25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 45 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)

