local mType = Game.createMonsterType("Varg")
local monster = {}

monster.description = "a varg"
monster.experience = 4100
monster.outfit = {
	lookType = 1855,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2665
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Norcferatu Dungeons, Norcferatu Fortress.",
}

monster.health = 5400
monster.maxHealth = 5400
monster.race = "venom"
monster.corpse = 51546
monster.speed = 200
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
	targetDistance = 3,
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
	{ text = "GARRRR!", yell = false },
	{ text = "WHOOOOO!", yell = false },
	{ text = "<Drool>", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 60000, minCount = 1, maxCount = 15 },
	{ name = "onyx arrow", chance = 2800, minCount = 1, maxCount = 10 },
	{ name = "ritual bone knife", chance = 2500 },
	{ id = 281, chance = 2690 }, -- giant shimmering pearl
	{ name = "bat wing", chance = 1800, minCount = 1, maxCount = 5 },
	{ name = "vampire teeth", chance = 1600 },
	{ name = "onyx chip", chance = 1400, minCount = 1, maxCount = 3 },
	{ id = 51487, chance = 1000 }, -- norcferatu talisman
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -280, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -320, range = 5, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_EXPLOSIONAREA, target = true },
	-- Death: Chain (280) (( IM NOT SURE ))
	-- { name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -280, maxDamage = -280, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "blood ring", interval = 2000, chance = 12, minDamage = -230, maxDamage = -300, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -240, maxDamage = -270, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = true },
}

monster.defenses = {
	defense = 88,
	armor = 63,
	mitigation = 1.68,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
