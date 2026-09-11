local mType = Game.createMonsterType("Mimar Haffar (Final)")
local monster = {}

monster.description = "Mimar Haffar"
monster.experience = 0 -- TODO(balance): ver nota de XP no arquivo da forma normal (mimar_haffar.lua).
-- raceId/lookType/addon oficiais do staticdata do cliente: mesma criatura da forma normal
-- (2812), so troca o addon para 2 (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1953,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 2,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2813, -- oficial (staticdata do cliente) - entrada separada da forma normal
	bossRace = RARITY_ARCHFOE,
}

-- TODO(balance): mesmo caso da forma normal - HP oficial e "0" (Boss Difficulty System, nao
-- ligado ainda). Placeholder um pouco acima da forma normal por ser a fase final.
monster.health = 65000
monster.maxHealth = 65000
monster.race = "blood"
-- Reusa o corpse da forma normal (cadeia decrescente 54346-54343).
monster.corpse = 54346
monster.speed = 190
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

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1300 },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 100,
	armor = 95,
	mitigation = 3.10,
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
