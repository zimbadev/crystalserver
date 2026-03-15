local mType = Game.createMonsterType("Shell Drake")
local monster = {}

monster.description = "a shell drake"
monster.experience = 2370
monster.outfit = {
	lookType = 1857,
	lookHead = 0,
	lookBody = 80,
	lookLegs = 86,
	lookFeet = 78,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 2675
monster.Bestiary = {
	class = "Inkborn",
	race = BESTY_RACE_INKBORN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Crumbling Caverns.",
}

monster.health = 2800
monster.maxHealth = 2800
monster.race = "ink"
monster.corpse = 51556
monster.speed = 90
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
	{ text = "Chrrrr!", yell = false },
	{ text = "Kraaaah!", yell = false },
	{ text = "Screak!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60000, minCount = 1, maxCount = 150 },
	{ name = "platinum coin", chance = 45000, minCount = 1, maxCount = 8 },
	{ name = "paper plane", chance = 2800 }, -- new item
	{ name = "great mana potion", chance = 2000 },
	{ name = "small enchanted amethyst", chance = 1800 },
	{ name = "spiked squelcher", chance = 1600 },
	{ name = "violet crystal shard", chance = 1500 },
	{ name = "cave turnip", chance = 1400 },
	{ name = "prismatic quartz", chance = 1200 },
	{ name = "blank imbuement scroll", chance = 1200 },
	{ name = "warrior's shield", chance = 800 },
}

monster.attacks = {
	-- Physical: Stone Shower (220-260)
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -220, maxDamage = -260, radius = 4, effect = CONST_ME_STONES, target = false },
	-- Physical: Explosion (Circle 7x7)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -350, radius = 3, effect = CONST_ME_EXPLOSIONHIT, target = false },
	-- Fire: Strike (200-280)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -280, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 68,
	armor = 43,
	mitigation = 1.04,
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
