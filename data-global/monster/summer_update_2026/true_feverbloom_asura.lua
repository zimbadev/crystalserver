local mType = Game.createMonsterType("True Feverbloom Asura")
local monster = {}

monster.description = "a true feverbloom asura"
monster.experience = 7850
monster.outfit = {
	lookType = 1068,
	lookHead = 62,
	lookBody = 61,
	lookLegs = 114,
	lookFeet = 15,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 2805
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Forbidden Gardens",
}

monster.health = 8600
monster.maxHealth = 8600
monster.race = "blood"
monster.corpse = 54667
monster.speed = 175
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
	{ name = "Seeds", chance = 9000 },
	{ name = "Demonic Essence", chance = 9000 },
	{ name = "Flask of Demonic Blood", chance = 9000 },
	{ name = "Golden Lotus Brooch", chance = 9000 },
	{ name = "Peacock Feather Fan", chance = 9000 },
	{ name = "Wild Flowers", chance = 9000 },
	{ name = "Pyrophyte Seed Pod", chance = 9000 },
	{ name = "Crystal Coin", chance = 4000 },
	{ name = "Muck Rod", chance = 4000 },
	{ name = "Oriental Shoes", chance = 4000 },
	{ name = "true feverbloom asura soul core", chance = 100 },
}

-- TODO(balance): a wiki nao publica os valores de dano (aparecem como "()").
-- Os numeros abaixo sao escalados pelo tier da criatura, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -480 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_FIREDAMAGE, minDamage = -330, maxDamage = -570, radius = 4, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -540, range = 7, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_GREEN_RINGS, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -320, range = 7, effect = CONST_ME_MAGIC_BLUE, target = true },
}

monster.defenses = {
	defense = 90,
	armor = 90,
	mitigation = 3.45,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 150 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
