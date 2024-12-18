local mType = Game.createMonsterType("Ichgahal")
local monster = {}

monster.description = "Ichgahal"
monster.experience = 3250000
monster.outfit = {
	lookType = 1665,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"RottenBloodBossDeath",
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "undead"
monster.corpse = 44018
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2364,
	bossRace = RARITY_NEMESIS,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 6,
	summons = {
		{ name = "Mushroom", chance = 40, interval = 1000, count = 6 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "crystal coin", chance = 4872, minCount = 1, maxCount = 124 },
	{ name = "green gem", chance = 2152, minCount = 1, maxCount = 5 },
	{ name = "yellow gem", chance = 4094, minCount = 1, maxCount = 5 },
	{ name = "violet gem", chance = 2278, minCount = 1, maxCount = 4 },
	{ id = 3039, chance = 2066, minCount = 1, maxCount = 3 }, -- red gem,
	{ id = 3041, chance = 4181, minCount = 1, maxCount = 4 }, -- blue gem,
	{ name = "white gem", chance = 2254, minCount = 1, maxCount = 3 },
	{ name = "gold ingot", chance = 4814 },
	{ name = "raw watermelon tourmaline", chance = 2852, minCount = 1, maxCount = 2 },
	{ name = "amber with a dragonfly", chance = 3322 },
	{ name = "amber with a bug", chance = 2521, minCount = 1, maxCount = 2 },
	{ name = "berserk potion", chance = 4443, minCount = 1, maxCount = 45 },
	{ name = "bullseye potion", chance = 4149, minCount = 1, maxCount = 45 },
	{ name = "mastermind potion", chance = 3393, minCount = 1, maxCount = 45 },
	{ name = "supreme health potion", chance = 2239, minCount = 1, maxCount = 181 },
	{ name = "ultimate spirit potion", chance = 2726, minCount = 1, maxCount = 153 },
	{ name = "ultimate mana potion", chance = 1899, minCount = 1, maxCount = 179 },
	{ name = "the essence of ichgahal", chance = 3703 },
	{ name = "unicorn figurine", chance = 3446 },
	{ name = "ichgahal's fungal infestation", chance = 4352 },
	{ name = "putrefactive figurine", chance = 2632 },
	{ name = "spiritual horseshoe", chance = 2248 },
	{ name = "cursed wood", chance = 4739 },
	{ id = 43895, chance = 3403 }, -- bag you covet,
	{ name = "royal almandine", chance = 2268 },
}

monster.attacks = {
	{ name = "melee", interval = 3000, chance = 100, minDamage = -1500, maxDamage = -2300 },
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1000, length = 12, spread = 3, effect = 249, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -2600, maxDamage = -2300, length = 12, spread = 3, effect = 193, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1500, length = 6, spread = 2, effect = CONST_ME_FIREAREA, target = false },
	{ name = "speed", interval = 2000, chance = 35, speedChange = -600, radius = 8, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000 },
}

monster.defenses = {
	defense = 105,
	armor = 105,
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1200, effect = 236, target = false },
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
