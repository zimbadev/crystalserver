local mType = Game.createMonsterType("Norcferatu Heartless")
local monster = {}

monster.description = "a norcferatu heartless"
monster.experience = 4450
monster.outfit = {
	lookType = 1852,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2664
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

monster.health = 5700
monster.maxHealth = 5700
monster.race = "undead"
monster.corpse = 51533
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
	{ text = "Your essence will be mine!", yell = false },
	{ text = "I will feast on you!", yell = false },
	{ text = "Bloood!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 60000, minCount = 1, maxCount = 20 },
	{ name = "green crystal splinter", chance = 2800 },
	{ name = "heart amphora", chance = 2500 }, -- new item
	{ name = "vampire teeth", chance = 2000 },
	{ name = "brown crystal splinter", chance = 1800 },
	{ name = "blue crystal splinter", chance = 1600 },
	{ name = "pot of orcish warpaint", chance = 1500 }, -- new item
	{ name = "war axe", chance = 1400 },
	{ name = "chaos mace", chance = 1200 },
	{ name = "greater garlic necklace", chance = 1200 }, -- new item
	{ id = 51487, chance = 800 }, -- norcferatu talisman
	{ name = "vampire shield", chance = 800 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -150, maxDamage = -480, effect = CONST_ME_DRAWBLOOD, target = true },
	{ name = "clouds chain", interval = 2000, chance = 8, minDamage = -100, maxDamage = -380, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -270, maxDamage = -550, range = 5, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -700, radius = 4, effect = CONST_ME_BLOOD_RAIN, target = false },
}

monster.defenses = {
	defense = 78,
	armor = 64,
	mitigation = 1.54,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
