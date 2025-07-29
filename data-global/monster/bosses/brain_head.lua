local mType = Game.createMonsterType("Brain Head")
local monster = {}

monster.description = "Brain Head"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 32418,
}

monster.health = 75000
monster.maxHealth = monster.health
monster.race = "undead"
monster.corpse = 32272
monster.speed = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 1862,
	bossRace = RARITY_ARCHFOE,
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
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.loot = {
	{ name = "crystal coin", chance = 100000, maxCount = 2 },
	{ name = "white gem", chance = 44440, maxCount = 2 },
	{ name = "supreme health potion", chance = 44440, maxCount = 6 },
	{ name = "ultimate spirit potion", chance = 44440, maxCount = 6 },
	{ name = "diamond", chance = 44440, maxCount = 1 },	
	{ name = "berserk potion", chance = 33330 },
	{ name = "cursed bone", chance = 33330 },
	{ name = "bullseye potion", chance = 22220, maxCount = 10 },
	{ name = "mastermind potion", chance = 22220, maxCount = 10 },
	{ name = "silver hand mirror", chance = 22220 },
	{ name = "ultimate mana potion", chance = 11110, maxCount = 6 },		
	{ name = "death toll", chance = 11110 },	
	{ name = "ivory comb", chance = 11110 },
	{ name = "angel figurine", chance = 11110 },
	{ name = "giant amethyst", chance = 11110 },
	{ name = "green gem", chance = 10110, maxCount = 2 },
	{ name = "moonstone", chance = 12810 },
	{ name = "giant topaz", chance = 12280, maxCount = 1 },
	{ name = "ghost claw", chance = 3700 },
	{ id = 32621, chance = 3200 }, -- ring of souls
	{ name = "phantasmal axe", chance = 3700 },
	{ name = "brain head's giant neuron", chance = 3100 },
	{ name = "brain head's left hemisphere", chance = 3100 },
	{ name = "brain head's right hemisphere", chance = 3100 },
	{ name = "pair of old bracers", chance = 3100 },
	{ name = "spooky hood", chance = 8520 },
}

monster.attacks = {
	{ name = "combat", type = COMBAT_DEATHDAMAGE, interval = 2000, chance = 80, minDamage = -700, maxDamage = -1200, effect = CONST_ME_MORTAREA, shootEffect = CONST_ANI_SUDDENDEATH, target = true, range = 7 },
	{ name = "combat", type = COMBAT_LIFEDRAIN, interval = 2000, chance = 20, length = 8, spread = 0, minDamage = -900, maxDamage = -1300, effect = CONST_ME_ELECTRICALSPARK },
}

monster.defenses = {
	defense = 78,
	armor = 78,
	mitigation = 3.27,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Feel the power of death unleashed!", yell = false },
	{ text = "I will rule again and my realm of death will span the world!", yell = false },
	{ text = "My lich-knights will conquer this world for me!", yell = false },
}

mType:register(monster)
