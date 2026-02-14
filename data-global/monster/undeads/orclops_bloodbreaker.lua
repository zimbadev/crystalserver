local mType = Game.createMonsterType("Orclops Bloodbreaker")
local monster = {}

monster.description = "an orclops bloodbreaker"
monster.experience = 7800
monster.outfit = {
	lookType = 1854,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2668
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Norcferatu Dungeons, Norcferatu Fortress.",
}

monster.health = 10300
monster.maxHealth = 10300
monster.race = "venom"
monster.corpse = 51538
monster.speed = 130
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	canPushCreatures = false,
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
	{ text = "More ... blood!", yell = false },
	{ text = "Giiiive meee bloood!", yell = false },
	{ text = "Must ... crush ... bones!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 60000, minCount = 1, maxCount = 30 },
	{ name = "orcish axe", chance = 2800 },
	{ name = "orcish toothbrush", chance = 2600 }, -- new item
	{ name = "bone fibula", chance = 2400 }, -- new item
	{ name = "green gem", chance = 2200 },
	{ name = "vampire teeth", chance = 2000 },
	{ name = "green crystal shard", chance = 1800 },
	{ name = "bone toothpick", chance = 1600 },
	{ name = "bloodshot giant eye", chance = 1600 }, -- new item
	{ name = "war drum", chance = 1400 },
	{ name = "stone skin amulet", chance = 1200 },
	{ name = "berserk potion", chance = 800 },
	{ id = 51487, chance = 800 }, -- norcferatu talisman
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -260, maxDamage = -785 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -430, maxDamage = -1170, range = 5, effect = CONST_ME_SPIKES, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -450, range = 5, radius = 5, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 98,
	armor = 68,
	mitigation = 2.05,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
