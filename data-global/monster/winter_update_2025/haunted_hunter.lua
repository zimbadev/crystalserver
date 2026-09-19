local mType = Game.createMonsterType("Haunted Hunter")
local monster = {}

monster.description = "a haunted hunter"
monster.experience = 19500
monster.outfit = {
	lookType = 1889,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2762
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Outer Crypt.",
}

monster.health = 23000
monster.maxHealth = 23000
monster.race = "undead"
monster.corpse = 52571
monster.speed = 240
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Bone Bear", chance = 100, interval = 4000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Uhhhh", yell = false },
	{ text = "<rattle>", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 38260 },
	{ name = "deadly fangs", chance = 5760 },
	{ name = "small sapphire", chance = 4990, maxCount = 15 },
	{ name = "cyan crystal fragment", chance = 4420, maxCount = 4 },
	{ name = "toe nails", chance = 2520 },
	{ name = "blue crystal shard", chance = 2330, maxCount = 4 },
	{ name = "crystallized death", chance = 2240 },
	{ name = "crystalline armor", chance = 1920 },
	{ name = "blue gem", chance = 1880, maxCount = 4 },
	{ name = "crystal crossbow", chance = 1020 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -750, maxDamage = -1200, length = 6, effect = CONST_ME_WHITE_ENERGYPULSE, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -750, maxDamage = -1200, distance = 4, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -900, radius = 3, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 90,
	armor = 90,
	mitigation = 3.04,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -3 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -6 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 9 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -9 },
	{ type = COMBAT_HOLYDAMAGE, percent = 6 },
	{ type = COMBAT_DEATHDAMAGE, percent = -12 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
