local mType = Game.createMonsterType("Cult Initiate")
local monster = {}

monster.description = "a cult initiate"
-- Oficial: 500 XP (750 com bonus). O bonus e do servidor, entao aqui vai o valor base.
monster.experience = 500
monster.outfit = {
	lookType = 1952,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "blood"
-- Corpse levantado no cliente (compartilhado com o Moonsilver Custodian).
monster.corpse = 54568
monster.speed = 170
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

-- TODO(balance): a wiki lista as tres habilidades (Fisico, Energy, Holy) mas nao publica os
-- valores de dano - aparecem como "()". Os numeros abaixo sao escalados pelos 10000 HP e nao
-- sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -260, maxDamage = -480, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2500, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -240, maxDamage = -450, radius = 3, effect = CONST_ME_HOLYDAMAGE, target = false },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 62,
	armor = 60,
	mitigation = 2.20,
}

-- Oficial: Fisico 100%, Poison 80%, Fire 110%, Cursed 100%, Electrified 84%, Dazzled 100%,
-- Freezing 100%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 16 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
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
