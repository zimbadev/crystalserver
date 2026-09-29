local mType = Game.createMonsterType("Phosphorus")
local monster = {}

monster.description = "Phosphorus"
monster.experience = 16000000
-- raceId/lookType/addon oficiais do staticdata do cliente (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1963,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2826, -- oficial (staticdata do cliente)
	bossRace = RARITY_NEMESIS,
}

-- TODO(balance): HP oficial "0" (Boss Difficulty System, nao ligado ainda). Placeholder acima
-- dos Archfoe por ser Nemesis (tier mais alto), nao e oficial.
monster.health = 70000
monster.maxHealth = 70000
monster.race = "blood"
-- Corpse levantado no cliente (cadeia 54352-54354).
monster.corpse = 54352
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

-- TODO(loot): a forma normal provavelmente nao dropa nada (foge em vez de morrer) - loot cheio
-- (Wand of Starstorm, Figurine of Phosphorus, moonsilver weapons, etc.) fica na forma final.
monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1100 },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 95,
	armor = 90,
	mitigation = 2.95,
}

-- TODO(balance): resistencias/fraquezas nao publicadas pela wiki para este boss.
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
