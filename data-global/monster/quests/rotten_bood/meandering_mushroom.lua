local mType = Game.createMonsterType("Meandering Mushroom")
local monster = {}

monster.description = "a meandering mushroom"
monster.experience = 21980
monster.outfit = {
	lookType = 1621,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2376
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
    toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 2,
	Locations = "Jaded Roots",
}

monster.health = 29100
monster.maxHealth = 29100
monster.race = "venom"
monster.corpse = 43559
monster.speed = 205
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
	{ name = "crystal coin", chance = 70000 },
	{ name = "lichen gobbler", chance = 6508 },
	{ name = "white mushroom", chance = 5500, maxCount = 9 },
	{ name = "rotten roots", chance = 3507, maxCount = 8 },
	{ name = "wand of decay", chance = 2080 },
	{ id = 3039, chance = 22290 }, -- red gem
	{ name = "worm sponge", chance = 2690, maxCount = 5 },
	{ name = "dark mushroom", chance = 2599, maxCount = 13 },
	{ name = "yellow gem", chance = 8209 },
	{ name = "brown mushroom", chance = 4550, maxCount = 7 },
	{ name = "terra amulet", chance = 6250 },
	{ name = "ultimate health potion", chance = 22860, maxCount = 5 },
	{ name = "cyan crystal fragment", chance = 4430 },
	{ name = "red crystal fragment", chance = 5430 },
	{ name = "blue crystal shard", chance = 3710 },
	{ name = "small diamond", chance = 4570 },
	{ name = "green crystal fragment", chance = 3430 },
	{ name = "onyx chip", chance = 2860 },
	{ name = "magma boots", chance = 698 },
	{ name = "might ring", chance = 570 },
	{ id = 23531, chance = 930 }, -- ring of green plasma
	{ name = "metal bat", chance = 760 },
	{ name = "diabolic skull", chance = 590 },
	{ name = "fire axe", chance = 590 },
	{ id = 43895, chance = 20 } -- bag you covet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 400, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -720, maxDamage = -900, radius = 3, shootEffect = CONST_ANI_ENVENOMEDARROW, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = 400, maxDamage = -1500, range = 7, radius = 5, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_EXPLOSIONHIT, target = true },
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -986, range = 7, shootEffect = CONST_ANI_FLAMMINGARROW, effect = CONST_ME_HITBYFIRE, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 104,
	mitigation = 3.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 40 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)

