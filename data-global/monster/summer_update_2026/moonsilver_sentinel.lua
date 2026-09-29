local mType = Game.createMonsterType("Moonsilver Sentinel")
local monster = {}

monster.description = "a moonsilver sentinel"
-- Oficial: 0 XP. Nao entra no bestiario (por isso nao tem raceId nem monster.Bestiary).
monster.experience = 0
-- REVISAR(outfit): lookType 1956 addon 3, levantado no cliente pelo usuario, que pediu para
-- deixar marcado porque os addons ainda vao ser conferidos. Atencao: hoje este arquivo e o
-- Moonsilver Protector estao com EXATAMENTE a mesma aparencia (1956 addon 3), e o Moonsilver
-- Custodian / Moonstone Overseer usam o mesmo lookType com addon 0. Conferir os quatro in-game.
monster.outfit = {
	lookType = 1956,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

-- TODO(balance): a wiki marca **0 HP**, que e o mesmo que ela mostra para os bosses escalados
-- pelo Boss Difficulty System - provavelmente a vida deste tambem escala com a dificuldade
-- escolhida (a partir da dificuldade 10 os Sentinels ganham a mecanica de "criar campos que
-- fortalecem tempestades ao morrer"). O valor abaixo e um placeholder alinhado com o Moonsilver
-- Protector (22700) so para a criatura ser jogavel; nao e oficial.
monster.health = 22700
monster.maxHealth = 22700
-- TODO(items): "undead" seguindo os outros construtos do update. Confirmar junto com o corpse id.
monster.race = "undead"
-- Corpse levantado no cliente (compartilhado com o Protector e o Devoted Radiant Templar).
monster.corpse = 54376
monster.speed = 150
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
}

-- Oficial: "Loot: Nenhum."
monster.loot = {}

monster.attacks = {}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 80,
	armor = 78,
	mitigation = 2.55,
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
