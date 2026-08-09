local mType = Game.createMonsterType("Cake Golem")
local monster = {}

monster.description = "a cake golem"
monster.experience = 100
monster.outfit = {
	lookTypeEx = 6393,
}

monster.raceId = 680
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 5,
	FirstUnlock = 2,
	SecondUnlock = 3,
	CharmsPoints = 30,
	Stars = 2,
	Occurrence = 3,
	Locations = "Thais, Carlin, Edron, Darashia and Liberty Bay during the world quest A Piece of Cake.",
}

monster.health = 444
monster.maxHealth = 444
monster.race = "venom"
monster.corpse = 12141
monster.speed = 95
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyExclusive = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Must... reach... the machine...", yell = false },
	{ text = "Sugary rage!", yell = true },
}

monster.loot = {
	{ id = CakeQuest.Items.SweetAndSugarySubstance, chance = 50000, minCount = 1, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -45 },
	-- Posioned Cake
	{ name = "combat", interval = 2000, chance = 15, minDamage = 0, maxDamage = -40, range = 7, shootEffect = CONST_ANI_CAKE, effect = CONST_ME_POISONAREA, target = true },
	-- Cream Cake
	{ name = "drunk", interval = 2000, chance = 60, range = 7, duration = 8000, shootEffect = CONST_ANI_CAKE, target = true },
}

monster.defenses = {
	defense = 8,
	armor = 8,
	mitigation = 0.41,
	{
		name = "combat",
		interval = 2000,
		chance = 15,
		type = COMBAT_HEALING,
		minDamage = 180,
		maxDamage = 250,
		effect = CONST_ME_MAGIC_BLUE,
		target = false,
	},
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 85 },
	{ type = COMBAT_HOLYDAMAGE, percent = 95 },
	{ type = COMBAT_ICEDAMAGE, percent = 95 },
	{ type = COMBAT_FIREDAMAGE, percent = 85 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 90 },
	{ type = COMBAT_EARTHDAMAGE, percent = 95 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_HEALINGDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
