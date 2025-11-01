-- Missing spells
local mType = Game.createMonsterType("Dworc Shadowstalker")
local monster = {}

monster.description = "a dworc shadowstalker"
monster.experience = 7150
monster.outfit = {
	lookType = 1853,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2667
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Norcferatu Dungeons, Norcferatu Fortress.",
}

monster.health = 8900
monster.maxHealth = 8900
monster.race = "blood"
monster.corpse = 51537
monster.speed = 170
monster.manaCost = 0

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Can't kill, what you can't see!", yell = false },
	{ text = "Kill! Kill! Die! Die!", yell = false },
	{ text = "Stabby! Stabby! Stabby! Stab! Stab!", yell = false },
}

monster.loot = {
	{ name = "gold coin", chance = 60590, maxCount = 100 },
	{ name = "platinum coin", chance = 40590, maxCount = 11 },
	{ name = "blood amulet", chance = 5590 }, -- new item
	{ name = "small sapphire", chance = 3030, maxCount = 3 },
	{ name = "small emerald", chance = 2500, maxCount = 2 },
	{ name = "poison dagger", chance = 1900 },
	{ name = "vampire teeth", chance = 1900 },
	{ name = "green crystal shard", chance = 1560 },
	{ name = "bone rattle", chance = 1540 }, -- new item
	{ name = "stone skin amulet", chance = 1000 },
	{ name = "tribal mask", chance = 800 },
	{ id = 51487, chance = 600 }, -- new item rare // norcferatu talisman
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -80, maxDamage = -100, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -500, maxDamage = -625, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 88,
	armor = 64,
	mitigation = 1.88,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
