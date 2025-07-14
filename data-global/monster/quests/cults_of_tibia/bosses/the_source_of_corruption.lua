local mType = Game.createMonsterType("The Source of Corruption")
local monster = {}

monster.description = "The Source Of Corruption"
monster.experience = 0
monster.outfit = {
	lookType = 979,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"CultsOfTibiaBossDeath",
}

monster.bosstiary = {
	bossRaceId = 1500,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "undead"
monster.corpse = 23567
monster.speed = 60
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 20,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 95,
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
}

monster.loot = {
	{ id = 3031, chance = 100000, maxCount = 200 }, -- gold coin
	{ id = 3035, chance = 100000, maxCount = 30 }, -- platinum coin
	{ id = 5888, chance = 100000, maxCount = 5 }, -- piece of hell steel
	{ id = 5904, chance = 100000 }, -- magic sulphur
	{ id = 22721, chance = 100000, maxCount = 4 }, -- gold token
	{ id = 22516, chance = 100000, maxCount = 3 }, -- silver token
	{ id = 22193, chance = 100000 }, -- onyx chip
	{ id = 9632, chance = 100000 }, -- ancient stone
	{ id = 23517, chance = 69490, maxCount = 11 }, -- solid rage
	{ id = 7643, chance = 62710, maxCount = 5 }, -- ultimate health potion
	{ id = 7642, chance = 62710, maxCount = 8 }, -- great spirit potion
	{ id = 23507, chance = 59320, maxCount = 10 }, -- crystallized anger
	{ id = 238, chance = 57630, maxCount = 5 }, -- great mana potion
	{ id = 3037, chance = 30510 }, -- yellow gem
	{ id = 9057, chance = 28810, maxCount = 20 }, -- small topaz
	{ id = 3038, chance = 27120 }, -- green gem
	{ id = 9058, chance = 27120 }, -- gold ingot
	{ id = 3033, chance = 23730, maxCount = 33 }, -- small amethyst
	{ id = 3039, chance = 23730 }, -- red gem
	{ id = 3030, chance = 22030, maxCount = 20 }, -- small ruby
	{ id = 3029, chance = 20340, maxCount = 20 }, -- small sapphire
	{ id = 5909, chance = 20340, maxCount = 4 }, -- white piece of cloth
	{ id = 22194, chance = 18640, maxCount = 2 }, -- opal
	{ id = 281, chance = 16950 }, -- giant shimmering pearl
	{ id = 24392, chance = 16950 }, -- gemmed figurine
	{ id = 23533, chance = 15250 }, -- ring of red plasma
	{ id = 5906, chance = 13560 }, -- demon dust
	{ id = 7437, chance = 13560 }, -- sapphire hammer
	{ id = 3041, chance = 11860 }, -- blue gem
	{ id = 5891, chance = 10170 }, -- enchanted chicken wing
	{ id = 3324, chance = 10170 }, -- skull staff
	{ id = 3036, chance = 6780 }, -- violet gem
	{ id = 3032, chance = 5080, maxCount = 23 }, -- small emerald
	{ id = 16120, chance = 3390, maxCount = 7 }, -- violet crystal shard
	{ id = 3356, chance = 3390 }, -- devil helmet
	{ id = 8029, chance = 3390 }, -- silkweaver bow
	{ id = 20068, chance = 3390 }, -- umbral slayer
	{ id = 3340, chance = 1690 }, -- heavy mace
	{ id = 8098, chance = 1690 }, -- demonwing axe
	{ id = 9068, chance = 1690 }, -- yalahari figurine
	{ id = 236, chance = 80000, maxCount = 2 }, -- strong health potion
	{ id = 239, chance = 80000, maxCount = 3 }, -- great health potion
	{ id = 7418, chance = 1780 }, -- nightmare blade
	{ id = 20067, chance = 8280 }, -- crude umbral slayer
	{ id = 22866, chance = 980, maxCount = 1 }, -- rift bow
	{ id = 25360, chance = 6315 }, -- heart of the mountain
	{ id = 25361, chance = 7050 }, -- blood of the mountain
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "source of corruption wave", interval = 2000, chance = 15, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	--	mitigation = ???,
}

monster.reflects = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 15 },
	{ type = COMBAT_MANADRAIN, percent = 15 },
	{ type = COMBAT_DROWNDAMAGE, percent = 15 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
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
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
