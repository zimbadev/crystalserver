local mType = Game.createMonsterType("Norcferatu Nightweaver")
local monster = {}

monster.description = "a norcferatu nightweaver"
monster.experience = 4900
monster.outfit = {
	lookType = 1851,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2666
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

monster.health = 6100
monster.maxHealth = 6100
monster.race = "undead"
monster.corpse = 51529
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
	{ text = "Darkness shall engulf you!", yell = false },
	{ text = "See the shadows lurking!", yell = false },
	{ text = "Fear the night!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 60000, minCount = 1, maxCount = 25 },
	{ name = "strong mana potion", chance = 2800, minCount = 1, maxCount = 3 },
	{ name = "piece of frozen night", chance = 2500 }, -- new item
	{ name = "blood hood", chance = 2200 }, -- new item
	{ name = "magma amulet", chance = 2000 },
	{ name = "rainbow quartz", chance = 1800, minCount = 1, maxCount = 2 },
	{ id = 6299, chance = 1400 }, -- death ring
	{ name = "wand of defiance", chance = 1200 },
	{ name = "greater garlic necklace", chance = 1200 }, -- new item
	{ id = 51487, chance = 1000 }, -- new item // norcferatu talisman
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_DEATHDAMAGE, minDamage = -370, maxDamage = -410, range = 7, radius = 3, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -320, maxDamage = -350, range = 1, effect = CONST_ME_REAPER, target = true },
	{ name = "combat", interval = 2000, chance = 13, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -450, range = 5, radius = 5, effect = CONST_ME_MELTING_CREAM, target = false },
}

monster.defenses = {
	defense = 88,
	armor = 60,
	mitigation = 1.76,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
