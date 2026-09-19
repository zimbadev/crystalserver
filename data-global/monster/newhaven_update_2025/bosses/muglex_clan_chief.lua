local mType = Game.createMonsterType("Muglex Clan Chief")
local monster = {}

monster.description = "Muglex Clan Chief"
monster.experience = 175
monster.outfit = {
	lookType = 297,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"MorrisGoblinDeath",
	"MuglexKillCount",
}

monster.health = 100
monster.maxHealth = 100
monster.race = "blood"
monster.corpse = 52117
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 20,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = true,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 30,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Me smash you!", yell = false },
	{ text = "Muglex Clan strongest!", yell = true },
	{ text = "You no take our stuff!", yell = false },
}

-- Loot based on statistics (53 kills, avg 86.08 gold)
monster.loot = {
	{ id = 3031, chance = 100000, minCount = 10, maxCount = 50 }, -- gold coin (100%)
	{ id = 7618, chance = 54720, minCount = 1, maxCount = 2 }, -- health potion (54.72%)
	{ id = 3578, chance = 24530, minCount = 1, maxCount = 3 }, -- fish (24.53%)
	{ id = 7620, chance = 18870, minCount = 1, maxCount = 3 }, -- mana potion (18.87%)
	{ id = 3277, chance = 16980, minCount = 1, maxCount = 3 }, -- spear (16.98%)
	{ id = 3286, chance = 15090 }, -- mace (15.09%)
	{ id = 3576, chance = 7550 }, -- mage hat (7.55%)
	{ id = 44773, chance = 5660 }, -- refined bow (5.66%)
	{ id = 3059, chance = 5660 }, -- spellbook (5.66%)
	{ id = 3074, chance = 5660 }, -- wand of vortex (5.66%)
	{ id = 3285, chance = 3770 }, -- longsword (3.77%)
	{ id = 7884, chance = 3770 }, -- ranger legs (3.77%)
	{ id = 3003, chance = 3770 }, -- rope (3.77%)
	{ id = 3372, chance = 1890 }, -- brass legs (1.89%)
	{ id = 44775, chance = 1890 }, -- harmony amulet (1.89%)
	{ id = 44772, chance = 1890 }, -- simple jo staff (1.89%)
	{ id = 3066, chance = 1890 }, -- snakebite rod (1.89%)
	{ id = 3409, chance = 1890 }, -- steel shield (1.89%)
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 25, attack = 30 },
	-- Earth damage attacks (as per wiki info about Muglex Clan Chief using earth damage)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -15, maxDamage = -40, range = 5, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_POISONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -20, maxDamage = -45, radius = 3, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -35, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 12,
	mitigation = 0.40,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 15, maxDamage = 30, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
