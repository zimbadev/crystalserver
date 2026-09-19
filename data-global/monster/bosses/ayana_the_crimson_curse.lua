local mType = Game.createMonsterType("Ayana the Crimson Curse")
local monster = {}

monster.description = "Ayana the Crimson Curse"
monster.experience = 12400
monster.outfit = {
	lookType = 1647,
	lookHead = 132,
	lookBody = 132,
	lookLegs = 57,
	lookFeet = 76,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 17000
monster.maxHealth = 17000
monster.race = "undead"
monster.corpse = 44039
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2404,
	bossRace = RARITY_NEMESIS,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 800,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 35 },
	{ name = "small ruby", chance = 65120, maxCount = 4 },
	{ name = "magma amulet", chance = 46510 },
	{ name = "moonlight crystals", chance = 37210, maxCount = 4 },
	{ name = "violet gem", chance = 6980 },
	{ name = "demonrage sword", chance = 2330 },
	{ name = "ornate crossbow", chance = 780 },
	{ id = 3090, chance = 26360 }, -- red gem
	{ id = 30059, chance = 14730 }, -- giant ruby
	{ id = 43729, chance = 32560 }, -- werecrocodile tongue
	{ id = 43734, chance = 30230 }, -- golden sun coin
	{ id = 43737, chance = 14730 }, -- sun brooch
	{ id = 43738, chance = 17830 }, -- closed pocket sundial
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -185, maxDamage = -550 },
	{ name = "combat", interval = 1000, chance = 8, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -350, radius = 9, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 3000, chance = 13, type = COMBAT_FIREDAMAGE, minDamage = -230, maxDamage = -350, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = 244, target = true },
	{ name = "combat", interval = 3000, chance = 8, type = COMBAT_HOLYDAMAGE, minDamage = -250, maxDamage = -930, radius = 10, effect = 246, target = false },
}

monster.defenses = {
	defense = 110,
	armor = 110,
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 1652, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 90 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
