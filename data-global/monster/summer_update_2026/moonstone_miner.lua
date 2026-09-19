local mType = Game.createMonsterType("Moonstone Miner")
local monster = {}

monster.description = "a moonstone miner"
-- Oficial: 0 XP. Nao entra no bestiario (por isso nao tem raceId nem monster.Bestiary).
monster.experience = 0
-- lookType 1952 addon 3, levantado no cliente pelo usuario. E a mesma familia de outfit do
-- Cult Initiate (1952 addon 0) e do Moonstone Excavator (1952 addon 1).
monster.outfit = {
	lookType = 1952,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 16500
monster.maxHealth = 16500
-- TODO(items): "blood" seguindo a familia de outfit humanoide (Cult Initiate); o Moonstone
-- Excavator, que divide o lookType, esta como "undead". Confirmar qual splash aparece in-game
-- quando o corpse id for levantado.
monster.race = "blood"
-- Corpse levantado no cliente.
monster.corpse = 54674
monster.speed = 130
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

-- Oficial: "Loot: Moonsilver Crystals." Sem taxa publicada - como e o unico item e o proposito
-- do monstro na luta, a chance e alta.
monster.loot = {
	{ name = "moonsilver crystals", chance = 100000 },
}

-- TODO(balance): a wiki lista Fisico e Life Drain sem valores (aparecem como "()"). Os numeros
-- abaixo sao escalados pelos 16500 HP e nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -620 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -350, maxDamage = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = true },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 75,
	armor = 72,
	mitigation = 2.45,
}

-- Oficial: Fisico 100%, Poison 0% (imunidade a Terra, abaixo), Fire 105%, Cursed 50%,
-- Electrified 107%, Dazzled 100%, Freezing 100%, Heal 100%.
-- Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -7 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

-- Oficial: "Imunidades: Terra, Paralisia, Invisibilidade".
monster.immunities = {
	{ type = "earth", combat = true },
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
