local mType = Game.createMonsterType("Percy Peacetinker")
local monster = {}

monster.description = "Percy Peacetinker"
monster.experience = 0
monster.outfit = {
	lookType = 137,
	lookHead = 79,
	lookBody = 31,
	lookLegs = 101,
	lookFeet = 130,
	lookAddons = 3,
}

monster.health = 155000
monster.maxHealth = 155000
monster.race = "blood"
monster.corpse = 6081
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2713,
	bossRace = RARITY_ARCHFOE, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 70, -- não confirmado
	health = 10, -- não confirmado
	damage = 10, -- não confirmado
	random = 10, -- não confirmado
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = true,
	canPushCreatures = true, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 5, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.voices = {
	interval = 5000, -- não confirmado
	chance = 10, -- não confirmado
	{ text = "THE LOOT IS OURS!", yell = false },
	{ text = "You won't get away with this!", yell = false },
	{ text = "Let's see if you can dodge these holy arrows!", yell = false },
	{ text = "Time to stock up on diamond arrows!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -380 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -700, range = 7, shootEffect = CONST_ANI_ROYALSPEAR, effect = CONST_ME_EXPLOSIONHIT, target = true }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -350, maxDamage = -600, range = 7, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_HOLYDAMAGE, target = true }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -500, maxDamage = -750, radius = 4, effect = CONST_ME_HOLYAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -450, maxDamage = -650, length = 6, spread = 2, effect = CONST_ME_EXPLOSIONHIT, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 82, -- não confirmado
	armor = 82, -- não confirmado
	mitigation = 2.15, -- não confirmado
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 450, maxDamage = 750, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
