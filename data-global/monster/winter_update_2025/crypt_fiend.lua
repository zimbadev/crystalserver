local mType = Game.createMonsterType("Crypt Fiend")
local monster = {}

monster.description = "a crypt fiend"
monster.experience = 22500
monster.outfit = {
	lookType = 1885,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2758
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 5000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Unhallowed Crypt.",
}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "undead"
monster.corpse = 52555
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "crystal coin", chance = 33540 },
	{ name = "cyan crystal fragment", chance = 5580, maxCount = 4 },
	{ name = "small sapphire", chance = 4960, maxCount = 15 },
	{ name = "giant tusk", chance = 4600 },
	{ name = "crystallized death", chance = 2570 },
	{ name = "blue crystal shard", chance = 1860, maxCount = 4 },
	{ name = "necromantic core", chance = 1770 },
	{ name = "amber", chance = 1590 },
	{ name = "amber with a bug", chance = 1150 },
	{ name = "cluster of crystallized death", chance = 1150 },
	{ name = "blue gem", chance = 530, maxCount = 3 },
	{ name = "amber with a dragonfly", chance = 440 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -1100, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -550, maxDamage = -900, range = 7, radius = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -700, radius = 5, effect = CONST_ME_STONE_STORM, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -1200, radius = 6, effect = CONST_ME_LOSEENERGY, target = false },
}

monster.defenses = {
	defense = 140,
	armor = 140,
	mitigation = 2.75,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -6 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -12 },
	{ type = COMBAT_FIREDAMAGE, percent = -9 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 9 },
	{ type = COMBAT_HOLYDAMAGE, percent = -3 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
