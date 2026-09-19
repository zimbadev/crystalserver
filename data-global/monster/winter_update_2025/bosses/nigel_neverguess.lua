local mType = Game.createMonsterType("Nigel Neverguess")
local monster = {}

monster.description = "Nigel Neverguess"
monster.experience = 0
monster.outfit = {
	lookType = 1837,
	lookHead = 38,
	lookBody = 4,
	lookLegs = 8,
	lookFeet = 11,
	lookAddons = 3,
}

monster.health = 155000
monster.maxHealth = 155000
monster.race = "blood"
monster.corpse = 6081
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2716,
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
	targetDistance = 4, -- não confirmado
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
	{ text = "Sorry, I'm late guys.", yell = false },
	{ text = "I don't need weapons to beat you up!", yell = false },
	{ text = "Embrace harmony!", yell = false },
	{ text = "You meditate, I devastate.", yell = false },
	{ text = "Your balance is off!", yell = false },
	{ text = "I'll show you what inner balance looks like!", yell = false },
	{ text = "Last one in, first one out! Sorry guys!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -320 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -600, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -650, length = 5, spread = 3, effect = CONST_ME_MORTAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -450, maxDamage = -700, radius = 4, effect = CONST_ME_FIREAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -500, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true }, -- não confirmado
}

monster.defenses = {
	defense = 75, -- não confirmado
	armor = 75, -- não confirmado
	mitigation = 2.00, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HEALING, minDamage = 350, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
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
