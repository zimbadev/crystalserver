local mType = Game.createMonsterType("Iehtra")
local monster = {}

monster.description = "Iehtra"
monster.experience = 75000
monster.outfit = {
	lookType = 557,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"IehtraDeath",
}

monster.health = 800000
monster.maxHealth = 800000
monster.race = "undead"
monster.corpse = 18953
monster.speed = 260
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "Sword Familiar", chance = 20, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I'll finish this.", yell = false },
	{ text = "My father must be stopped.", yell = false },
	{ text = "You deserve worse than death for this.", yell = false },
	{ text = "No... It wasn't like this...", yell = false },
	{ text = "What?!", yell = false },
	{ text = "I can't allow you to leave here.", yell = false },
	{ text = "'Tis best then if you pray for your soul.", yell = false },
	{ text = "........", yell = false },
	{ text = "Soul Steal!", yell = true },
	{ text = "Dark Metamorphosis!", yell = true },
}

monster.loot = {
	{ id = 8192, chance = 100000 }, -- vampire lord token
	{ id = 18927, chance = 100000 }, -- vampire's cape chain
	{ id = 18936, chance = 5000 }, -- vampire count's medal
	{ id = 18935, chance = 5000 }, -- vampire's signet ring
	{ id = 11449, chance = 50000 }, -- blood preservation
	{ id = 9685, chance = 50000 }, -- vampire teeth
	{ id = 3031, chance = 1000000, maxCount = 100 }, -- gold coin
	{ id = 3035, chance = 100000, maxCount = 5 }, -- platinum coin
	{ id = 237, chance = 50000, maxCount = 3 }, -- strong mana potion
	{ id = 236, chance = 50000, maxCount = 3 }, -- strong health potion
	{ id = 3049, chance = 10000 }, -- stealth ring
	{ id = 3098, chance = 10000 }, -- ring of healing
	{ id = 5909, chance = 10000 }, -- white piece of cloth
	{ id = 5911, chance = 10000 }, -- red piece of cloth
	{ id = 5912, chance = 10000 }, -- blue piece of cloth
	{ id = 7427, chance = 5000 }, -- chaos mace
	{ id = 3326, chance = 10000 }, -- epee
	{ id = 7419, chance = 5000 }, -- dreaded cleaver
	{ id = 8075, chance = 5000 }, -- spellbook of lost souls
	{ id = 19373, chance = 1000 }, -- haunted mirror piece
	{ id = 3434, chance = 5000 }, -- vampire shield
	{ id = 19374, chance = 50 }, -- vampire silk slippers
	{ id = 3028, chance = 50000, maxCount = 5 }, -- small diamond
	{ id = 3027, chance = 50000, maxCount = 5 }, -- black pearl
	{ id = 3029, chance = 50000, maxCount = 5 }, -- small sapphire
	{ id = 3032, chance = 50000, maxCount = 5 }, -- small emerald
	{ id = 3036, chance = 10000 }, -- violet gem
	{ id = 28493, chance = 800 }, -- bone fiddle
	{ name = "bag you desire", chance = 100, unique = true },
	{ name = "antler-horn helmet", chance = 390 },
	{ name = "gold token", minCount = 0, maxCount = 3, chance = 18000 },
	{ name = "silver token", minCount = 0, maxCount = 3, chance = 25000 },
	{ name = "supreme health potion", minCount = 0, maxCount = 20, chance = 45000 },
	{ name = "ultimate mana potion", minCount = 0, maxCount = 6, chance = 42000 },
	{ name = "ultimate spirit potion", minCount = 0, maxCount = 14, chance = 42000 },
	{ name = "toga mortis", chance = 500 },
	{ name = "bear skin", chance = 1600 },
	{ name = "embrace of nature", chance = 1100 },
}

monster.attacks = {
	{ name = "melee", type = COMBAT_PHYSICALDAMAGE, interval = 2000, minDamage = -900, maxDamage = -2700 },
	{ name = "combat", type = COMBAT_FIREDAMAGE, interval = 2000, chance = 15, length = 8, spread = 0, minDamage = -1200, maxDamage = -3200, effect = CONST_ME_HITBYFIRE },
	{ name = "combat", type = COMBAT_LIFEDRAIN, interval = 2000, chance = 10, length = 8, spread = 0, minDamage = -600, maxDamage = -1600, effect = CONST_ME_BATS },
	{ name = "combat", type = COMBAT_DEATHDAMAGE, interval = 2000, chance = 30, radius = 6, minDamage = -1200, maxDamage = -1500, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", type = COMBAT_DEATHDAMAGE, interval = 2000, chance = 20, length = 8, minDamage = -1700, maxDamage = -2000, effect = CONST_ME_MORTAREA, target = false },
	{ name = "speed", interval = 1000, chance = 17, speedChange = -600, range = 7, radius = 4, effect = CONST_ME_MAGIC_RED, target = true, duration = 1500 },
	{ name = "combat", interval = 2000, chance = 21, type = COMBAT_ICEDAMAGE, minDamage = -900, maxDamage = -2700, range = 6, radius = 2, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_GIANTICE, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -900, maxDamage = -2700, range = 7, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_CARNIPHILA, target = false },
}

monster.defenses = {
	defense = 150,
	armor = 150,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
