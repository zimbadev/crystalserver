-- Bloody Tusks - the crate in the Blind Monstrosity's hall (spawned at 32914, 31417, 5).
--
-- It is a creature wearing the crate sprite (35128), not a piece of decoration: it never moves,
-- never fights back, and one hit from across the room is enough to break it. What it leaves behind
-- is wooden trash (3136), and the noise it makes is what pulls the blind thing off its path.
local mType = Game.createMonsterType("Crate")
local monster = {}

monster.description = "a crate"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 35128,
}

monster.health = 100
monster.maxHealth = 100
monster.race = "undead"
monster.corpse = 3136 -- wooden trash
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 0,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = true,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

-- The noise it makes is the point: it is what the blind thing follows.
monster.voices = {
	interval = 5000,
	chance = 80,
	{ text = "CRACK!", yell = true },
}

monster.attacks = {}

monster.defenses = {
	defense = 0,
	armor = 0,
}

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

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true },
}

mType:register(monster)
