local mType = Game.createMonsterType("Lord Retro")
local monster = {}

monster.description = "Lord Retro"
monster.experience = 2500
monster.outfit = {
	lookType = 1469,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 80000
monster.maxHealth = 80000
monster.race = "undead"
monster.corpse = 31599
monster.speed = 350
monster.manaCost = 0

monster.changeTarget = {
	interval = 60000,
	chance = 0,
}

monster.events = {
	"LordRetroMonsterDeath",
}

monster.bosstiary = {
	bossRaceId = 2141,
	bossRace = RARITY_ARCHFOE,
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
	canPushCreatures = false,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 1000,
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
	{ text = "THE PRINCESS IS MINE ALONE!", yell = true },
	{ text = "I'll make you all outdated!", yell = true },
	{ text = "My daughter Nostalgia will avenge me!", yell = true },
	{ text = "I will reset this game and Tibia 1.0 will rule!", yell = true },
	{ text = "One retro version to rule them all!", yell = true },
	{ text = "One day Lord Retro will rule!", yell = true },
}

monster.loot = {
	{ name = "crystal coin", chance = 96080, maxCount = 22 },
	{ name = "Great Mana Potion", chance = 96080, maxCount = 52 },
	{ name = "Great Spirit Potion", chance = 96080, maxCount = 52 },
	{ name = "Platinum Coin", chance = 96080, maxCount = 152 },
	{ name = "Great Spirit Potion", chance = 96080, maxCount = 52 },
	{ name = "Great Spirit Potion", chance = 96080, maxCount = 52 },
	{ name = "wind-up loco", chance = 360 },
	{ name = "Changing Backpack", chance = 300 },
	{ name = "25 years backpack", chance = 900 },
	{ name = "Giant Amethyst", chance = 22000 },
	{ name = "Giant Ruby", chance = 35000 },
	{ name = "Giant Sapphire", chance = 65000 },
	{ name = "Decorative Plume", chance = 360 },
	{ name = "Brass Button", chance = 360 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -800, maxDamage = -2500 },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -2000, length = 4, spread = 0, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -2000, length = 4, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -800, radius = 5, effect = CONST_ME_SLASH, target = false },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -800, length = 10, spread = 3, effect = CONST_ME_STONE_STORM, target = false },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1300, length = 8, spread = 3, effect = CONST_ME_BLACKSMOKE, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 10,
	{ name = "speed", interval = 10000, chance = 40, speedChange = 510, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 20000 },
	{ name = "combat", interval = 5000, chance = 60, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1500, effect = CONST_ME_MAGIC_BLUE, target = false },
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
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
