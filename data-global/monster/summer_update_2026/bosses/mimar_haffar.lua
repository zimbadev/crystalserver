local mType = Game.createMonsterType("Mimar Haffar")
local monster = {}

monster.description = "Mimar Haffar"
monster.experience = 3500000
-- raceId/lookType/addon oficiais do staticdata do cliente (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1953,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2812, -- oficial (staticdata do cliente)
	bossRace = RARITY_ARCHFOE,
}

-- TODO(balance): a wiki mostra "0" de HP para este boss porque ele usa o Boss Difficulty System
-- (escala por dificuldade escolhida), que ainda nao esta ligado no Lua desta base (ver
-- docs/update-15.30-pendencias.md, secao 8). O valor abaixo e um placeholder na faixa dos outros
-- Archfoe (Moonsnow Magnolia = 52000) so para o monstro ficar jogavel; nao e oficial.
monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
-- Corpse levantado no cliente (cadeia decrescente 54346-54343).
monster.corpse = 54346
monster.speed = 180
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

monster.loot = {
	{ id = 54640, chance = 20000 }, -- scraps of a radiant attire (dificuldade 5+)
	{ name = "figurine of Mimar Haffar", chance = 1000 },
	-- Muito raro
	{ name = "crystal coin", chance = 300, maxCount = 500 },
	{ name = "cloud in a bottle", chance = 300 }, -- dificuldade 10+
	{ name = "auric moon sigil", chance = 300 }, -- dificuldade 25+, chance cresce com a dificuldade
	{ name = "moonsilver battle visor", chance = 300 },
	{ name = "moonsilver nimbus hat", chance = 300 },
	{ name = "moonsilver spirit mask", chance = 300 },
	{ name = "moonsilver strike helm", chance = 300 },
	{ name = "moonsilver trail hood", chance = 300 },
	{ name = "royal almandine", chance = 300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000 },
	-- "Ataque Fisico Explosivo"
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = -1400, radius = 4, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -750, maxDamage = -1300, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2500, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -700, maxDamage = -1250, radius = 4, effect = CONST_ME_HOLYDAMAGE, target = false },
	-- "Ataque de Dreno de Vida (3x3)"
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_LIFEDRAIN, minDamage = -600, maxDamage = -1100, radius = 1, effect = CONST_ME_MAGIC_RED, target = true },
	-- "Onda de Dreno de Vida"
	{ name = "combat", interval = 3000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = -650, maxDamage = -1200, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2500, chance = 12, type = COMBAT_MANADRAIN, minDamage = -400, maxDamage = -800, range = 7, effect = CONST_ME_MAGIC_BLUE, target = true },
	-- "Embebeda: Sim"
	{ name = "drunk", interval = 3000, chance = 12, radius = 4, effect = CONST_ME_HITBYPOISON, target = false },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 90,
	armor = 85,
	mitigation = 2.85,
}

-- Oficial: Fisico 100%, Poison 100%, Fire 105%, Cursed 100%, Electrified 87%, Dazzled 100%,
-- Freezing 100%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 13 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
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
