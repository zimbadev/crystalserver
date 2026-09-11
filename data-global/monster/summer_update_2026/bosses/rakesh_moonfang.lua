local mType = Game.createMonsterType("Rakesh Moonfang")
local monster = {}

monster.description = "Rakesh Moonfang"
monster.experience = 25500
-- lookType/cores oficiais do staticdata do cliente (ver docs/update-15.30-criaturas.md).
monster.outfit = {
	lookType = 1648,
	lookHead = 0,
	lookBody = 10,
	lookLegs = 52,
	lookFeet = 85,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2855, -- oficial (staticdata do cliente)
	bossRace = RARITY_BANE,
}

monster.health = 25500
monster.maxHealth = 25500
-- Werepanther infundido de moonsilver: mesmo lookType (1648) e mesmo corpse do werepanther comum.
monster.race = "blood"
monster.corpse = 43758
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
	-- "Pode ser Puxado: nao"
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	-- "Empurra Objetos: sim" (a wiki nao marca empurrar criaturas)
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	-- "Combate corpo a corpo" + "Luta ate a morte"
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	-- "Nao e possivel bloquear o respawn dessa criatura"
	isBlockable = false,
	-- "Passa por: Fogo, Energia" (veneno nao esta na lista)
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "The silver ... it calls me!", yell = false },
	{ text = "The moon broke and I followed!", yell = false },
	{ text = "It burns! But it makes me stronger!", yell = false },
}

monster.loot = {
	{ name = "crystal coin", chance = 60000 },
	{ name = "platinum coin", chance = 85000, maxCount = 45 },
	{ name = "small topaz", chance = 18000, maxCount = 4 },
	{ name = "golden sickle", chance = 15000 },
	{ name = "werepanther claw", chance = 15000 },
	{ name = "yellow gem", chance = 12000 },
	{ name = "lightning headband", chance = 4000 },
	{ name = "lightning pendant", chance = 4000 },
	{ name = "fur armor", chance = 3500 },
	{ name = "ripper lance", chance = 3000 },
	{ name = "gemmed figurine", chance = 2500 },
	{ name = "meat", chance = 3000 },
	{ name = "werepanther trophy", chance = 300 },
}

-- TODO(balance): a wiki nao publica os valores de dano das habilidades (aparecem como "?-?").
-- Os numeros abaixo sao escalados pelos 25500 HP do boss, nao sao oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -900 },
	-- Fisico: "Arranhao" — golpe corpo a corpo extra
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -450, maxDamage = -800, effect = CONST_ME_DRAWBLOOD, target = true },
	-- Energy: "Energy 3x3" — area de 3x3 (radius 1) centrada no alvo
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -1000, radius = 1, effect = CONST_ME_ENERGYAREA, target = true },
	-- Ice: "Chuva de Gelo"
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -550, maxDamage = -950, radius = 4, effect = CONST_ME_ICEAREA, target = false },
}

-- TODO(balance): defense/armor/mitigation nao sao publicados pela wiki.
monster.defenses = {
	defense = 90,
	armor = 85,
	mitigation = 2.85,
}

-- Oficial: Fisico 100%, Poison 100%, Fire 110%, Cursed 100%, Electrified 77%, Dazzled 100%,
-- Freezing 77%, Heal 100%. Aqui o campo e a RESISTENCIA, ou seja percent = 100 - valor da wiki.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 23 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 23 },
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
