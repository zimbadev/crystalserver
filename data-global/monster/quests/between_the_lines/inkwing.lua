local mType = Game.createMonsterType("Inkwing")
local monster = {}

monster.description = "inkwing"
monster.experience = 17500
monster.outfit = {
	lookType = 1850,
	lookHead = 19,
	lookBody = 95,
	lookLegs = 68,
	lookFeet = 86,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2679,
	bossRace = RARITY_BANE,
}

monster.events = {
	--"PhillipBookMonsterDeath", -- EVENT TO REGISTER THE BOSS DEATH FOR BETWEEN THE LINES QUEST
}

monster.health = 12000
monster.maxHealth = 12000
monster.race = "ink"
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
	maxSummons = 2,
	summons = {
		{ name = "vicious ink splash", chance = 10, interval = 2000 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Gherrp!", yell = false },
	{ text = "Rarrr!", yell = false },
	{ text = "Grawwwk!", yell = false },
}

monster.loot = {
	{ name = "platinum coin", chance = 7500, maxCount = 19 },
	{ name = "proficiency catalyst", chance = 6000 },
	{ name = "dragon ham", chance = 5000, maxCount = 2 },
	{ name = "book with a dragon", chance = 4800 },
	{ name = "strong mana potion", chance = 4000 },
	{ id = 3041, chance = 3000 }, -- blue gem
	{ name = "dragon necklace", chance = 3800 },
	{ id = 3039, chance = 3000 }, -- red gem
	{ name = "strong health potion", chance = 3500 },
	{ name = "wand of dragonbreath", chance = 3200 },
	{ id = 3037, chance = 3000 }, -- yellow gem
	{ name = "dragon shield", chance = 3000 },
	{ name = "blank imbuement scroll", chance = 3000 },
	{ name = "dragon slayer", chance = 3000 },
}

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
