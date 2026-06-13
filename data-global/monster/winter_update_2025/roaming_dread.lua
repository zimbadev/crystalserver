local mType = Game.createMonsterType("Roaming Dread")
local monster = {}

monster.description = "a roaming dread"
monster.experience = 12040
monster.outfit = {
	lookType = 1904,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2765
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Forsaken Crypt.",
}

monster.health = 14500
monster.maxHealth = 14500
monster.race = "undead"
monster.corpse = 52559
monster.speed = 190
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
}

monster.loot = {
	{ name = "platinum coin", chance = 23870, minCount = 10, maxCount = 20 },
	{ name = "crystal coin", chance = 11370 },
	{ name = "green crystal fragment", chance = 4970, maxCount = 4 },
	{ name = "crystallized death", chance = 4290 },
	{ name = "small emerald", chance = 3010, maxCount = 15 },
	{ name = "toe nails", chance = 2480 },
	{ name = "green crystal shard", chance = 1730, maxCount = 4 },
	{ name = "jade hammer", chance = 1510 },
	{ name = "necromantic core", chance = 900 },
	{ name = "crystal mace", chance = 830 },
	{ name = "crystalline armor", chance = 830 },
	{ name = "green gem", chance = 150, minCount = 2, maxCount = 4 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -700 },
	{ name = "Roaming Physical Ring", interval = 2000, chance = 30, minDamage = -300, maxDamage = -1050, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -250, maxDamage = -1300, range = 1, effect = CONST_ME_REAPER, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -900, maxDamage = -1480, range = 3, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
}

monster.defenses = {
	defense = 120,
	armor = 120,
	mitigation = 2.75,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -9 },
	{ type = COMBAT_EARTHDAMAGE, percent = -9 },
	{ type = COMBAT_FIREDAMAGE, percent = -9 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -9 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -18 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
