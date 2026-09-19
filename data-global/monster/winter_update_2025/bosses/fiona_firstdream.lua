local mType = Game.createMonsterType("Fiona Firstdream")
local monster = {}

monster.description = "Fiona Firstdream"
monster.experience = 0
monster.outfit = {
	lookType = 1681,
	lookHead = 92,
	lookBody = 91,
	lookLegs = 94,
	lookFeet = 79,
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
	bossRaceId = 2715,
	bossRace = RARITY_ARCHFOE, -- não confirmado
}

monster.strategiesTarget = {
	nearest = 70, -- não confirmado
	health = 10, -- não confirmado
	damage = 10, -- não confirmado
	random = 10, -- não confirmado
}

monster.flags = {
	summonable = false, -- não confirmado
	attackable = true, -- não confirmado
	hostile = true, -- não confirmado
	convinceable = false, -- não confirmado
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
	{ text = "I'll burn you to a crisp!", yell = false },
	{ text = "You look shockingly flammable!", yell = false },
	{ text = "You're playing with FIRE!", yell = false },
	{ text = "Mana low? That's cute.", yell = false },
	{ text = "Your death is only a matter of time!", yell = false },
	{ text = "This is outrageous, I quit!", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -650, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true }, -- não confirmado
	{ name = "combat", interval = 2500, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -350, maxDamage = -600, length = 6, spread = 3, effect = CONST_ME_ICEATTACK, target = false }, -- não confirmado
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -800, radius = 4, effect = CONST_ME_ENERGYAREA, target = false }, -- não confirmado
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -550, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true }, -- não confirmado
}

monster.defenses = {
	defense = 80, -- não confirmado
	armor = 80, -- não confirmado
	mitigation = 2.10, -- não confirmado
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 400, maxDamage = 700, effect = CONST_ME_MAGIC_BLUE, target = false }, -- não confirmado
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
