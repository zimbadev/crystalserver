local mType = Game.createMonsterType("Gorger Inferniarch")
local monster = {}

monster.description = "a gorger inferniarch"
monster.experience = 7680
monster.outfit = {
	lookType = 1797,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2604
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

monster.health = 9450
monster.maxHealth = 9450
monster.race = "undead"
monster.corpse = 50010
monster.speed = 160
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
	chance = 20,
	{ text = "Kar Ath... Ul", yell = true },
	{ text = "Rezzz Kor ... Urrrgh!", yell = true },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 16500, maxCount = 40 },
	{ name = "Demonic Core Essence", chance = 1000, maxCount = 1 },
	{ name = "Small Sapphire", chance = 12500, maxCount = 5 },
	{ name = "Gorger Antlers", chance = 9300, maxCount = 1 },
	{ name = "Spiked Squelcher", chance = 14500, maxCount = 1 },
	{ name = "Mummified Demon Finger", chance = 1500, maxCount = 1 },
	{ name = "Demonic Matter", chance = 1000, maxCount = 1 },
	{ name = "Spiked Squelcher", chance = 14500, maxCount = 1 },
	{ id = 3053, chance = 5000, maxCount = 1 }, -- Time ring
	{ id = 3040, chance = 5000, maxCount = 1 }, -- gold nugget
	{ id = 3093, chance = 5000, maxCount = 1 }, -- club ring
	--{ name = "gorger inferniarch soul core", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 150, maxDamage = -300 },
	{ name = "extended electrify chain", interval = 2000, chance = 15, minDamage = -130, maxDamage = -438, range = 7 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1, maxDamage = -450, range = 1, effect = CONST_ME_REAPER, target = true },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1, maxDamage = -450, radius = 4, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 74,
	armor = 74,
	mitigation = 1.99,
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_HEALING, minDamage = 400, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 1000, chance = 35, type = COMBAT_HEALING, minDamage = 0, maxDamage = 0, effect = CONST_ME_MAGIC_POWDER, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
