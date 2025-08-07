local mType = Game.createMonsterType("Black Knight")
local monster = {}

monster.description = "Black Knight"
monster.experience = 1600
monster.outfit = {
	lookType = 131,
	lookHead = 95,
	lookBody = 95,
	lookLegs = 95,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.events = {
	"BlackKnightDeath",
}

monster.bosstiary = {
	bossRaceId = 46,
	bossRace = RARITY_BANE,
}

monster.health = 1800
monster.maxHealth = 1800
monster.race = "blood"
monster.corpse = 18074
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
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
	{ text = "NO PRISONERS!", yell = true },
	{ text = "By Bolg's blood!", yell = false },
	{ text = "You're no match for me!", yell = false },
	{ text = "NO MERCY!", yell = true },
	{ text = "MINE!", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 48680, maxCount = 136 },
	{ name = "spear", chance = 29510, maxCount = 3 },
	{ name = "brown bread", chance = 20330, maxCount = 2 },
	{ id = 3003, chance = 14370 }, -- rope
	{ name = "brass legs", chance = 13050 },
	{ name = "halberd", chance = 12580 },
	{ name = "plate armor", chance = 10930 },
	{ name = "steel helmet", chance = 10400 },
	{ name = "two handed sword", chance = 9570 },
	{ name = "battle hammer", chance = 6950 },
	{ name = "warrior helmet", chance = 4710 },
	{ name = "knight axe", chance = 2650 },
	{ name = "dark helmet", chance = 2400 },
	{ name = "dark armor", chance = 2010 },
	{ name = "knight legs", chance = 1030 },
	{ name = "knight armor", chance = 750 },
	{ name = "ruby necklace", chance = 730 },
	{ name = "lightning legs", chance = 590 },
	{ name = "boots of haste", chance = 390 },
	{ name = "dragon lance", chance = 310 },
	{ name = "piggy bank", chance = 110 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, range = 7, shootEffect = CONST_ANI_SPEAR, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 42,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 80 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 95 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -8 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
