-- "Stronger" form from the Court Warlock fight (The Order of the Stag).
-- W: 4 of the same type alive turn into a stronger version; V: "full color version". Name, health (50,000),
-- damage (x1.5) and colours are NOT CONFIRMED: copy of raging_raubritter.lua.
local mType = Game.createMonsterType("Empowered Raging Raubritter")
local monster = {}

monster.name = "Empowered Raging Raubritter"
monster.description = "an empowered raging raubritter"
monster.experience = 0
monster.outfit = {
	lookType = 1900,
	lookHead = 113,
	lookBody = 113,
	lookLegs = 113,
	lookFeet = 113,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 50000
monster.maxHealth = 50000
monster.race = "undead"
monster.corpse = 0
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
	{ text = "IT BURNS... MASTER.", yell = false },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 300, maxDamage = -1500 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1200, maxDamage = -1800, target = false, radius = 3, effect = CONST_ME_BLOOD_RAIN },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1200, maxDamage = -1800, range = 7, radius = 3, effect = CONST_ME_YELLOWENERGY, shootEffect = CONST_ANI_BURSTARROW, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1500, range = 7, radius = 1, effect = CONST_ME_HITBYFIRE, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "fire chain", interval = 2000, chance = 15, minDamage = -900, maxDamage = -2250 },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	mitigation = 2.31,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
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
