local mType = Game.createMonsterType("Energy Cannon Right")
local monster = {}

monster.name = "Energy Cannon"
monster.description = "an energy cannon"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 53679, -- facing right
}

-- Health is the charge counter: starts nearly empty and is filled 10 at a time.
monster.health = 1
monster.maxHealth = 100
monster.race = "undead"
monster.corpse = 0
-- Bolted to the floor.
monster.speed = 0
monster.manaCost = 0

monster.flags = {
	summonable = false,
	-- Players charge it, they never fight it.
	attackable = false,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 0,
	targetDistance = 0,
	runHealth = 0,
	-- The bar has to be visible - it is the whole point.
	healthHidden = false,
	isBlockable = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {}
monster.loot = {}
monster.attacks = {}

monster.defenses = {
	defense = 0,
	armor = 0,
	mitigation = 0,
}

monster.elements = {}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
