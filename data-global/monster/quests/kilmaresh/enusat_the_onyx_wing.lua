local mType = Game.createMonsterType("Enusat the Onyx Wing")
local monster = {}

monster.description = "Enusat the Onyx Wing"
monster.experience = 21500
-- Look and boss race straight from the client staticdata.
monster.outfit = {
	lookType = 1189,
	lookHead = 95,
	lookBody = 114,
	lookLegs = 94,
	lookFeet = 76,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2106,
	bossRace = RARITY_BANE,
}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "blood"
monster.corpse = 31390 -- the manticore corpse; he is the manticores' boss
monster.speed = 150
monster.manaCost = 0

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
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 4, -- fights from a distance
	runHealth = 0, -- fights to the death
	healthHidden = false,
	isBlockable = true, -- the wiki notes his respawn can be blocked
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

-- The wiki lists the drops by tier only, so the chances below are an estimate.
monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 97 },
	{ name = "crystal coin", chance = 50000 },
	{ name = "manticore ear", chance = 50000 },
	{ name = "springsprout rod", chance = 20000 },
	{ name = "terra boots", chance = 20000 },
	{ name = "terra rod", chance = 20000 },
	{ name = "violet gem", chance = 20000 },
	{ id = 23533, chance = 5000 }, -- ring of red plasma; 23534 is the same ring while worn
	{ name = "sacred tree amulet", chance = 5000 },
	{ name = "spellbook of warding", chance = 5000 },
}

-- The wiki lists no abilities beyond ranged combat, so these follow the Manticore he leads,
-- scaled up for a boss.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -600, length = 8, spread = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -550, radius = 3, shootEffect = CONST_ANI_ENVENOMEDARROW, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_FIREDAMAGE, minDamage = -550, maxDamage = -700, range = 4, shootEffect = CONST_ANI_BURSTARROW, target = true },
}

monster.defenses = {
	defense = 78,
	armor = 78,
	mitigation = 2.16,
}

-- Takes 80% from fire and full damage from everything else.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
