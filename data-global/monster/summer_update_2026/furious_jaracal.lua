local mType = Game.createMonsterType("Furious Jaracal")
local monster = {}

monster.description = "a furious jaracal"
-- Oficial: 0 XP. E um add invocado pela Moonsnow Magnolia, nao vale experiencia.
monster.experience = 0
monster.outfit = {
	lookType = 1961,
	lookHead = 0,
	lookBody = 86,
	lookLegs = 76,
	lookFeet = 76,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 8330
monster.maxHealth = 8330
monster.race = "blood"
-- Oficial: nao deixa corpo. E add de luta da Magnolia, nao dropa nada (loot vazio).
monster.corpse = 0
monster.speed = 190
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

-- TODO(balance): a wiki nao publica nenhum valor de dano (as duas habilidades aparecem como
-- "()"). Os numeros abaixo sao escalados pelos 8330 HP, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -520 },
	-- O mana drain e a razao de ser dele na luta da Magnolia: e o que pune ficar sem tocar a
	-- bone fiddle e deixar os adds se acumularem.
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -180, maxDamage = -340, range = 7, effect = CONST_ME_MAGIC_BLUE, target = true },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 70,
	armor = 68,
	mitigation = 2.10,
}

-- Oficial: 100% em absolutamente todos os tipos, ou seja nenhuma resistencia nem fraqueza.
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
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
