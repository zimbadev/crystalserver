local mType = Game.createMonsterType("Sugar Daddy")
local monster = {}

monster.description = "Sugar Daddy"
monster.experience = 15550
monster.outfit = {
	lookType = 1764,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 2,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2562,
	bossRace = RARITY_BANE,
}

monster.health = 9500
monster.maxHealth = 9500
monster.race = "candy"
monster.corpse = 48416
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 20,
}

monster.strategiesTarget = {
	nearest = 10,
	health = 0,
	damage = 90,
	random = 0,
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
	staticAttackChance = 98,
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

--monster.summon = {
--maxSummons = 5,
--summons = {
--{ name = "cheeky sugar cube", chance = 18, interval = 2000, count = 5 },
--{ name = "mint drop", chance = 18, interval = 2000, count = 5 },
--{ name = "truffle worker", chance = 18, interval = 2000, count = 5 },
--},
--}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "SUGAR!!!", yell = false },
	{ text = "Sweet vengeance!", yell = false },
	{ text = "Let me have a bite!", yell = false },
	{ text = "YOU HAVE BAD BREATH, TAKE A MINT!!!", yell = false },
	{ text = "I LOOOOOOVE CHOCOLATE TRUFFLES!!!", yell = false },
	{ text = "Yummy!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 100000, minCount = 6, maxCount = 99 },
	{ name = "platinum coin", chance = 100000, minCount = 1, maxCount = 11 },
	{ name = "small enchanted sapphire", chance = 100000 },
	{ id = 3039, chance = 95000, maxCount = 1 }, -- red gem
	{ id = 48249, chance = 49465, maxCount = 20 }, -- milk chocolate coin
	{ id = 48250, chance = 51000, maxCount = 20 }, -- dark chocolate coin
	{ id = 48251, chance = 34000, maxCount = 1 }, -- wafer paper flower
	{ id = 48255, chance = 34000, maxCount = 1 }, -- lime tart
	{ id = 48252, chance = 15300, maxCount = 1 }, -- beijinho
	{ id = 45642, chance = 14650, maxCount = 1 }, -- brigadeiro
	{ id = 48254, chance = 14000, maxCount = 1 }, -- churro heart
	{ id = 45642, chance = 6800 }, -- ring of temptation
	{ name = "white gem", chance = 4700, maxCount = 1 },
	{ id = 48256, chance = 2700, maxCount = 1 }, -- pastry dragon
	{ id = 48114, chance = 380 }, -- peppermint backpack
	{ id = 45643, chance = 190 }, -- biscuit barrier
	{ id = 45639, chance = 190 }, -- cocoa grimoire
	{ id = 45641, chance = 175 }, -- candy necklace
	{ id = 45644, chance = 175 }, -- candy-coated quiver
	{ id = 45640, chance = 180 }, -- creamy grimoire
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -0, maxDamage = -350, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "combat", interval = 6000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -0, maxDamage = -350, range = 6, effect = CONST_ME_MORTAREA, target = true },
	{ name = "drunk", interval = 2000, chance = 10, length = 3, spread = 2, effect = CONST_ME_POFF, target = false, duration = 5000 },
	{ name = "root area", interval = 20000, chance = 100, target = false },
	{ name = "sugar daddy cake", interval = 10000, chance = 50, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 25,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 1, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
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
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
