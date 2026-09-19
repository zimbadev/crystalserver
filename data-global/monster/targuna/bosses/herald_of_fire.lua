local mType = Game.createMonsterType("Herald of Fire")
local monster = {}

monster.description = "Herald of Fire"
monster.experience = 1350
monster.outfit = {
	lookType = 1931,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- Mini boss: not part of the bestiary (no charm/raceId).

monster.events = {
	"TargunaHeraldDeath",
	"TargunaHeraldImmunity",
}

monster.health = 900
monster.maxHealth = 900
monster.race = "fire"
monster.corpse = 53108 -- corpse Targuna (appearances.dat)
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 8,
	color = 199,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Burn!", yell = true },
	{ text = "Feel the heat of the inferno!", yell = true },
}

monster.loot = {
	{ name = "health potion", chance = 80000, maxCount = 5 },
	{ name = "mana potion", chance = 80000, maxCount = 5 },
	{ name = "gold coin", chance = 90000, maxCount = 96 },
	{ name = "platinum coin", chance = 60000, maxCount = 5 },
	{ name = "infernoid ember", chance = 12000 },
	{ name = "small ruby", chance = 12000, maxCount = 3 },
	{ name = "charred mask", chance = 12000 },
	{ id = 12600, chance = 12000 }, -- coal
	{ name = "battle axe", chance = 3000 },
	{ name = "battle hammer", chance = 3000 },
	{ name = "pair of monk fists", chance = 3000 },
	{ name = "ratana", chance = 800 },
	{ name = "wand of dragonbreath", chance = 800 },
	{ name = "moonlight rod", chance = 800 },
	{ name = "elvish bow", chance = 800 },
	{ name = "lesser proficiency catalyst", chance = 150 }, -- garantido na 1a vez no oficial; aqui drop muito raro
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -25 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -25, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "heraldoffirefields", interval = 8000, chance = 100, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 10,
	mitigation = 0.80,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 10, maxDamage = 20, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -6 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
