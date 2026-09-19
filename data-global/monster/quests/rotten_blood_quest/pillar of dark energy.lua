local mType = Game.createMonsterType("Pillar of Dark Energy")
local monster = {}

monster.description = "a pillar of dark energy"
monster.experience = 20600
monster.outfit = {
	lookTypeEx = 43588,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 0
monster.Bestiary = {}

monster.health = 37500
monster.maxHealth = 37500
monster.race = "venom"
--monster.corpse =
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 60,
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
	staticAttackChance = 80,
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
	chance = 30,
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = 0 },
	{ name = "pillar chain", interval = 9000, chance = 100, minDamage = -1100, maxDamage = -1380, target = true },
}
monster.defenses = {
	defense = 60,
	armor = 104,
	mitigation = 3.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -40 },
	{ type = COMBAT_FIREDAMAGE, percent = -25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

local mushroomCheck = {}

mType.onThink = function(monster, variant, interval)
	local uid = monster:getId()
	if not mushroomCheck[uid] then
		mushroomCheck[uid] = 0
	end

	mushroomCheck[uid] = mushroomCheck[uid] + 1

	if mushroomCheck[uid] >= 10 then
		mushroomCheck[uid] = nil
		monster:remove()
		return
	end

	local monsterPos = monster:getPosition()
	local spectators = Game.getSpectators(monsterPos, false, false, 15, 15, 15, 15)
	local bossAlive = false

	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			local name = creature:getName():lower()
			if name == "vemiath" or name == "chagorz" or name == "bakragore" then
				bossAlive = true
				break
			end
		end
	end

	if not bossAlive then
		mushroomCheck[uid] = nil
		monster:remove()
	end
end

mType:register(monster)
