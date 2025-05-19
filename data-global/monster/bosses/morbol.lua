local mType = Game.createMonsterType("Morbol")
local monster = {}

monster.description = "Morbol"
monster.experience = 75000
monster.outfit = {
	lookType = 676,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 75000
monster.maxHealth = 75000
monster.race = "blood"
monster.corpse = 21900
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ id = 3043, chance = 100000, maxCount = 25 }, -- crystal coin
	{ id = 11666, chance = 50000, maxCount = 4 }, -- tentacle pieice
	{ id = 21292, chance = 1000 }, -- feedbag
	{ id = 35514, chance = 4000 }, -- jungle flail
	{ id = 35518, chance = 4000 }, -- jungle bow
	{ id = 35521, chance = 4000 }, -- jungle rod
	{ id = 35522, chance = 4000 }, -- jungle wand
	{ id = 35524, chance = 4000 }, -- jungle quiver
	{ id = 30393, chance = 4000 }, -- cobra crossbow
	{ id = 30395, chance = 4000 }, -- cobra club
	{ id = 30396, chance = 4000 }, -- cobra axe
	{ id = 30398, chance = 4000 }, -- cobra sword
	{ id = 30399, chance = 4000 }, -- cobra wand
	{ id = 30400, chance = 4000 }, -- cobra rod
	{ name = "bag you desire", chance = 1000, unique = true },
	{ name = "gold token", minCount = 0, maxCount = 5, chance = 10000 },
	{ name = "silver token", minCount = 0, maxCount = 5, chance = 20000 },
	{ name = "supreme health potion", minCount = 0, maxCount = 20, chance = 45000 },
	{ name = "ultimate mana potion", minCount = 0, maxCount = 6, chance = 42000 },
	{ name = "ultimate spirit potion", minCount = 0, maxCount = 14, chance = 42000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 150, attack = 150 },
	{ name = "combat", interval = 2000, chance = 32, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -800, radius = 8, effect = CONST_ME_CARNIPHILA, target = false },
	{ name = "combat", interval = 2000, chance = 19, type = COMBAT_EARTHDAMAGE, minDamage = -600, maxDamage = -1400, range = 7, radius = 3, shootEffect = CONST_ANI_POISON, effect = CONST_ME_CARNIPHILA, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -2000, length = 7, spread = 0, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -9999, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -1400, length = 7, spread = 0, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1200, radius = 3, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -550, maxDamage = -1230, range = 7, radius = 2, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -800, range = 7, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = true },
}

monster.defenses = {
	defense = 75,
	armor = 48,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
