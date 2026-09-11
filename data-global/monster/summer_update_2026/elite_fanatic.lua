local mType = Game.createMonsterType("Elite Fanatic")
local monster = {}

monster.description = "an elite fanatic"
-- Oficial: 0 XP. Nunca morre de verdade - petrifica.
monster.experience = 0
monster.outfit = {
	lookType = 1964,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6000
monster.maxHealth = 6000
monster.race = "blood"
-- Nao deixa corpo: petrifica em vez de morrer, e a wiki marca "Loot: Nenhum".
monster.corpse = 0
monster.speed = 175
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

-- A wiki lista dois sons, mas o segundo ("I'm just dummy text. Edit me!") e placeholder do
-- template do wiki, nao fala oficial - fica so o primeiro.
monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "For Phosphorus!", yell = false },
}

-- Oficial: "Loot: Nenhum."
monster.loot = {}

-- TODO(balance): a wiki lista Fisico e Cura sem valores (aparecem como "()"). Os numeros abaixo
-- sao escalados pelos 6000 HP e nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
}

-- A "Cura" das habilidades e auto-cura, que nesta base vai em defenses, nao em attacks.
-- TODO(balance): valores nao publicados; defense/armor/mitigation tambem nao.
monster.defenses = {
	defense = 55,
	armor = 52,
	mitigation = 1.95,
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_HEALING, minDamage = 250, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
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
