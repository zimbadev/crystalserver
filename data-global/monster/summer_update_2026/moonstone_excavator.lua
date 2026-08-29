local mType = Game.createMonsterType("Moonstone Excavator")
local monster = {}

monster.description = "a moonstone excavator"
monster.experience = 4670
monster.outfit = {
	lookType = 1952,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 2857
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Moonstone Crater",
}

monster.health = 5100
monster.maxHealth = 5100
monster.race = "undead"
monster.corpse = 54342
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	-- a wiki marca 'nao e possivel bloquear o respawn desta criatura'
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyable = true,
	isPreyExclusive = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I must keep digging!", yell = false },
	{ text = "No room for failure.", yell = false },
}

monster.loot = {
	{ name = "Small Diamond", chance = 20000, maxCount = 2 },
	{ name = "Platinum Coin", chance = 20000, maxCount = 5 },
	{ name = "Small Sapphire", chance = 9000, maxCount = 2 },
	{ name = "Small Ruby", chance = 9000, maxCount = 2 },
	{ name = "Small Emerald", chance = 9000, maxCount = 2 },
	{ name = "Small Amethyst", chance = 9000, maxCount = 2 },
	{ name = "Small Topaz", chance = 9000, maxCount = 2 },
	{ name = "Candlestick", chance = 4000 },
	{ name = "Iron Ore", chance = 4000 },
	{ id = 3040, chance = 900 }, -- gold nugget
	{ id = 3456, chance = 900 }, -- pick
	{ name = "Moonstone", chance = 900 },
	{ name = "moonstone excavator soul core", chance = 100 },
}

-- TODO(balance): a wiki nao publica os valores de dano (aparecem como "()").
-- Os numeros abaixo sao escalados pelo tier da criatura, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -380 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -220, maxDamage = -420, radius = 3, effect = CONST_ME_GREEN_RINGS, target = false },
}

monster.defenses = {
	defense = 47,
	armor = 47,
	mitigation = 2.09,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
