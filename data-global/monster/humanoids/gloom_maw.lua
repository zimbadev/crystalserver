local mType = Game.createMonsterType("Gloom Maw")
local monster = {}

monster.description = "a gloom maw"
monster.experience = 6900
monster.outfit = {
	lookType = 1867,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2669
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "Norcferatu Dungeons, Norcferatu Fortress.",
}

monster.health = 8700
monster.maxHealth = 8700
monster.race = "venom"
monster.corpse = 51584
monster.speed = 190
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
	{ text = "Coo?", yell = false },
	{ text = "Sniff, sniff.", yell = false },
	{ text = "Chipper!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60590, maxCount = 100 },
	{ name = "platinum coin", chance = 40590, maxCount = 25 },
	{ name = "chain leash", chance = 5590 }, -- new item
	{ name = "black pearl", chance = 3030 },
	{ name = "piece of frozen night", chance = 2500 }, -- new item
	{ id = 3039, chance = 1500 }, -- red gem
	{ name = "black shield", chance = 1400 },
	{ name = "bat wing", chance = 1560, maxCount = 3 },
	{ name = "stone skin amulet", chance = 1540 },
	{ name = "batwing hat", chance = 1000 },
	{ id = 51470, chance = 1000 }, -- tiny bat coffin
	{ id = 51487, chance = 800 }, -- new item // norcferatu talisman
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -380, maxDamage = -450, range = 5, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_HITBYPOISON, target = true },
	{ name = "dark blood wave", interval = 2000, chance = 12, minDamage = -400, maxDamage = -500, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -450, maxDamage = -490, range = 1, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -120, maxDamage = -130, range = 5, radius = 2, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_SOUND_PURPLE, target = true },
}

monster.defenses = {
	defense = 88,
	armor = 68,
	mitigation = 1.76,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
