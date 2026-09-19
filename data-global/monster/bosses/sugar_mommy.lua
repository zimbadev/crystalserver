local mType = Game.createMonsterType("Sugar Mommy")
local monster = {}

monster.description = "Sugar Mommy"
monster.experience = 6800
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

monster.health = 6000
monster.maxHealth = 6000
monster.race = "candy"
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

monster.voices = {}

monster.loot = {
	{ id = 3035, chance = 100000, maxCount = 13 }, -- platinum coin
	{ id = 3590, chance = 100000, maxCount = 2 }, -- cherry
	{ id = 48249, chance = 54465, maxCount = 7 }, -- milk chocolate coin
	{ id = 48250, chance = 46555, maxCount = 5 }, -- dark chocolate coin
	{ id = 48273, chance = 16800, maxCount = 1 }, -- taiyaki ice cream
	{ id = 3039, chance = 6100, maxCount = 1 }, -- red gem
	{ id = 25737, chance = 3800, maxCount = 2 }, -- rainbow quartz
	{ id = 3038, chance = 3500, maxCount = 1 }, -- green gem
	{ id = 3037, chance = 3500, maxCount = 1 }, -- yellow gem
	{ id = 25700, chance = 1700, maxCount = 1 }, -- dream blossom staff
	{ id = 6393, chance = 3500, maxCount = 1 }, -- cream cake
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_ENERGYDAMAGE, minDamage = -50, maxDamage = -250, range = 6, shootEffect = CONST_ANI_CHERRYBOMB, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -90, maxDamage = -180, radius = 6, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -75, maxDamage = -110, radius = 12, effect = CONST_ME_HEARTS, target = false },
	{ name = "root area", interval = 20000, chance = 100, target = false },
}

monster.defenses = {
	defense = 25,
	armor = 15,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 250, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
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
