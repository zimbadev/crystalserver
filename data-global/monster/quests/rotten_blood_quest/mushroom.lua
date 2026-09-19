local mType = Game.createMonsterType("Mushroom")
local monster = {}

monster.description = "a mushroom"
monster.experience = 20600
monster.outfit = {
	lookTypeEx = 43587,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 0
monster.Bestiary = {}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "venom"

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
	{ name = "melee", interval = 2000, chance = 0, minDamage = 0, maxDamage = 0 },
}

monster.defenses = {
	defense = 60,
	armor = 104,
	mitigation = 3.16,
	--{ name = "combat", interval = 6000, chance = 100, type = COMBAT_HEALING, minDamage = 1, maxDamage = 1, radius = 1, effect = CONST_ME_GREEN_RINGS, target = false },
	--{ name = "combat", interval = 7000, chance = 100, type = COMBAT_LIFEDRAIN, minDamage = -2500, maxDamage = -3000, radius = 4, effect = CONST_ME_HITBYPOISON, target = false },
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
local area = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 3, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local visualCombat = Combat()
visualCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
visualCombat:setArea(createCombatArea(area))

local damageCombat = Combat()
damageCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
damageCombat:setArea(createCombatArea(area))

local function executeAreaEffect(monsterId)
	local monster = Creature(monsterId)
	if not monster then
		return
	end

	local variant = Variant(monster:getPosition())
	visualCombat:execute(monster, variant)

	local targets = Game.getSpectators(monster:getPosition(), false, false, 3, 3, 3, 3)
	for _, target in ipairs(targets) do
		if target:isPlayer() or target:isMonster() then
			doTargetCombatHealth(monster, target, COMBAT_LIFEDRAIN, -2500, -3000, CONST_ME_GREEN_RINGS)
		end
	end

	monster:remove()
end

mType.onThink = function(monster, variant, interval)
	local monsterPos = monster:getPosition()
	local playersNearby = false
	local nearbyCreatures = Game.getSpectators(monsterPos, false, true, 1, 1, 1, 1)

	for _, creature in ipairs(nearbyCreatures) do
		if creature:isPlayer() then
			playersNearby = true
			break
		end
	end

	if playersNearby then
		monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		addEvent(executeAreaEffect, 1000, monster:getId())
	end
	addEvent(executeAreaEffect, 18000, monster:getId())

	local spectators = Game.getSpectators(monsterPos, false, false, 15, 15, 15, 15)
	local bossAlive = false

	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			local name = creature:getName():lower()
			if name == "murcion" or name == "ichgahal" or name == "bakragore" then
				bossAlive = true
				break
			end
		end
	end

	if not bossAlive then
		monster:remove()
	end
end

mType:register(monster)
