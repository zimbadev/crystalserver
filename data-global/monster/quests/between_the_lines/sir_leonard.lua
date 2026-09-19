local mType = Game.createMonsterType("Sir Leonard")
local monster = {}

monster.description = "sir leonard"
monster.experience = 26000
monster.outfit = {
	lookType = 1847,
	lookHead = 0,
	lookBody = 19,
	lookLegs = 100,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2680,
	bossRace = RARITY_BANE,
}

monster.events = {
	"LeonardMonsterDeath", -- EVENT TO REGISTER THE BOSS DEATH FOR BETWEEN THE LINES QUEST
}

monster.health = 22000
monster.maxHealth = 22000
monster.race = "undead"
monster.corpse = 28601
monster.speed = 85
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
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 2,
	color = 132,
}

monster.summon = {
	maxSummons = 5,
	summons = {
		{ name = "crusader guardian", chance = 10, interval = 2000 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "platinum coin", chance = 7500, maxCount = 19 },
	{ name = "bronze amulet", chance = 6000 },
	{ name = "silver amulet", chance = 5000 },
	{ name = "protection amulet", chance = 4800 },
	{ name = "proficiency catalyst", chance = 4000 },
	{ name = "gearwheel chain", chance = 3800 },
	{ name = "knight axe", chance = 3800 },
	{ name = "knight armor", chance = 3800 },
	{ name = "knight legs", chance = 3500 },
	{ name = "helmet of sir leonard", chance = 3200 },
	{ name = "white gem", chance = 3000 },
	{ name = "green gem", chance = 3000 },
	{ name = "blank imbuement scroll", chance = 3000 },
	{ name = "ancient shield", chance = 3000 },
	{ id = 32769, chance = 3000 }, -- white gem
	{ id = 3038, chance = 3000 }, -- green gem
	{ id = 3053, chance = 3000 }, -- time ring
	{ id = 3092, chance = 3000 }, -- axe ring
	{ id = 6299, chance = 3000 }, -- death ring
}

-- missing spells
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -350, range = 5, radius = 2, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICETORNADO, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -250, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 15,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 40, maxDamage = 80, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
