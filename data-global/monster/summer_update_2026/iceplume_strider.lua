local mType = Game.createMonsterType("Iceplume Strider")
local monster = {}

monster.description = "an iceplume strider"
monster.experience = 8150
monster.outfit = {
	lookType = 1950,
	lookHead = 0,
	lookBody = 51,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2803
monster.Bestiary = {
	class = "Elemental",
	race = BESTY_RACE_ELEMENTAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Asura Citadel",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "undead"
monster.corpse = 54335
monster.speed = 170
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

monster.loot = {
	{ name = "Platinum Coin", chance = 20000, maxCount = 8 },
	{ name = "Small Sapphire", chance = 9000, maxCount = 3 },
	{ name = "Crystal Coin", chance = 9000 },
	{ name = "Blue Gem", chance = 4000 },
	{ name = "Northwind Rod", chance = 4000 },
	{ name = "Ice Shard", chance = 4000 },
	{ id = 3007, chance = 900 }, -- crystal ring
	{ name = "Blue Robe", chance = 900 },
	{ name = "iceplume strider soul core", chance = 100 },
}

-- TODO(balance): a wiki nao publica os valores de dano (aparecem como "()").
-- Os numeros abaixo sao escalados pelo tier da criatura, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -520, radius = 3, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_ICEDAMAGE, minDamage = -320, maxDamage = -560, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -300, range = 7, effect = CONST_ME_MAGIC_BLUE, target = true },
}

monster.defenses = {
	defense = 75,
	armor = 75,
	mitigation = 3.68,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
