local mType = Game.createMonsterType("Murcion")
local monster = {}

monster.description = "Murcion"
monster.experience = 3250000
monster.outfit = {
	lookType = 1664,
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
	bossRaceId = 2362,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "undead"
monster.corpse = 44015
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
	health = 0,
	damage = 0,
	random = 0,
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

monster.summon = {}

monster.voices = {}

monster.loot = {
	{ name = "crystal coin", chance = 29000, maxCount = 200 },
	{ name = "supreme health potion", chance = 27500, maxCount = 156 },
	{ name = "ultimate mana potion", chance = 27500, maxCount = 18 },
	{ name = "ultimate spirit potion", chance = 27500, maxCount = 87 },
	{ name = "berserk potion", chance = 25500, maxCount = 16 },
	{ name = "blue gem", chance = 22500, maxCount = 12 },
	{ name = "green gem", chance = 22500, maxCount = 12 },
	{ id = 36706, chance = 22500, maxCount = 14 }, -- red gem
	{ name = "mastermind potion", chance = 22500, maxCount = 19 },
	{ name = "gold ingot", chance = 22500 },
	{ name = "white gem", chance = 22500, maxCount = 12 },
	{ name = "amber with a dragonfly", chance = 21250 },
	{ name = "giant emerald", chance = 21250 },
	{ name = "spiritual horseshoe", chance = 21312 },
	{ id = 43895, chance = 1500, unique = true }, ---bag you covet
	{ id = 43895, chance = 1000 }, ---bag you covet
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1100, maxDamage = -1700 },
	{ name = "speed", interval = 2000, chance = 27, speedChange = -1600, radius = 7, effect = CONST_ME_SOUND_RED, target = false, duration = 10000 },
	{ name = "murcionring", interval = 2000, chance = 15, minDamage = -2200, maxDamage = -3000, target = false },
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -1100, maxDamage = -1250, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -2100, maxDamage = -2650, radius = 6, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = -2500, radius = 6, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -2200, maxDamage = -2400, length = 8, spread = 0, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -1500, maxDamage = -2450, radius = 7, effect = CONST_ME_DRAWBLOOD, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_MANADRAIN, minDamage = -2200, maxDamage = -2450, radius = 7, effect = CONST_ME_STUN, target = false },
}

monster.defenses = {
	defense = 305,
	armor = 305,
	mitigation = 7.16,
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 4700, maxDamage = 6500, effect = 249, target = false },
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

local aditionalMonsters = {
	{ name = "Mushroom" },
	{ name = "Mushroom" },
	{ name = "Mushroom" },
}
local ElderBloodjaws = {
	{ name = "Elder Bloodjaw" },
	{ name = "Elder Bloodjaw" },
}

local accumulatedTime = 0
local summonInterval = 0 -- Tiempo aleatorio entre invocaciones (se ajusta dinámicamente)
local activeSummons = {} -- Tabla para rastrear las criaturas invocadas

-- Función para obtener una posición aleatoria alrededor del monstruo
local function getRandomPosition(monsterPosition)
	-- Rango de 4 SQM hacia arriba, abajo, derecha, izquierda
	local offsetX = math.random(-1, 1)
	local offsetY = math.random(-1, 1)
	local offsetZ = monsterPosition.z -- Mantener la misma capa (z)

	return Position(monsterPosition.x + offsetX, monsterPosition.y + offsetY, offsetZ)
end

local function getClosePosition(centerPos)
	local tries = 10
	for i = 1, tries do
		local offsetX = math.random(-1, 1)
		local offsetY = math.random(-1, 1)
		local tryPos = Position(centerPos.x + offsetX, centerPos.y + offsetY, centerPos.z)
		local tile = Tile(tryPos)
		if tile and tile:isWalkable() then
			return tryPos
		end
	end
	return centerPos -- fallback si no se encuentra una válida
end

local RottenBloodMechanics = dofile(DATA_DIRECTORY .. "/scripts/quests/rotten_blood_quest/rotten_blood_boss_mechanics.lua")

local function ensureSummons(monster)
	local pos = monster:getPosition()
	local radiusX, radiusY = 16, 16

	local existingMushrooms = 0

	for _, cid in ipairs(Game.getSpectators(pos, false, false, radiusX, radiusX, radiusY, radiusY)) do
		if cid:isMonster() then
			local name = cid:getName():lower()
			if name == "mushroom" then
				existingMushrooms = existingMushrooms + 1
			end
		end
	end

	-- Manejar Elder Bloodjaws con el nuevo sistema
	RottenBloodMechanics.handleElderBloodjawSpawn("Murcion", monster)

	-- Asegurar 4 Mushrooms
	for i = 1, 4 - existingMushrooms do
		local summonPos = getClosePosition(pos)
		Game.createMonster("Mushroom", summonPos)
	end
end

mType.onThink = function(monster, interval)
	-- Sumar el intervalo al tiempo acumulado
	accumulatedTime = accumulatedTime + interval
	ensureSummons(monster)

	-- Revisar si es tiempo de invocar criaturas
	if accumulatedTime >= summonInterval then
		-- Eliminar invocaciones anteriores si existen
		for _, summon in ipairs(activeSummons) do
			local creature = Creature(summon)
			if creature then
				creature:remove()
			end
		end
		activeSummons = {}

		-- Invocar criaturas según las posiciones definidas
		for _, monsterData in ipairs(aditionalMonsters) do
			-- Obtener una posición aleatoria alrededor del monstruo
			local summonPosition = getRandomPosition(monster:getPosition())
			local summon = Game.createMonster(monsterData.name, summonPosition)
			if summon then
				table.insert(activeSummons, summon:getId())
			end
		end

		-- Reiniciar el tiempo acumulado y configurar un nuevo intervalo aleatorio
		accumulatedTime = 0
		summonInterval = math.random(8000, 9000) -- Entre 10 y 12 segundos
	end
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(_, creature, fromPos, toPos)
	local tile = Tile(toPos)
	if not tile then
		return
	end

	local item = tile:getTopDownItem()
	local itemId = item and item:getId() or 0

	-- No hacer nada si ya hay alguna de las fases (murcion spore)
	if itemId == 42851 or itemId == 42853 then
		-- Si Murcion pisa su propia espora, se cura
		if creature and creature:isMonster() and creature:getName():lower() == "murcion" then
			local currentHealth = creature:getHealth()
			local maxHealth = creature:getMaxHealth()
			local healAmount = 15000 -- Cantidad de curación

			if currentHealth < maxHealth then
				creature:addHealth(healAmount)
				toPos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			end
		end
		return
	end

	-- Solo el boss "Murcion" puede crear la espora
	if not creature or not creature:isMonster() or creature:getName():lower() ~= "murcion" then
		return
	end

	-- Crear la murcion spore con transformación manual
	local spore = Game.createItem(42851, 1, toPos)
	if spore then
		-- Después de 4 segundos, transformar a fase 2
		addEvent(function(position)
			local tile = Tile(position)
			if tile then
				local item42851 = tile:getItemById(42851)
				if item42851 then
					item42851:transform(42853)

					-- Después de 3 segundos más, eliminar la espora
					addEvent(function(pos)
						local t = Tile(pos)
						if t then
							local item42853 = t:getItemById(42853)
							if item42853 then
								item42853:remove()
							end
						end
					end, 3000, position)
				end
			end
		end, 4000, toPos)
	end
end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
