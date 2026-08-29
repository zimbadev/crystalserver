local mType = Game.createMonsterType("Winged Jaracal")
local monster = {}

monster.description = "a winged jaracal"
monster.experience = 7830
monster.outfit = {
	lookType = 1961,
	lookHead = 113,
	lookBody = 40,
	lookLegs = 95,
	lookFeet = 95,
	lookAddons = 1,
	lookMount = 0,
}

monster.raceId = 2802
monster.Bestiary = {
	class = "Mammal",
	race = BESTY_RACE_MAMMAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Asura Citadel",
}

monster.health = 8200
monster.maxHealth = 8200
monster.race = "blood"
monster.corpse = 54647
monster.speed = 180
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
	{ text = "Roarrr!", yell = false },
	{ text = "Grrrr!", yell = false },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 20000, maxCount = 8 },
	{ name = "Strong Health Potion", chance = 9000 },
	{ name = "Crystal Coin", chance = 9000 },
	{ name = "Furry Club", chance = 9000 },
	{ id = 3049, chance = 4000 }, -- stealth ring
	{ name = "Beastslayer Axe", chance = 4000 },
	{ name = "Dark Shield", chance = 4000 },
	{ name = "Ham", chance = 4000, maxCount = 2 },
	{ name = "Catnip", chance = 4000 },
	{ name = "Fur Armor", chance = 900 },
	{ name = "Skullcracker Armor", chance = 150 },
	{ name = "winged jaracal soul core", chance = 100 },
}

-- TODO(balance): a wiki nao publica os valores de dano (aparecem como "()").
-- Os numeros abaixo sao escalados pelo tier da criatura, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -470 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -540, radius = 3, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 75,
	mitigation = 3.92,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
