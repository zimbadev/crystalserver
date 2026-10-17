local mType = Game.createMonsterType("Petrified Fanatic")
local monster = {}

monster.name = "Petrified Fanatic"
monster.description = "a petrified fanatic"
-- The experience is paid by the Elite Fanatic it came from.
monster.experience = 0
monster.outfit = {
	lookTypeEx = 54475,
}

-- What was left of the fanatic when it turned to stone (6000 - ~4000 damage).
monster.health = 2000
monster.maxHealth = 2000
monster.race = "undead"
monster.corpse = 0
-- A statue does not walk.
monster.speed = 0
monster.manaCost = 0

monster.flags = {
	summonable = false,
	-- Inert: it is never fought, only moved.
	attackable = false,
	hostile = false,
	convinceable = false,
	-- Has to be pushable: dragging it onto an ornamented floor is the whole task.
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 0,
	targetDistance = 0,
	runHealth = 0,
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
