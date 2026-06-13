local mType = Game.createMonsterType("Bonelord Totem")
local monster = {}

monster.description = "Bonelord Totem"
-- monster.raceid = 0  -- TODO: raceid not found in staticdata.dat
monster.experience = 0
monster.outfit = {
	lookTypeEx = 51192,
}

-- monster.health = 100  -- TODO (max % seen: 100%)
-- monster.maxHealth = 100  -- TODO
-- monster.race = "blood"  -- TODO (blood, venom, undead, fire, energy)
-- monster.corpse = 0  -- TODO
monster.speed = 0
-- monster.manaCost = 0  -- TODO

-- monster.changeTarget = {  -- TODO
--	interval = 4000,
--	chance = 10,
-- }

-- monster.strategiesTarget = {  -- TODO
--	nearest = 70,
--	health = 20,
--	damage = 10,
-- }

monster.flags = {
	-- summonable = false,  -- TODO
	attackable = true,
	-- hostile = true,  -- TODO
	-- convinceable = false,  -- TODO
	-- pushable = false,  -- TODO
	-- rewardBoss = false,  -- TODO
	-- illusionable = false,  -- TODO
	-- canPushItems = true,  -- TODO
	-- canPushCreatures = true,  -- TODO
	-- staticAttackChance = 90,  -- TODO
	-- targetDistance = 1,  -- TODO
	-- runHealth = 0,  -- TODO
	healthHidden = false,
	isBlockable = false,
	-- canWalkOnEnergy = false,  -- TODO
	-- canWalkOnFire = false,  -- TODO
	-- canWalkOnPoison = false,  -- TODO
}

monster.light = {
	level = 0,
	color = 0,
}

-- monster.voices = {  -- TODO
--	interval = 5000,
--	chance = 10,
-- }

monster.loot = {}

monster.attacks = {
	-- TODO: Add attacks
	-- Example: { name = "melee", interval = 2000, chance = 100, skill = 10, attack = 10 },
}

-- monster.defenses = {  -- TODO
--	defense = 5,
--	armor = 5,
--	mitigation = 0.00,
-- }

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

-- monster.immunities = {  -- TODO
--	{ type = "paralyze", condition = false },
--	{ type = "outfit", condition = false },
--	{ type = "invisible", condition = false },
--	{ type = "bleed", condition = false },
-- }

mType:register(monster)
