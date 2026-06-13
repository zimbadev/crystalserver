local mType = Game.createMonsterType("Bonelord's Phylactery")
local monster = {}

monster.description = "a bonelord's phylactery"
monster.experience = 0 -- unknown
monster.outfit = {
	lookTypeEx = 52466,
}

monster.health = 50000 -- não confirmado
monster.maxHealth = 50000 -- não confirmado
monster.race = "undead"
monster.corpse = 44831 -- não confirmado
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100, -- não confirmado
}

monster.flags = {
	summonable = false, -- não confirmado
	attackable = true, -- não confirmado
	hostile = true, -- não confirmado
	convinceable = false, -- não confirmado
	pushable = false, -- não confirmado
	rewardBoss = false, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = false, -- não confirmado
	canPushCreatures = false, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true, -- não confirmado
	canWalkOnFire = true, -- não confirmado
	canWalkOnPoison = true, -- não confirmado
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.loot = {
	{ name = "crystal coin", chance = 100000, maxCount = 49 }, -- não confirmado (chance)
	{ name = "blue gem", chance = 100000, maxCount = 3 }, -- não confirmado (chance)
	{ id = 3039, chance = 100000, maxCount = 8 }, -- red gem (não confirmado (chance))
	{ name = "yellow gem", chance = 100000, maxCount = 9 }, -- não confirmado (chance)
	{ name = "giant ruby", chance = 100000, maxCount = 2 }, -- não confirmado (chance)
	{ name = "strong mana potion", chance = 100000, maxCount = 93 }, -- não confirmado (chance)
	{ name = "great mana potion", chance = 100000, maxCount = 62 }, -- não confirmado (chance)
	{ name = "great spirit potion", chance = 100000, maxCount = 51 }, -- não confirmado (chance)
	{ name = "ultimate mana potion", chance = 100000, maxCount = 22 }, -- não confirmado (chance)
	{ name = "ultimate spirit potion", chance = 100000, maxCount = 24 }, -- não confirmado (chance)
	{ name = "ultimate health potion", chance = 100000, maxCount = 33 }, -- não confirmado (chance)
	{ name = "supreme health potion", chance = 100000, maxCount = 14 }, -- não confirmado (chance)
	{ name = "guardian gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "marksman gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "mystic gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "sage gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "spiritualist gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater guardian gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater marksman gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater mystic gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater sage gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "greater spiritualist gem", chance = 100000 }, -- não confirmado (chance)
	{ name = "small flask of eyedrops", chance = 100000 }, -- não confirmado (chance)
	{ name = "bonelord eye", chance = 100000 }, -- não confirmado (chance)
	{ id = 6299, chance = 100000 }, -- death ring (não confirmado (chance))
	{ name = "haunted blade", chance = 100000 }, -- não confirmado (chance)
	{ name = "bonelord shield", chance = 100000 }, -- não confirmado (chance)
	{ name = "skull helmet", chance = 100000 }, -- não confirmado (chance)
	{ name = "bone spikes", chance = 100000 }, -- não confirmado (chance)
	{ name = "ancient scales", chance = 100000 }, -- não confirmado (chance)
	{ name = "soul trap", chance = 100000 }, -- não confirmado (chance)
	{ name = "necromantic crypt rune", chance = 100000 }, -- não confirmado (chance)
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -800, maxDamage = -1200, radius = 5, effect = CONST_ME_MORTAREA, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 100, -- não confirmado
	armor = 100, -- não confirmado
	mitigation = 3.00, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true }, -- não confirmado
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
