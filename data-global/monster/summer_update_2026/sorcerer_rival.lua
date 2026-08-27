local mType = Game.createMonsterType("Sorcerer Rival")
local monster = {}

monster.description = "a sorcerer rival"
-- Oficial: 0 XP. Nao entra no bestiario (por isso nao tem raceId nem monster.Bestiary).
monster.experience = 0
-- REVISAR(outfit): lookType 130 levantado no cliente pelo usuario, que ainda vai definir as
-- cores (head/body/legs/feet) e conferir addons.
monster.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 29800
monster.maxHealth = 29800
monster.race = "blood"
-- Corpse levantado no cliente (corpse humano generico da base).
monster.corpse = 6081
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
	-- "Pode ser Puxado: nao"
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	-- "Empurra Objetos: sim"
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	-- "Nao e possivel bloquear o respawn dessa criatura"
	isBlockable = false,
	-- "Passa por: Fogo, Energia, Veneno"
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
	{ text = "EMBRACE THE LIGHT!", yell = false },
}

-- Oficial: "Loot: Nenhum."
monster.loot = {}

-- Oficial: "Habilidades: Nenhuma."
monster.attacks = {}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 78,
	armor = 75,
	mitigation = 2.45,
}

-- Oficial: 100% em absolutamente todos os tipos - nenhuma resistencia nem fraqueza.
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

-- Oficial: "Imunidades: Paralisia, Invisibilidade".
monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
