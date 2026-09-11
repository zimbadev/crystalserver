local mType = Game.createMonsterType("Maior Domus")
local monster = {}

monster.description = "Maior Domus"
monster.experience = 3500000
-- raceId/lookType/addon oficiais do staticdata do cliente (ver docs/update-15.30-criaturas.md).
-- So existe UMA entrada de "Maior Domus" no staticdata (2815, addon 2) - ao contrario de Mimar
-- Haffar e Phosphorus, nao ha uma segunda entrada separada para a forma final. Provavelmente a
-- forma final (maior_domus_final.lua) reusa esta mesma aparencia.
monster.outfit = {
	lookType = 1959,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 2,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2815, -- oficial (staticdata do cliente)
	bossRace = RARITY_ARCHFOE,
}

-- TODO(balance): HP oficial "0" (Boss Difficulty System, nao ligado ainda). Placeholder na
-- faixa dos outros Archfoe (Moonsnow Magnolia = 52000), nao e oficial.
monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
-- Corpse levantado no cliente (cadeia 54433-54435).
monster.corpse = 54433
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

monster.summon = {
	maxSummons = 5,
	summons = {
		{ name = "Moonsilver Guardian", chance = 30, interval = 6000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- Comum
	{ name = "crystal coin", chance = 70000, maxCount = 33 },
	{ name = "platinum coin", chance = 90000, maxCount = 86 },
	{ name = "bullseye potion", chance = 40000, maxCount = 12 },
	{ name = "great mana potion", chance = 45000, maxCount = 28 },
	{ name = "mastermind potion", chance = 35000, maxCount = 5 },
	{ name = "piece of hell steel", chance = 30000 },
	{ name = "supreme health potion", chance = 40000, maxCount = 8 },
	{ name = "ultimate health potion", chance = 42000, maxCount = 10 },
	{ id = 54640, chance = 20000 }, -- scraps of a radiant attire (dificuldade 5+)
	-- Incomum
	{ name = "blue gem", chance = 12000 },
	{ id = 3093, chance = 12000 }, -- club ring (nome ambiguo: 3093 e 3096)
	{ name = "warrior helmet", chance = 12000 },
	{ name = "yellow gem", chance = 12000 },
	-- Semi-raro
	{ name = "amber with a bug", chance = 6000 },
	{ name = "giant emerald", chance = 6000 },
	{ name = "golden legs", chance = 6000 },
	-- Raro
	{ name = "figurine of Maior Domus", chance = 1000 },
	-- Muito raro
	{ name = "cloud in a bottle", chance = 300 }, -- dificuldade 10+
	{ name = "auric moon sigil", chance = 300 }, -- dificuldade 25+, chance cresce com a dificuldade
	{ name = "moonsilver battle visor", chance = 300 },
	{ name = "moonsilver nimbus hat", chance = 300 },
	{ name = "moonsilver spirit mask", chance = 300 },
	{ name = "moonsilver strike helm", chance = 300 },
	{ name = "moonsilver trail hood", chance = 300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000 },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 90,
	armor = 85,
	mitigation = 2.85,
}

-- Oficial: Fisico 100%, Poison 60%, Fire 70%, Cursed 100%, Electrified 87%, Dazzled 100%,
-- Freezing 100%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 13 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

-- Oficial: "Imunidades: Nenhuma." Ao contrario do Mimar Haffar, este boss NAO e imune a
-- paralisia nem a invisibilidade - a tabela fica vazia de proposito.
monster.immunities = {}

mType:register(monster)
