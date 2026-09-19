local mType = Game.createMonsterType("Nibblemaw")
local monster = {}

monster.description = "a nibblemaw"
monster.experience = 2700
monster.outfit = {
	lookType = 1737,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {}

monster.raceId = 2531
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Chocolate Mines.",
}

monster.health = 2900
monster.maxHealth = 2900
monster.race = "candy"
monster.corpse = 48260
monster.speed = 118
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
	canWalkOnEnergy = false,
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
	{ text = "*chomp* Mmmoh! *chomp*", yell = false },
	{ text = "Mwaaahgod! Overmwaaaaah!!", yell = false },
	{ text = "*gurgle*", yell = true },
	{ text = "Mmmwahmwahmwhah, mwaaah!", yell = false },
}

monster.loot = {
	{ name = "Gold Coin", chance = 100000, maxCount = 100 },
	{ name = "Platinum Coin", chance = 74190, maxCount = 6 },
	{ name = "Strong Health Potion", chance = 34320, maxCount = 1 },
	{ name = "Frazzle Tongue", chance = 10730, maxCount = 1 },
	{ name = "Frazzle Skin", chance = 7640, maxCount = 1 },
	{ name = "Onyx Chip", chance = 6809, maxCount = 3 },
	{ name = "Yellow Gem", chance = 5700, maxCount = 1 },
	{ name = "Gummy Rotworm", chance = 4830, maxCount = 2 },
	{ name = "Red Crystal Fragment", chance = 3440, maxCount = 1 },
	{ name = "Melon", chance = 1500, maxCount = 1 },
	{ name = "Raspberry", chance = 1270, maxCount = 2 },
	{ name = "Lime Tart", chance = 950, maxCount = 1 },
	{ name = "Dark Chocolate Coin", chance = 750, maxCount = 64 },
	{ name = "Assassin Dagger", chance = 440, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -252 },
	{ name = "nibblemaw wave", interval = 2000, chance = 20, minDamage = -152, maxDamage = -352 },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -150, radius = 4, effect = CONST_ME_STONES, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -150, radius = 4, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -150, range = 7, shootEffect = CONST_ANI_POISON, target = true },
	{ name = "combat", interval = 2000, chance = 19, type = COMBAT_DEATHDAMAGE, minDamage = -152, maxDamage = -300, range = 7, effect = CONST_ME_MORTAREA, shootEffect = CONST_ANI_SUDDENDEATH, target = true },
}

monster.defenses = {
	defense = 48,
	armor = 48,
	mitigation = 1.10,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
