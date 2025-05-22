local mType = Game.createMonsterType("Sugar Mommy")
local monster = {}

monster.description = "Sugar Mommy"
monster.experience = 45000
monster.outfit = {
	lookType = 1764,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2580,
	bossRace = RARITY_BANE,
}

monster.health = 45000
monster.maxHealth = 45000
monster.race = "blood"
monster.corpse = 48415
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 20,
}

monster.strategiesTarget = {
	nearest = 90,
	health = 0,
	damage = 10,
	random = 0,
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
	staticAttackChance = 98,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "SUGAR!!!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 95 },
	{ name = "platinum coin", chance = 100000, maxCount = 11 },
	{ name = "small enchanted sapphire", chance = 8900 },
	{ id = 3039, chance = 94465, maxCount = 1 }, -- red gem
	{ name = "white gem", chance = 5600, maxCount = 1 },
	{ id = 48114, chance = 1000 }, -- peppermint backpack
	{ id = 45643, chance = 1000 }, -- biscuit barrier
	{ id = 45644, chance = 1000 }, -- candy-coated quiver
	{ id = 45639, chance = 1000 }, -- cocoa grimoire
	{ id = 45640, chance = 1000 }, -- creamy grimoire
	{ id = 45641, chance = 2300 }, -- candy necklace
	{ id = 45642, chance = 7650 }, -- ring of temptation
	{ id = 48254, chance = 11655, maxCount = 1 }, -- churro heart
	{ id = 48250, chance = 46555, maxCount = 1 }, -- dark chocolate coin
	{ id = 48252, chance = 15300, maxCount = 1 }, -- beijinho
	{ id = 45642, chance = 14650, maxCount = 1 }, -- brigadeiro
	{ id = 48249, chance = 54465, maxCount = 1 }, -- milk chocolate coin
	{ id = 48256, chance = 2367, maxCount = 1 }, -- pastry dragon
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 20, minDamage = 0, maxDamage = -650 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_ENERGYDAMAGE, minDamage = -470, maxDamage = -680, range = 6, shootEffect = CONST_ANI_CHERRYBOMB, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -1170, maxDamage = -1280, radius = 6, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -1050, maxDamage = -1110, radius = 12, effect = CONST_ME_HEARTS, target = false },
	{ name = "root area", interval = 20000, chance = 100, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 1400, maxDamage = 1600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
