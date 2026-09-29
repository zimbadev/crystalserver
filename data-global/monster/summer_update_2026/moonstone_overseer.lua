local mType = Game.createMonsterType("Moonstone Overseer")
local monster = {}

monster.description = "a moonstone overseer"
monster.experience = 4920
-- raceId/lookType oficiais do staticdata do cliente (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1956,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2858
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Moonstone Crater",
}

monster.health = 5450
monster.maxHealth = 5450
monster.race = "undead"
-- Corpse levantado no cliente (compartilhado com os Radiant Acolyte/Templar/Inquisitor).
monster.corpse = 54678
monster.speed = 125
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
	pushable = false,
	rewardBoss = false,
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
	isPreyable = true,
	isPreyExclusive = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

-- Loot da wiki (paste do usuario): Comum, Incomum, Raro. Sem taxas oficiais - as chances abaixo
-- seguem a mesma escala usada no Moonstone Excavator para as mesmas raridades.
monster.loot = {
	{ name = "Platinum Coin", chance = 20000, maxCount = 5 },
	{ name = "Yellow Gem", chance = 9000 },
	{ name = "Green Gem", chance = 9000 },
	{ id = 3039, chance = 9000 }, -- red gem (nome ambiguo: 3039 e 36706)
	{ name = "Blue Gem", chance = 9000 },
	{ name = "Plate Armor", chance = 9000 },
	{ name = "Spike Sword", chance = 9000 },
	{ name = "Iron Ore", chance = 900 },
	{ name = "Diamond", chance = 900 },
	{ name = "Moonstone", chance = 900 },
	{ name = "moonstone overseer soul core", chance = 100 },
}

-- Oficial: as habilidades sao Fisico e **Holy** (nao Earth). TODO(balance): a wiki nao publica
-- os valores de dano - aparecem como "()". Os numeros abaixo sao escalados pelo tier da
-- criatura, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HOLYDAMAGE, minDamage = -230, maxDamage = -440, radius = 3, effect = CONST_ME_HOLYDAMAGE, target = false },
}

-- Oficial: 45 de Armadura, 2.44% de Mitigacao. TODO(balance): `defense` nao e publicado.
monster.defenses = {
	defense = 45,
	armor = 45,
	mitigation = 2.44,
}

-- Oficial: Fisico 105%, Poison 70%, Fire 110%, Cursed 75%, Electrified 110%, Dazzled 85%,
-- Freezing 95%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
