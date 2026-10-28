local mType = Game.createMonsterType("Moonsilver Guardian")
local monster = {}

monster.description = "a moonsilver guardian"
-- Oficial: 0 XP. Nao entra no bestiario (por isso nao tem raceId nem monster.Bestiary).
monster.experience = 0
-- REVISAR(outfit): 1956 addon 3 e um PALPITE do usuario, nao dado do cliente - confirmei que
-- nenhum dos Moonsilver existe no staticdata (so bestiario/boss entram la). Com este palpite,
-- Guardian, Protector e Sentinel ficam com aparencia identica entre si, e Custodian identico ao
-- Moonstone Overseer. Contra o palpite: os quatro tem resistencia a Electrified diferente
-- (Guardian 87%, Custodian 104%, Protector 107%), ou seja sao criaturas bem distintas.
-- lookTypes livres na faixa do update, se for preciso separar: 1954, 1960, 1962, 1973-1978
-- (1957 e 1958 NAO existem no cliente). Ver docs/update-15.30-pendencias.md.
monster.outfit = {
	lookType = 1956,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 10600
monster.maxHealth = 10600
-- TODO(items): "undead" seguindo os outros construtos do update. Confirmar junto com o corpse id.
monster.race = "undead"
-- Corpse levantado no cliente (cadeia decrescente 54372-54369).
monster.corpse = 54372
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

-- Oficial: "Habilidades: Nenhuma."
monster.attacks = {}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 62,
	armor = 60,
	mitigation = 2.20,
}

-- Oficial: Fisico 100%, Poison 80%, Fire 90%, Cursed 100%, Electrified 87%, Dazzled 100%,
-- Freezing 100%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 13 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
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
