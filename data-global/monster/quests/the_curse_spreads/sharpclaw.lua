local mType = Game.createMonsterType("Sharpclaw")
local monster = {}

monster.description = "Sharpclaw"
monster.experience = 3000
monster.outfit = {
	lookType = 1031,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3300
monster.maxHealth = 3300
monster.race = "blood"
monster.corpse = 22067
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 1562,
	bossRace = RARITY_ARCHFOE,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Werebadger", chance = 20, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Never underestimate a badger!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 64 },
	{ name = "platinum coin", chance = 100000, maxCount = 7 },
	{ name = "great mana potion", chance = 100000 },
	{ name = "werebadger claws", chance = 100000 },
	{ name = "werebadger skull", chance = 100000 },
	{ name = "onyx chip", chance = 50000, maxCount = 2 },
	{ name = "small enchanted amethyst", chance = 50000 },
	{ name = "badger boots", chance = 400 },
	{ name = "beetroot", chance = 50000 },
	{ name = "underworld rod", chance = 400 },
	{ name = "wand of voodoo", chance = 400 },
	{ name = "troll green", chance = 50000, },
	{ name = "moonlight crystals", chance = 300, maxCount = 15 },
	{ name = "ultimate mana potion", chance = 50000 },
	{ name = "silver token", chance = 1720 },
	{ id = 3098, chance = 15000 }, -- ring of healing
	{ name = "platinum amulet", chance = 1000 },
	{ id = 22101, chance = 5000 }, -- werebadger trophy
	{ name = "werewolf amulet", chance = 800 },
	{ name = "brown mushroom", chance = 75000 },
	{ name = "wolf backpack", chance = 250 },
	{ name = "foxtail amulet", chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -290 },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 100, maxDamage = 720, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 1000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -700, length = 5, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 1, radius = 1, target = true, duration = 2000, outfitMonster = "Werebadger" },
	{ name = "ghastly dragon curse", interval = 2000, chance = 5, range = 1, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 40,
	--	mitigation = ???,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 345, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
