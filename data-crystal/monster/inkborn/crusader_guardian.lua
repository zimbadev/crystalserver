local mType = Game.createMonsterType("Crusader Guardian")
local monster = {}

monster.description = "a crusader guardian"
monster.experience = 0
monster.outfit = {
	lookType = 1847,
	lookHead = 58,
	lookBody = 58,
	lookLegs = 58,
	lookFeet = 58,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 3400
monster.maxHealth = 3400
monster.race = "ink"
monster.corpse = 28601
monster.speed = 120
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {}

-- missing spells
monster.attacks = {
	-- Physical: Melee (100-330)
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -330 },
	-- Physical: Exori Hur (0-250)
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -250, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	-- Death: Death Strike (180-220)
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -180, maxDamage = -220, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	-- Death: Death Ball (200-230)
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -230, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 52,
	mitigation = 0.99,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
