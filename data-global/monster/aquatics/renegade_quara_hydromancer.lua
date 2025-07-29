local mType = Game.createMonsterType("Renegade Quara Hydromancer")
local monster = {}

monster.description = "a renegade quara hydromancer"
monster.experience = 1800
monster.outfit = {
	lookType = 47,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1098
monster.Bestiary = {
	class = "Aquatic",
	race = BESTY_RACE_AQUATIC,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 2,
	Locations = "Seacrest Grounds when Seacrest Serpents are not spawning.",
}

monster.health = 2000
monster.maxHealth = 2000
monster.race = "blood"
monster.corpse = 6066
monster.speed = 245
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
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
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = false,
	isPreyExclusive = true,
}

monster.light = {
	level = 2,
	color = 35,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 80380, maxCount = 4 },
	{ name = "quara eye", chance = 18430 },
	{ name = "mind stone", chance = 10390 },
	{ name = "shrimp", chance = 7380 },
	{ name = "small topaz", chance = 6450, maxCount = 2 },
	{ name = "small emerald", chance = 7050, maxCount = 2 },
	{ name = "great mana potion", chance = 5490, maxCount = 2 },
	{ name = "spirit cloak", chance = 5000 },
	{ name = "great health potion", chance = 5060, maxCount = 2 },
	{ name = "yellow piece of cloth", chance = 2580 },
	{ name = "green crystal shard", chance = 2980 },
	{ name = "green piece of cloth", chance = 2910 },
	{ id = 3052, chance = 1850 }, -- life ring
	{ name = "fish fin", chance = 1420 },
	{ id = 281, chance = 1320 }, -- giant shimmering pearl (green)
	{ name = "wand of cosmic energy", chance = 930 },
	{ name = "green gem", chance = 430 },
	{ name = "knight armor", chance = 760 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 110, attack = 90, effect = CONST_ME_DRAWBLOOD, condition = { type = CONDITION_POISON, totalDamage = 5, interval = 4000 } },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -350, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },
}

monster.defenses = {
	defense = 15,
	armor = 30,
	mitigation = 1.04,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 100, maxDamage = 120, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
