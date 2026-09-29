local mType = Game.createMonsterType("Phosphorus (Final)")
local monster = {}

monster.description = "Phosphorus"
monster.experience = 0 -- TODO(balance): ver nota de XP no arquivo da forma normal (phosphorus.lua).
-- raceId/lookType/addon oficiais do staticdata do cliente: entrada SEPARADA da forma normal,
-- com lookType diferente (1963 -> 1955), nao so addon (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1955,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2827, -- oficial (staticdata do cliente) - entrada separada da forma normal
	bossRace = RARITY_NEMESIS,
}

-- TODO(balance): mesmo caso da forma normal - HP oficial e "0" (Boss Difficulty System, nao
-- ligado ainda). Placeholder um pouco acima da forma normal por ser a fase final/definitiva.
monster.health = 90000
monster.maxHealth = 90000
monster.race = "blood"
-- Reusa o corpse da forma normal (cadeia 54352-54354).
monster.corpse = 54352
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
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
	staticAttackChance = 90,
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
	{ name = "wand of starstorm", chance = 12000 },
	{ name = "giant ruby", chance = 6000 },
	{ name = "spellbook of dark mysteries", chance = 6000 },
	{ name = "figurine of Phosphorus", chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1400 },
	{ name = "phosphorus curse", interval = 12000, chance = 100, target = true },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 105,
	armor = 100,
	mitigation = 3.25,
}

-- TODO(balance): resistencias/fraquezas nao publicadas pela wiki para esta forma.
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
	{ type = "invisible", condition = true },
}

mType:register(monster)
