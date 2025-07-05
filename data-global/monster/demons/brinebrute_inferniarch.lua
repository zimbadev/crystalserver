local mType = Game.createMonsterType("Brinebrute Inferniarch")
local monster = {}

monster.description = "a brinebrute inferniarch"
monster.experience = 20300
monster.outfit = {
	lookType = 1794,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2601
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

monster.health = 32000
monster.maxHealth = 32000
monster.race = "undead"
monster.corpse = 49998
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
	chance = 10,
	{ text = "Garrr...Garrr!", yell = true },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 16500, maxCount = 40 },
	{ name = "Brinebrute Claw", chance = 18500, maxCount = 1 },
	{ name = "great spirit potion", chance = 11500, maxCount = 15 },
	{ name = "Blue Crystal Shard", chance = 12500, maxCount = 2 },
	{ name = "Green Crystal Shard", chance = 13500, maxCount = 2 },
	{ name = "Violet Crystal Shard", chance = 12500, maxCount = 2 },
	{ name = "Small Sapphire", chance = 12500, maxCount = 2 },
	{ name = "Blue Crystal Splinter", chance = 14500, maxCount = 2 },
	{ name = "Green Crystal Splinter", chance = 14500, maxCount = 2 },
	{ name = "Brown Crystal Splinter", chance = 14500, maxCount = 2 },
	{ id = 3039, chance = 5000, maxCount = 1 }, -- Red gem
	{ name = "Ultimate Health Potion", chance = 5500, maxCount = 10 },
	{ name = "Demonic Core Essence", chance = 1500, maxCount = 1 },
	{ name = "Demonic Matter", chance = 1500, maxCount = 1 },
	{ name = "Bloodstained Scythe", chance = 2500, maxCount = 1 },
	{ name = "Giant Sword", chance = 4000, maxCount = 1 },
	{ name = "Green Gem", chance = 3000, maxCount = 1 },
	{ name = "Might ring", chance = 1000, maxCount = 1 },
	{ id = 3100, chance = 5000, maxCount = 1 }, -- Ring of Healing
	{ name = "Mummified Demon Finger", chance = 500, maxCount = 1 },
	{ name = "Gold Ring", chance = 500, maxCount = 1 },
	--{ name = "brinebrute inferniarch soul core", chance = 100, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "extended electrify chain", interval = 2000, chance = 15, minDamage = -3, maxDamage = -400, range = 7 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -390, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1, maxDamage = -450, range = 1, effect = CONST_ME_REAPER, target = true },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1, maxDamage = -450, radius = 5, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	mitigation = 2.45,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
