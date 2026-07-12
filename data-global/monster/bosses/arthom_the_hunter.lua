local mType = Game.createMonsterType("Arthom the Hunter")
local monster = {}

monster.description = "arthom the hunter"
monster.experience = 550
monster.outfit = {
	lookType = 129,
	lookHead = 77,
	lookBody = 40,
	lookLegs = 80,
	lookFeet = 121,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1128,
	bossRace = RARITY_NEMESIS,
}

monster.health = 500
monster.maxHealth = 500
monster.race = "blood"
monster.corpse = 22003
monster.speed = 105
monster.manaCost = 530

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
	convinceable = true,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {
	{ name = "hunter's quiver", chance = 100000 },
	{ name = "platinum coin", chance = 100000, maxCount = 2 },
	{ name = "sniper arrow", chance = 46000, maxCount = 10 },
	{ name = "poison arrow", chance = 31000, maxCount = 10 },
	{ name = "small diamond", chance = 25000, maxCount = 3 },
	{ name = "small ruby", chance = 25000, maxCount = 3 },
	{ name = "arrow", chance = 11250, maxCount = 10 },
	{ id = 3449, chance = 11250, maxCount = 8 }, -- burst arrow
	{ name = "bow", chance = 9600 },
	{ name = "sniper gloves", chance = 7700 },
	{ name = "dragon necklace", chance = 5800 },
	{ id = 3034, chance = 3800 }, -- talon
	{ name = "dark armor", chance = 3800 },
	{ id = 7400, chance = 1900 }, -- lion trophy
	{ name = "terra hood", chance = 1900 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -20 },
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 9, minDamage = -10, maxDamage = -15, radius = 4, effect = CONST_ME_DRAWBLOOD, target = false },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -150, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -0, range = 7, shootEffect = CONST_ANI_SMALLSTONE, radius = 4, effect = CONST_ME_POFF, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 8,
	mitigation = 0.25,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
