local mType = Game.createMonsterType("Moonsilver Storm")
local monster = {}

monster.name = "Storm"
monster.description = "a storm"
-- Official: no experience.
monster.experience = 0
monster.outfit = {
	lookType = 1943,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- Official: infinite HP. It is immune to everything below, so this only has to be a number it
-- can never lose.
monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "energy"
monster.corpse = 0
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	random = 100,
}

monster.flags = {
	summonable = false,
	attackable = false,
	hostile = true,
	convinceable = false,
	-- "Pode ser Puxado: nao"
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	-- "Empurra Objetos: nao"
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 0,
	targetDistance = 0,
	runHealth = 0,
	healthHidden = true,
	-- "Nao e possivel bloquear o respawn dessa criatura"
	isBlockable = false,
	-- "Passa por: Nada."
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}
-- Official: "Loot: Nenhum."
monster.loot = {}

monster.attacks = {}

monster.defenses = {
	defense = 0,
	armor = 0,
	mitigation = 0,
}

-- Official: 0% across the board, which is a hard immunity rather than a resistance.
monster.elements = {}

monster.immunities = {
	{ type = "physical", combat = true },
	{ type = "holy", combat = true },
	{ type = "death", combat = true },
	{ type = "fire", combat = true },
	{ type = "energy", combat = true },
	{ type = "ice", combat = true },
	{ type = "earth", combat = true },
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
