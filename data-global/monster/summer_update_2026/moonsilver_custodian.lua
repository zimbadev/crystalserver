local mType = Game.createMonsterType("Moonsilver Custodian")
local monster = {}

monster.description = "a moonsilver custodian"
-- Oficial: 0 XP. Nao entra no bestiario (por isso nao tem raceId nem monster.Bestiary).
monster.experience = 0
-- REVISAR(outfit): lookType 1956 levantado no cliente pelo usuario, que pediu para deixar
-- marcado porque ainda vai conferir. Atencao: 1956 e EXATAMENTE o lookType do Moonstone
-- Overseer (raceId 2858, oficial do staticdata) - ou as duas criaturas dividem o mesmo outfit
-- de propósito (como o Cult Initiate / Excavator / Miner dividem o 1952, so mudando o addon),
-- ou falta um addon aqui para diferenciar. Conferir in-game lado a lado.
monster.outfit = {
	lookType = 1956,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 23300
monster.maxHealth = 23300
-- TODO(items): "undead" seguindo o Moonstone Excavator, o outro construto do update. Confirmar
-- o splash in-game junto com o corpse id.
monster.race = "undead"
-- Corpse levantado no cliente (compartilhado com o Cult Initiate).
monster.corpse = 54568
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

-- TODO(balance): a wiki lista Fisico e Holy sem valores (aparecem como "()"). Os numeros abaixo
-- sao escalados pelos 23300 HP e nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -750 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -420, maxDamage = -720, radius = 3, effect = CONST_ME_HOLYDAMAGE, target = false },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 82,
	armor = 80,
	mitigation = 2.60,
}

-- Oficial: Fisico 100%, Poison 80%, Fire 90%, Cursed 100%, Electrified 104%, Dazzled 100%,
-- Freezing 100%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -4 },
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
