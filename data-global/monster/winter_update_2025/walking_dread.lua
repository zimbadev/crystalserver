local mType = Game.createMonsterType("Walking Dread")
local monster = {}

monster.description = "a walking dread"
monster.experience = 18000
monster.outfit = {
	lookType = 1886,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2759
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

monster.health = 25000
monster.maxHealth = 25000
monster.race = "undead"
monster.corpse = 52559
monster.speed = 225
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Haaarrgh!", yell = false },
	{ text = "Uuuhmmm!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 38990 },
	{ name = "cyan crystal fragment", chance = 6150, maxCount = 4 },
	{ name = "small sapphire", chance = 5100, maxCount = 15 },
	{ name = "blue crystal shard", chance = 4370, maxCount = 4 },
	{ name = "toe nails", chance = 2730 },
	{ name = "crystallized death", chance = 1890 },
	{ name = "blue gem", chance = 1020, maxCount = 4 },
	{ name = "necromantic core", chance = 770 },
	{ name = "relic sword", chance = 370 },
	{ name = "abyss hammer", chance = 270 },
	{ name = "onyx flail", chance = 200 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -800 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -750, maxDamage = -1200, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -750, maxDamage = -1200, radius = 5, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -900, radius = 6, effect = CONST_ME_LOSEENERGY, target = false },
}

monster.defenses = {
	defense = 120,
	armor = 120,
	mitigation = 2.75,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -9 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -9 },
	{ type = COMBAT_EARTHDAMAGE, percent = 8 },
	{ type = COMBAT_FIREDAMAGE, percent = 12 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -12 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -3 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
