local mType = Game.createMonsterType("Trapped Soul")
local monster = {}

monster.description = "a trapped soul"
-- Oficial: 0 XP.
monster.experience = 0
monster.outfit = {
	lookType = 1219,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 1450
monster.maxHealth = 1450
monster.race = "undead"
-- Nao deixa corpo: e uma alma, e a wiki marca "Loot: Nenhum".
monster.corpse = 0
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
	-- "Pode ser Puxado: nao" - conduzir a alma ate o tanque e feito com exeta res, nao empurrando.
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
	{ text = "Your soul is becoming unstable.", yell = false },
}

-- Oficial: "Loot: Nenhum."
monster.loot = {}

-- Oficial: "Habilidades: Nenhuma." A alma nao ataca - so precisa ser conduzida ou purificada.
monster.attacks = {}

monster.defenses = {
	defense = 0,
	armor = 0,
	mitigation = 0,
}

-- Oficial: Dazzled (holy) 100%, Heal 100%, e 0% em todo o resto. Os 0% viram imunidade de
-- combate de verdade abaixo (m_damageImmunities), que e o que garante "so pode ser derrotado
-- por ataques de Holy". A tabela de elements fica toda em 0 porque as imunidades ja resolvem.
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

-- Oficial: "Imunidades: Fisico, Morte, Fogo, Energia, Gelo, Terra" - tudo menos Holy.
monster.immunities = {
	{ type = "physical", combat = true },
	{ type = "death", combat = true },
	{ type = "fire", combat = true },
	{ type = "energy", combat = true },
	{ type = "ice", combat = true },
	{ type = "earth", combat = true },
}

mType:register(monster)
