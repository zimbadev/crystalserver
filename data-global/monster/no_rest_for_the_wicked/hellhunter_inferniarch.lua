local mType = Game.createMonsterType("Hellhunter Inferniarch")
local monster = {}

monster.description = "a hellhunter inferniarch"
monster.experience = 9400
monster.outfit = {
	lookType = 1793,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2606
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Azzilon Castle.",
}

monster.health = 11300
monster.maxHealth = 11300
monster.race = "undead"
monster.corpse = 49994
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 70,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyable = true,
	isPreyExclusive = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ardash... El...!", yell = true },
	{ text = "Urrrglll!", yell = true },
}

monster.loot = {
	{ name = "Platinum Coin", chance = 26500, maxCount = 40 },
	{ name = "Onyx Arrow", chance = 24500, maxCount = 25 },
	{ name = "Sniper Arrow", chance = 24500, maxCount = 15 },
	{ name = "Assassin Star", chance = 24500, maxCount = 25 },
	{ name = "Small Amethyst", chance = 24500, maxCount = 5 },
	{ name = "Dark Helmet", chance = 12500, maxCount = 1 },
	{ id = 6299, chance = 3500, maxCount = 1 },
	{ name = "Demonic Core Essence", chance = 1500, maxCount = 1 },
	{ name = "Cyan Crystal Fragment", chance = 14500, maxCount = 5 },
	{ name = "Mummified Demon Finger", chance = 1500, maxCount = 1 },
	{ name = "Hellhunter Eye", chance = 2500, maxCount = 1 },
	{ name = "Demonic Matter", chance = 1500, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 0, minDamage = 250, maxDamage = -400 },
	{ name = "extended white chain", interval = 2000, chance = 15, minDamage = -275, maxDamage = -438, range = 4 },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -340, maxDamage = -470, range = 4, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -430, range = 4, radius = 4, shootEffect = CONST_ANI_DIAMONDARROW, effect = CONST_ME_ENERGYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = -240, maxDamage = -370, range = 4, radius = 4, shootEffect = CONST_ANI_SNIPERARROW, effect = CONST_ME_BLACK_BLOOD, target = true },
}

monster.defenses = {
	defense = 73,
	armor = 73,
	mitigation = 2.19,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
