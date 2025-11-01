local mType = Game.createMonsterType("Vladrukh")
local monster = {}

monster.description = "vladrukh"
monster.experience = 450000
monster.outfit = {
	lookType = 1862,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2642,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 250000 --unknown
monster.maxHealth = 250000 --unknown
monster.race = "undead"
monster.corpse = 51572
monster.speed = 85 --unknown
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 2,
	color = 132,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "crystal coin", chance = 7500, maxCount = 3 },
	{ name = "platinum coin", chance = 7500, maxCount = 138 },
	{ name = "greater proficiency catalyst", chance = 6000 },
	{ name = "blood preservation", chance = 5500 },
	{ name = "supreme health potion", chance = 5000, maxCount = 5 },
	{ name = "ultimate mana potion", chance = 4800, maxCount = 29 },
	{ name = "great mana potion", chance = 4000, maxCount = 6 },
	{ name = "strong mana potion", chance = 3800, maxCount = 14 },
	{ name = "ultimate spirit potion", chance = 3800, maxCount = 4 },
	{ name = "great spirit potion", chance = 3800, maxCount = 15 },
	{ name = "skull belt", chance = 3500 },
	{ name = "blood sceptre", chance = 3200 },
	{ name = "giant emerald", chance = 3000 },
	{ id = 3039, chance = 3000 }, -- red gem
	{ id = 3037, chance = 3000 }, -- yellow gem
}

-- missing spells
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -350, range = 5, radius = 2, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICETORNADO, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -250, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 15,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 40, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
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
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
