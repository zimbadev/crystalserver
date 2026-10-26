local mType = Game.createMonsterType("Moonspawn Blightspitter")
local monster = {}

monster.description = "a moonspawn blightspitter"
monster.experience = 6670
monster.outfit = {
	lookType = 1970,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2851
monster.Bestiary = {
	class = "Slime",
	race = BESTY_RACE_SLIME,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Thalassara Surroundings",
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "venom"
monster.corpse = 54439
monster.speed = 168
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
	{ text = "<Splorch>", yell = false },
	{ text = "<Slushhhh>", yell = false },
	{ text = "<Glrrrkk>", yell = false },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 20000, maxCount = 8 },
	{ name = "Mushroom Pie", chance = 9000 },
	{ name = "Terra Mantle", chance = 4000 },
	{ name = "Terra Legs", chance = 4000 },
	{ name = "Terra Boots", chance = 4000 },
	{ name = "Terra Amulet", chance = 4000 },
	{ name = "Green Gem", chance = 4000 },
	{ name = "Green Mushroom", chance = 4000 },
	{ name = "Muck Rod", chance = 4000 },
	{ name = "Moonspawn Headpiece", chance = 4000 },
	{ name = "Moonstone", chance = 900 },
	{ name = "Mushroom Backpack", chance = 150 },
	{ name = "moonspawn blightspitter soul core", chance = 100 },
}

-- TODO(balance): a wiki nao publica os valores de dano (aparecem como "()").
-- Os numeros abaixo sao escalados pelo tier da criatura, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -440 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -520, radius = 4, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -280, maxDamage = -500, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	mitigation = 3.22,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = -12 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -2 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
