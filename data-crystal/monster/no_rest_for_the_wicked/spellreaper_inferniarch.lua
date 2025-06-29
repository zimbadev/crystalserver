local mType = Game.createMonsterType("Spellreaper Inferniarch")
local monster = {}

monster.description = "a spellreaper inferniarch"
monster.experience = 9750
monster.outfit = {
	lookType = 1792,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2605
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Azzilon Castle.",
}

monster.health = 11800
monster.maxHealth = 11800
monster.race = "undead"
monster.corpse = 49990
monster.speed = 180
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyable = true,
	isPreyExclusive = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "CHA..RAK!", yell = true },
	{ text = "Garrr!", yell = true },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 26500, maxCount = 40 },
	{ name = "Onyx Arrow", chance = 24500, maxCount = 25 },
	{ name = "Sniper Arrow", chance = 24500, maxCount = 15 },
	{ name = "Assassin Star", chance = 24500, maxCount = 25 },
	{ name = "Small Amethyst", chance = 24500, maxCount = 5 },
	{ name = "Dark Helmet", chance = 12500, maxCount = 1 },
	{ id = 6299, chance = 3500, maxCount = 1 },
	{ name = "Demonic Core Essence", chance = 3000, maxCount = 1 },
	{ name = "Cyan Crystal Fragment", chance = 14500, maxCount = 5 },
	{ name = "Mummified Demon Finger", chance = 3000, maxCount = 1 },
	{ name = "Demonic Matter", chance = 3000, maxCount = 1 },
	{ id = 50054, chance = 2500, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 0, minDamage = 250, maxDamage = -400 },
	{ name = "extended white chain", interval = 2000, chance = 15, minDamage = -275, maxDamage = -438, range = 4 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -250, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_DRAWBLOOD, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -350, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = true },
}

monster.defenses = {
	defense = 74,
	armor = 74,
	mitigation = 2.13,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
