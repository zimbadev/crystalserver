-- No Rest for the Wicked: final phase of the HARD mode (The Forgemaster was spared, left the fight and he healed fully).
-- W: "the boss will deal more damage in this phase" -> attacks x1.3 (NOT CONFIRMED). Loot = HARD mode
-- (helmets, Demon Skull, Demon in a Green Box). Shown as "Arbaziloth". Created by arbaziloth_fight.lua.
local mType = Game.createMonsterType("Enraged Arbaziloth")
local monster = {}

monster.name = "Arbaziloth"
monster.description = "Arbaziloth"
monster.experience = 500000
monster.outfit = {
	lookType = 1802,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 360000
monster.maxHealth = 360000
monster.race = "undead"
monster.corpse = 50029
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2594,
	bossRace = RARITY_ARCHFOE,
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
}

monster.events = {
	"azzilonCastleArbazilothOnDeath",
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
	{ text = "I am superior!", yell = false },
	{ text = "You are mad to challange a demon prince!", yell = false },
	{ text = "You can't stop me or my plans!", yell = false },
	{ text = "Pesky humans!", yell = false },
	{ text = "This insolence!", yell = false },
	{ text = "Nobody can stop me!", yell = false },
	{ text = "All will have to bow to me!", yell = false },
	{ text = "With this power I can crush everyone!", yell = false },
	{ text = "All that energy is mine!", yell = false },
	{ text = "Face the power of hell!", yell = false },
	{ text = "AHHH! THE POWER!!", yell = true },
}

monster.loot = {
	{ id = 3043, chance = 100000, maxCount = 3 }, -- crystal coin
	{ id = 3035, chance = 100000, maxCount = 98 }, -- platinum coin
	{ id = 237, chance = 35000, maxCount = 19 }, -- strong mana potion
	{ id = 237, chance = 35000, maxCount = 9 }, -- great mana potion
	{ id = 7642, chance = 35000, maxCount = 4 }, -- great spirit potion
	{ id = 23373, chance = 35000, maxCount = 29 }, -- ultimate mana potion
	{ id = 7643, chance = 35000, maxCount = 14 }, -- ultimate health potion
	{ id = 23375, chance = 35000, maxCount = 8 }, -- supreme health potion
	{ id = 23374, chance = 35000, maxCount = 14 }, -- ultimate spirit potion
	{ id = 3041, chance = 35000, maxCount = 2 }, -- blue gem
	{ id = 3039, chance = 35000, maxCount = 1 }, -- red gem
	{ id = 3037, chance = 35000, maxCount = 2 }, -- yellow gem
	{ id = 3320, chance = 20000, maxCount = 1 }, --  fire axe
	{ id = 3281, chance = 20000, maxCount = 1 }, --  giant sword
	{ id = 3081, chance = 20000, maxCount = 1 }, --  stone skin amulet
	{ id = 817, chance = 20000, maxCount = 1 }, --  magma amulet
	{ id = 6299, chance = 20000, maxCount = 1 }, -- death ring
	{ id = 3052, chance = 20000, maxCount = 1 }, --  life ring
	{ id = 3373, chance = 20000, maxCount = 1 }, --  strange helmet
	{ id = 3356, chance = 20000, maxCount = 1 }, --  devil helmet
	{ id = 3284, chance = 20000, maxCount = 1 }, --  ice rapier
	{ id = 3280, chance = 20000, maxCount = 1 }, --  fire sword
	{ id = 3063, chance = 20000, maxCount = 1 }, --  gold ring
	{ id = 3306, chance = 20000, maxCount = 1 }, --  golden sickle
	{ id = 821, chance = 20000, maxCount = 1 }, --  magma legs
	{ id = 3048, chance = 20000, maxCount = 1 }, --  might ring
	{ id = 3055, chance = 20000, maxCount = 1 }, --  platinum amulet
	{ id = 2848, chance = 20000, maxCount = 1 }, --  purple tome
	{ id = 3098, chance = 20000, maxCount = 1 }, --  ring of healing
	{ id = 3054, chance = 20000, maxCount = 1 }, --  silver amulet
	{ id = 3324, chance = 20000, maxCount = 1 }, --  skull staff
	{ id = 10438, chance = 20000, maxCount = 1 }, --  spellweaver's robe
	{ id = 8082, chance = 20000, maxCount = 1 }, --  underworld rod
	{ id = 3071, chance = 20000, maxCount = 1 }, --  wand of inferno
	{ id = 3420, chance = 10000, maxCount = 1 }, -- demon shield
	{ id = 50067, chance = 10000, maxCount = 1 }, -- arbaziloth shoulder piece
	{ id = 3019, chance = 10000, maxCount = 1 }, -- demonbone amulet
	{ id = 7382, chance = 10000, maxCount = 1 }, -- demonrage sword
	{ id = 32622, chance = 10000, maxCount = 1 }, -- giant amethyst
	{ id = 30060, chance = 10000, maxCount = 1 }, -- giant emerald
	{ id = 30061, chance = 10000, maxCount = 1 }, -- giant sapphire
	{ id = 30059, chance = 10000, maxCount = 1 }, -- giant ruby
	{ id = 3364, chance = 10000, maxCount = 1 }, -- golden legs
	{ id = 3366, chance = 10000, maxCount = 1 }, -- magic plate armor
	{ id = 50061, chance = 700, maxCount = 1 }, -- demon skull
	{ id = 50064, chance = 700, maxCount = 1 }, -- demon in a green box
	{ id = 49531, chance = 400, maxCount = 1 }, -- maliceforged helmet
	{ id = 49532, chance = 400, maxCount = 1 }, -- hellstalker visor
	{ id = 49533, chance = 400, maxCount = 1 }, -- dreadfire headpiece
	{ id = 49534, chance = 400, maxCount = 1 }, -- demonfang mask
	{ id = 50189, chance = 800, maxCount = 1 }, -- demon mengu
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 650, maxDamage = -1027 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -520, maxDamage = -975, radius = 7, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -520, maxDamage = -1495, radius = 3, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -520, maxDamage = -975, length = 5, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -650, maxDamage = -1885, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -1300, maxDamage = -1950, radius = 4, effect = 170, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -910, maxDamage = -1950, radius = 1, effect = 49, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -1690, maxDamage = -1937, length = 6, spread = 0, effect = 6, target = false }, --CONST_ME_YELLOWSMOKE
}

monster.defenses = {
	defense = 100,
	armor = 100,
	mitigation = 2.18,
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_HEALING, minDamage = 1100, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true },
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType.onThink = function(monster, interval)
	-- Overcharged Demons respawn (scripts/quests/no_rest_for_the_wicked/arbaziloth_fight.lua)
	if ArbazilothFight then
		ArbazilothFight.onThink(monster)
	end
end

mType:register(monster)
