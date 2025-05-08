local mType = Game.createMonsterType("Bulltaur Alchemist")
local monster = {}

monster.description = "a bulltaur alchemist"
monster.experience = 4350
monster.outfit = {
	lookType = 1718,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2448
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Demonwar Crypt.",
}

monster.health = 5690
monster.maxHealth = 5690
monster.race = "blood"
monster.corpse = 44712
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 60,
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
	staticAttackChance = 80,
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
	chance = 30,
	{ text = "Your misfortune is setteled!", yell = true },
	{ text = "Soon I will harvest you for ingredients!", yell = true },
	{ text = "I have just the solution for this problem!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 5000, maxCount = 6 },
	{ name = "platinum coin", chance = 3533, maxCount = 7 },
	{ id = 44736, chance = 4545 }, -- stealth ring
	{ id = 44737, chance = 4545 }, -- stealth ring
	{ id = 44738, chance = 4545 }, -- stealth ring
	{ name = "might ring", chance = 4285 },
	{ name = "mino shield", chance = 840 },
	{ name = "dragon hammer", chance = 420 },
	{ id = 3041, chance = 4545 }, -- stealth ring
	{ name = "ultimate health potion", chance = 5285 },
	{ name = "great mana potion", chance = 6285 },
	{ name = "alloy legs", chance = 1285 },
	{ name = "encrypted notes", chance = 985 },
	{ name = "ultimate mana potion", chance = 1285 },
	{ name = "gold ingot", chance = 1285 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 90, maxDamage = -390 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -150, maxDamage = -450, range = 3, radius = 4, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -150, maxDamage = -450, range = 3, radius = 4, effect = 170, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 78,
	mitigation = 1.22,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
