local mType = Game.createMonsterType("The Moonsnow Magnolia")
local monster = {}

monster.description = "The Moonsnow Magnolia"
monster.experience = 240000
-- lookType/cores oficiais do staticdata do cliente (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1068,
	lookHead = 85,
	lookBody = 13,
	lookLegs = 109,
	lookFeet = 3,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2806, -- oficial (staticdata do cliente)
	bossRace = RARITY_ARCHFOE,
}

monster.health = 52000
monster.maxHealth = 52000
monster.race = "blood"
-- Como e rewardBoss, o loot vai pro reward chest e nao pro corpo, entao isso nao trava o loot.
monster.corpse = 54670
monster.speed = 190
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
	-- "Pode ser Puxado: nao"
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	-- "Empurra Objetos: sim"
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	-- "Combate corpo a corpo" + "Luta ate a morte"
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

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Frost Flower Asura", chance = 10, interval = 4000, count = 2 },
		{ name = "Midnight Asura", chance = 10, interval = 4000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Come feast, my darlings!", yell = false },
}

monster.loot = {
	-- Comum
	{ name = "crystal coin", chance = 70000, maxCount = 15 },
	{ name = "platinum coin", chance = 90000, maxCount = 124 },
	{ name = "white pearl", chance = 32000 },
	{ name = "gold ingot", chance = 30000 },
	{ name = "cyan crystal fragment", chance = 28000, maxCount = 2 },
	{ name = "demonic essence", chance = 30000 },
	{ name = "flask of demonic blood", chance = 30000, maxCount = 5 },
	{ name = "black pearl", chance = 32000 },
	{ name = "golden lotus brooch", chance = 25000 },
	{ id = 54128, chance = 40000, maxCount = 10 }, -- ice shard
	{ name = "onyx chip", chance = 25000 },
	{ name = "peacock feather fan", chance = 25000 },
	{ name = "small topaz", chance = 30000 },
	-- Incomum
	{ name = "moonlight rod", chance = 12000 },
	{ id = 7441, chance = 12000 }, -- ice cube (nome ambiguo: 5 ids em items.xml)
	{ name = "ice rapier", chance = 12000 },
	-- Semi-raro
	{ name = "assassin dagger", chance = 6000 },
	{ name = "blue robe", chance = 6000 },
	{ name = "lunar staff", chance = 6000 },
	{ name = "moonstone", chance = 6000 },
	{ name = "oriental shoes", chance = 6000 },
	{ name = "silver token", chance = 6000 },
	-- Raro
	{ name = "frozen peacock feather", chance = 1500 },
	-- Muito raro. Ids explicitos: cada amuleto encantado tem DOIS ids no appearances.dat
	-- (53197/53198 etc), entao por nome o loot sairia nil (o mesmo bug de "Non-unique loot item"
	-- que ja pegamos antes). Ainda faltam ser cadastrados no items.xml com os atributos oficiais
	-- - ver docs/update-15.30-pendencias.md, secao 3.
	{ id = 53201, chance = 300 }, -- enchanted flamingo amulet of destruction
	{ id = 53203, chance = 300 }, -- enchanted flamingo amulet of nature
	{ id = 53199, chance = 300 }, -- enchanted flamingo amulet of precision
	{ id = 53197, chance = 300 }, -- enchanted flamingo amulet of valor
	{ id = 53205, chance = 300 }, -- enchanted swan amulet of balance
}

-- TODO(balance): a wiki so publica o dano da explosao suprema de gelo (1300-?); o resto aparece
-- como "?-?". Os numeros abaixo sao escalados pelos 52000 HP do boss, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1400 },
	-- Fisico: em area no jogador
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1200, radius = 3, effect = CONST_ME_HITAREA, target = true },
	-- Death: reta de morte
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -800, maxDamage = -1300, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	-- Ice: single target
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -750, maxDamage = -1250, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true },
	-- Ice: explosao suprema (unico dano publicado: minimo 1300)
	{ name = "combat", interval = 5000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -1300, maxDamage = -2200, radius = 5, effect = CONST_ME_ICEAREA, target = false },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 110,
	armor = 105,
	mitigation = 3.50,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
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
