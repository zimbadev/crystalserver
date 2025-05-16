-- Init
SoulWarQuest.ebbAndFlow.eventCallbacks = {}

-- Utility: get distance between 2 positions
local function getDistance(pos1, pos2)
	return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

-- Utility: find nearest room position
local function findNearestRoomPosition(playerPosition)
	local nearestPosition, smallestDistance
	for _, room in ipairs(SoulWarQuest.ebbAndFlow.centerRoomPositions) do
		local distance = getDistance(playerPosition, room.conor)
		if not smallestDistance or distance < smallestDistance then
			smallestDistance = distance
			nearestPosition = room.teleportPosition
		end
	end
	return nearestPosition
end

-- Filter creatures inside Ebb and Flow zone (optional optimization)
local function isNearEbbAndFlowArea(pos)
	return pos.x >= 1000 and pos.x <= 1200 and pos.y >= 1000 and pos.y <= 1200 and pos.z == 7
end

local function getCreaturesInAffectedZone()
	local result = {}
	for _, creature in ipairs(Game.getPlayers()) do
		if isNearEbbAndFlowArea(creature:getPosition()) then
			table.insert(result, creature)
		end
	end
	return result
end

-- Gradual teleport system
local function teleportCreatures(creatures, index)
	index = index or 1
	local creature = creatures[index]
	if not creature then
		return
	end

	local pos = creature:getPosition()
	local teleportTo = SoulWarQuest.ebbAndFlow.waitPosition
	if creature:isInBoatSpot() then
		teleportTo = findNearestRoomPosition(pos)
	end

	creature:teleportTo(teleportTo)
	-- pos:sendMagicEffect(CONST_ME_TELEPORT) -- Optional effect

	local nextDelay = math.random(90, 150)
	addEvent(teleportCreatures, nextDelay, creatures, index + 1)
end

-- Gradual pool transformation
local function processBatch(poolPositions, batchSize, delay, index)
	index = index or 1
	local endIndex = math.min(index + batchSize - 1, #poolPositions)
	local startTime = os.clock()

	for i = index, endIndex do
		local pos = poolPositions[i]
		local tile = Tile(pos)
		if tile then
			local item = tile:getItemById(SoulWarQuest.ebbAndFlow.smallPoolId)
			if item then
				item:transform(SoulWarQuest.ebbAndFlow.MediumPoolId)
				addEvent(function()
					local tile = Tile(pos)
					if tile then
						local revertItem = tile:getItemById(SoulWarQuest.ebbAndFlow.MediumPoolId)
						if revertItem then
							revertItem:transform(SoulWarQuest.ebbAndFlow.smallPoolId)
						end
					end
				end, 40000)
			end
		end
	end

	if endIndex < #poolPositions then
		addEvent(processBatch, delay, poolPositions, batchSize, delay, endIndex + 1)
	end

	logger.trace("Processed batch %d-%d in %.2fms", index, endIndex, (os.clock() - startTime) * 1000)
end

local function updateWaterPoolsSize()
	local batchSize = 5
	local delayBetweenBatches = 250
	processBatch(SoulWarQuest.ebbAndFlow.poolPositions, batchSize, delayBetweenBatches)
end

-- Event registration helper
local function registerEventCallback(name, mapPath, handler)
	local cb = EventCallback(name, true)
	function cb.mapOnLoad(loadedMapPath)
		if loadedMapPath == mapPath then
			handler()
		end
	end
	cb:register()
	SoulWarQuest.ebbAndFlow.eventCallbacks[name] = true
end

-- Teleport player on raft
local function playersOnRaft()
	local zone = SoulWarQuest.ebbAndFlow.getZone()
	for _, creature in ipairs(zone:getCreatures()) do
		if creature:isPlayer() then
			local pos = creature:getPosition()
			if pos.z == 8 or pos.z == 9 then
				local tile = Tile(pos)
				if tile then
					local item = tile:getItemById(7272) -- Raft ID
					if item then
						local newPos = Position(pos.x, pos.y, pos.z == 8 and 9 or 8)
						creature:teleportTo(newPos)
						pos:sendMagicEffect(CONST_ME_TELEPORT)
					end
				end
			end
		end
	end
end

-- Map load logic
local function loadMapEmpty()
	playersOnRaft()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(true)
	SoulWarQuest.ebbAndFlow.setActive(false)

	addEvent(function()
		local creatures = getCreaturesInAffectedZone()
		teleportCreatures(creatures)
	end, 3000)

	registerEventCallback("UpdatePlayersEmptyEbbFlowMap", SoulWarQuest.ebbAndFlow.mapsPath.empty, SoulWarQuest.ebbAndFlow.updateZonePlayers)

	addEvent(updateWaterPoolsSize, 120000)
	addEvent(SoulWarQuest.ebbAndFlow.updateZonePlayers, 2000)
end

local function loadMapInundate()
	playersOnRaft()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(false)
	SoulWarQuest.ebbAndFlow.setActive(true)

	addEvent(function()
		local creatures = getCreaturesInAffectedZone()
		teleportCreatures(creatures)
	end, 3000)

	registerEventCallback("UpdatePlayersInundateEbbFlowMap", SoulWarQuest.ebbAndFlow.mapsPath.inundate, SoulWarQuest.ebbAndFlow.updateZonePlayers)

	addEvent(SoulWarQuest.ebbAndFlow.updateZonePlayers, 2000)
end

-- Global startup and cycle
local loadEmptyMap = GlobalEvent("EbbAndFlow_LoadEmptyMap")
function loadEmptyMap.onStartup()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.ebbFlow)
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)
	loadMapEmpty()
	SoulWarQuest.ebbAndFlow.updateZonePlayers()
end
loadEmptyMap:register()

local ebbAndFlowCycle = GlobalEvent("EbbAndFlow_Cycle")
function ebbAndFlowCycle.onThink(interval, lastExecution)
	if SoulWarQuest.ebbAndFlow.isLoadedEmptyMap() then
		loadMapInundate()
	else
		loadMapEmpty()
	end
	return true
end
ebbAndFlowCycle:interval(SoulWarQuest.ebbAndFlow.intervalChangeMap * 60 * 1000)
ebbAndFlowCycle:register()
