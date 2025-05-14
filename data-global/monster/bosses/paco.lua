local mType = Game.createMonsterType("Paco")
local monster = {}

monster.description = "Paco"
monster.experience = 600
monster.outfit = {
	lookType = 129,
	lookHead = 95,
	lookBody = 116,
	lookLegs = 120,
	lookFeet = 115,
	lookAddons = 2,
	lookMount = 0,
}

monster.health = 600
monster.maxHealth = 600
monster.race = "blood"
monster.corpse = 18138
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 7,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
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
	{ text = "WOLOLOOO!", yell = true },
	{ text = "exori san", yell = false },
	{ text = "exevo con", yell = false },
	{ text = "exura san", yell = false },
	{ text = "utani hur", yell = false },
	{ text = "Francisco Fonseca! Remember the name!", yell = false },
	{ text = "I hope you got money for a funeral!", yell = false },
	{ text = "Try shooting with your eyes open!", yell = false },
	{ text = "I dropped 100 fools like you!", yell = false },
	{ text = "Why don't you get some friends? Even this up a bit.", yell = false },
	{ text = "This would be a fair fight if you could shoot straight!", yell = false },
	{ text = "You are going to infierno, my friend!", yell = false },
	{ text = "You must be the pendejos I've been hearing about!", yell = false },
	{ text = "You're all going to be muerto!", yell = false },
	{ text = "Chinga your mother!", yell = false },
	{ text = "Hijos de puta!", yell = false },
	{ text = "Buenas Noches!", yell = false },
	{ text = "Someone don't like me much!", yell = false },
	{ text = "Stop doing that.", yell = false },
	{ text = "Guess it's too late to talk about things?", yell = false },
	{ text = "I'll ride slow, don't worry.", yell = false },
	{ text = "Relax, or die.", yell = false },
	{ text = "Looks like the good Lord got your ass and face mixed up.", yell = false },
	{ text = "Bet your Pa wished he'd pulled out.", yell = false },
	{ text = "You look like you're about to fill your pants, friend.", yell = false },
	{ text = "You look like you come from a close family, friend.", yell = false },
	{ text = "You one of them tough guys I've been hearing about?", yell = false },
	{ text = "Smile! What are you so scared of.", yell = false },
	{ text = "Rest in peace, my friend.", yell = false },
	{ text = "You're gonna drown in your own blood!", yell = false },
	{ text = "Do you piss sittin' down?", yell = false },
	{ text = "You born chicken or you just lost your balls?", yell = false },
	{ text = "What is wrong with you, Paco?", yell = false },
	{ text = "Now I'm actin' real crazy.", yell = false },
	{ text = "I'm sorry, I'm kinda crazy today. *chuckles*", yell = false },
	{ text = "I can't refuse a man his dying wish.", yell = false },
	{ text = "You want a broken nose, friend?!", yell = false },
	{ text = "I'll hunt you to hell and back!", yell = false },
	{ text = "What do you do when you're not pretending to be tough?", yell = false },
	{ text = "Am I supposed to be scared of you or somethin'?", yell = false },
}
	
monster.loot = {
	{ id = 2920, chance = 3300 }, -- torch
	{ name = "small ruby", chance = 150 },
	{ name = "dragon necklace", chance = 3000 },
	{ name = "bow", chance = 5770 },
	{ name = "brass helmet", chance = 5050 },
	{ name = "brass armor", chance = 5070 },
	{ name = "brass legs", chance = 3070 },
	{ name = "arrow", chance = 82000, maxCount = 22 },
	{ name = "poison arrow", chance = 4500, maxCount = 4 },
	{ id = 3449, chance = 5360, maxCount = 3 }, -- burst arrow
	{ name = "orange", chance = 20300, maxCount = 2 },
	{ name = "roll", chance = 11370, maxCount = 2 },
	{ name = "sniper gloves", chance = 540 },
	{ name = "slingshot", chance = 120 },
	{ id = 7394, chance = 190 }, -- wolf trophy
	{ id = 7397, chance = 520 }, -- deer trophy
	{ id = 7400, chance = 70 }, -- lion trophy
	{ name = "hunter's quiver", chance = 10240 },
	{ name = "elvish bow", chance = 10000 },
	{ name = "elvish talisman", chance = 5200 },
	{ name = "elven scouting glass", chance = 9750 },
	{ name = "golden can of oil", chance = 1000 },
	{ id = 860, chance = 1, unique = true }, -- sword familiar
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -40 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -200, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 15,
	mitigation = 2.19,
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_HEALING, minDamage = 20, maxDamage = 40, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
