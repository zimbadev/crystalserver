local mType = Game.createMonsterType("Iks Yapunac")
local monster = {}

monster.description = "an iks yapunac"
monster.experience = 2340
monster.outfit = {
	lookType = 1702,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2437
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Iksupan",
}

monster.health = 3125
monster.maxHealth = 3125
monster.race = "blood"
monster.corpse = 42061
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
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
	{ text = "Attahch!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 389 },
	{ id = 281, chance = 7100 }, -- giant shimmering pearl (green)
	{ name = "tiger eye", chance = 6910 },
	{ name = "strong mana potion", chance = 6360, maxCount = 2 },
	{ name = "small sapphire", chance = 5810, maxCount = 3 },
	{ name = "spellbook of enlightenment", chance = 1920 },
	{ name = "opal", chance = 1850 },
	{ name = "gold-brocaded cloth", chance = 1780 },
	{ name = "gold ingot", chance = 960 },
	{ name = "broken iks headpiece", chance = 70 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 70, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -80, maxDamage = -300, radius = 2, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -295, length = 8, spread = 0, effect = CONST_ME_STONE_STORM, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -98, maxDamage = -514, range = 7, radius = 1, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 32,
	mitigation = 2.18,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 51, maxDamage = 71, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
