local mType = Game.createMonsterType("Shadowpelt")
local monster = {}

monster.description = "Shadowpelt"
monster.experience = 4600
monster.outfit = {
	lookType = 1040,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6000
monster.maxHealth = 6000
monster.race = "blood"
monster.corpse = 27722
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 11,
}

monster.bosstiary = {
	bossRaceId = 1561,
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 300,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Werebear", chance = 20, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "gold coin", chance = 100000, maxCount = 43 },
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "bear paw", chance = 100000 },
	{ name = "werebear skull", chance = 100000 },
	{ name = "werebear fur", chance = 100000 },
	{ name = "small enchanted sapphire", chance = 100000 },
	{ name = "black pearl", chance = 100000, maxCount = 2 },
	{ name = "furry club", chance = 100000 },
	{ name = "great health potion", chance = 50000 },
	{ name = "opal", chance = 50000 },
	{ id = 22103, chance = 50000 }, -- werebear trophy
	{ name = "tiger eye", chance = 50000 },
	{ id = 3582, chance = 100000 }, -- ham
	{ id = 282, chance = 5000 }, -- giant shimmering pearl (brown)
	{ name = "dreaded cleaver", chance = 550 },
	{ name = "honeycomb", chance = 25000 },
	{ id = 3098, chance = 15000 }, -- ring of healing
	{ name = "spiked squelcher", chance = 25000 },
	{ name = "ultimate health potion", chance = 50000 },
	{ name = "moonlight crystals", chance = 600 },
	{ name = "werewolf amulet", chance = 400 },
	{ name = "fur armor", chance = 550 },
	{ name = "stone skin amulet", chance = 15000 },
	{ name = "wolf backpack", chance = 100 },
	{ name = "silver token", chance = 2120 },
	{ name = "relic sword", chance = 550 },
	{ name = "berserk potion", chance = 30000 },
	{ name = "foxtail amulet", chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 50, attack = 50 },
	{ name = "combat", interval = 100, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -310, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 1, radius = 1, target = true, duration = 2000, outfitMonster = "Werebear" },
	{ name = "combat", interval = 100, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -200, radius = 3, effect = CONST_ME_SOUND_WHITE, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 30,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 7, type = COMBAT_HEALING, minDamage = 120, maxDamage = 310, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 10, speedChange = 520, effect = CONST_ME_POFF, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
