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
	bossRace = RARITY_ARCHFOE,
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "undead"
monster.corpse = 44018
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Rott!!", yell = false },
	{ text = "Putrefy!", yell = false },
	{ text = "Decay!", yell = false },
}

monster.loot = {
	{ id = 43895, chance = 1500, unique = true }, ---bag you covet
	{ id = 43895, chance = 1000 }, ---bag you covet
	{ name = "crystal coin", chance = 14615, maxCount = 200 },
	{ name = "ultimate spirit potion", chance = 7169, maxCount = 153 },
	{ name = "mastermind potion", chance = 14651, maxCount = 45 },
	{ name = "yellow gem", chance = 19243, maxCount = 15 },
	{ name = "amber with a bug", chance = 17224, maxCount = 1 },
	{ name = "ultimate mana potion", chance = 13137, maxCount = 179 },
	{ name = "violet gem", chance = 14447, maxCount = 24 },
	{ name = "raw watermelon tourmaline", chance = 26788, maxCount = 1 },
	{ id = 3039, chance = 29047, maxCount = 25 }, -- red gem
	{ name = "supreme health potion", chance = 14635, maxCount = 37 },
	{ name = "berserk potion", chance = 24973, maxCount = 45 },
	{ name = "amber with a dragonfly", chance = 16470, maxCount = 1 },
	{ name = "gold ingot", chance = 11421, maxCount = 1 },
	{ name = "blue gem", chance = 28394, maxCount = 25 },
	{ name = "bullseye potion", chance = 13783, maxCount = 36 },
	{ name = "putrefactive figurine", chance = 21416, maxCount = 1 },
	{ name = "ichgahal's fungal infestation", chance = 17902, maxCount = 1 },
	{ name = "white gem", chance = 23559, maxCount = 30 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1300, maxDamage = -1600 },
	{ name = "murcionring", interval = 2000, chance = 25, minDamage = -1000, maxDamage = -4500, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -1500, maxDamage = -2500, length = 8, spread = 0, effect = 18, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -1600, radius = 7, effect = 20, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -600, radius = 6, effect = 46, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -1200, range = 7, radius = 5, effect = 21, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -1000, range = 7, radius = 1, effect = 222, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -700, radius = 6, effect = 32, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -400, radius = 3, effect = 35, target = false },
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
	local offsetX = math.random(-2, 2)
	local offsetY = math.random(-2, 2)
	local offsetZ = monsterPosition.z -- Mantener la misma capa (z)

	return Position(monsterPosition.x + offsetX, monsterPosition.y + offsetY, offsetZ)
end

local function getClosePosition(centerPos)
	local tries = 10
	for i = 1, tries do
		local offsetX = math.random(-2, 2)
		local offsetY = math.random(-2, 2)
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
	local radiusX, radiusY = 14, 14

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
	RottenBloodMechanics.handleElderBloodjawSpawn("Ichgahal", monster)

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

	-- No hacer nada si ya hay alguna de las fases
	if itemId == 43294 or itemId == 43295 or itemId == 43296 then
		return
	end

	-- Solo el boss "Ichgahal" puede crear la espora
	if not creature or not creature:isMonster() or creature:getName():lower() ~= "ichgahal" then
		return
	end

	-- Crear la primera fase de la espora
	local newItem = Game.createItem(43294, 1, toPos)
	if newItem then
		addEvent(function()
			local decayItem = Tile(toPos):getItemById(43294)
			if decayItem then
				decayItem:transform(43295)
			end
		end, 5000)
	end
end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
