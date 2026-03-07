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

monster.bosstiary = {
	bossRaceId = 2364,
	bossRace = RARITY_NEMESIS,
}

monster.health = 900000
monster.maxHealth = 900000
monster.race = "venom"
monster.corpse = 44018
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 20,
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
	staticAttackChance = 98,
	targetDistance = 1,
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
	{ text = "Rott!!", yell = false },
	{ text = "Putrefy!", yell = false },
	{ text = "Decay!", yell = false },
}

monster.loot = {
	{name = "crystal coin", chance = 100000, maxCount = 50},
	{id = 49271, chance = 15000, maxCount = 5},
	{name = "supreme health potion", chance = 65000, maxCount = 30},
	{name = "ultimate mana potion", chance = 47000, maxCount = 70},
	{name = "ultimate spirit potion", chance = 62000, maxCount = 55},
	{name = "berserk potion", chance = 15000, maxCount = 5},
	{name = "green gem", chance = 8000, maxCount = 2},
	{name = "violet gem", chance = 8000, maxCount = 2},
	{name = "raw watermelon tourmaline", chance = 7229},
	{name = "amber with a dragonfly", chance = 3920},
	{name = "putrefactive figurine", chance = 1100},
	{name = "the essence of ichgahal", chance = 750},
	{id = 43899, chance = 100}, -- Cursed Wood addon
	{id = 43900, chance = 100}, -- Darklight Geode addon
	{id = 44048, chance = 100}, -- Spiritual Horseshoe
	{id = 43895, chance = 50}, -- Bag You Convet - Sanguine
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 20, minDamage = 0, maxDamage = -2000},
	{name = "ichgahal death ring", interval = 3000, chance = 30, minDamage = -800, maxDamage = -3200, target = false},
	{name = "combat", interval = 3000, chance = 30, type = COMBAT_AGONYDAMAGE, minDamage = -600, maxDamage = -700, length = 9, effect = CONST_ME_MORTAREA, target = false},
	{name = "speed", interval = 2000, chance = 30, speedChange = -800, radius = 5, effect = CONST_ME_SLEEP, target = false, duration = 30000 },
	{name = "combat", interval = 3000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -2900, radius = 6, effect = CONST_ME_SMALLPLANTS, target = false},
	{name = "combat", interval = 3000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = -2400, range = 6, radius = 5, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true},
	{name = "combat", interval = 3000, chance = 30, type = COMBAT_MANADRAIN, minDamage = -700, maxDamage = -1000, range = 6, effect = CONST_ME_PURPLETELEPORT, target = true},
	{name = "combat", interval = 3000, chance = 30, type = COMBAT_MANADRAIN, minDamage = -700, maxDamage = -1000, radius = 6, effect = CONST_ME_STUN, target = false},
	{name = "combat", interval = 3000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -2000, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false},
	{name = "mushroom ichgahal", interval = 30000, chance = 100, target = false},
	--{name ="Elder Bloodjaw Murcion", interval = 60000, chance = 100, target = false}
}

monster.defenses = {
	defense = 105,
	armor = 105,
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 800, maxDamage = 5600, effect = CONST_ME_MAGIC_GREEN, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
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