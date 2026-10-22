-- Grave Danger: new creature (base: opentibiabr/canary); health/melee from TibiaWiki (W), spells NOT CONFIRMED (Canary)
local mType = Game.createMonsterType("Tainted Soul Splinter")
local monster = {}

monster.description = "a tainted soul splinter"
monster.experience = 0
monster.outfit = {
	lookType = 1219,
	lookHead = 94,
	lookBody = 94,
	lookLegs = 94,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 10000 -- NOT CONFIRMED (Canary)
monster.maxHealth = 10000 -- NOT CONFIRMED (Canary)
monster.race = "undead"
monster.corpse = 31160 -- W: becomes a Cleansed Soul Splinter
monster.speed = 200
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 20,
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
	canPushCreatures = false,
	staticAttackChance = 95,
	targetDistance = 0,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.defenses = {
	defense = 40,
	armor = 40,
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
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

monster.events = {}

mType:register(monster)
