<<<<<<< Updated upstream
<<<<<<< Updated upstream
-- Init
SoulWarQuest.ebbAndFlow.eventCallbacks = {}

-- Transfrom batch tiles
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
	local batchSize = 15
	local delayBetweenBatches = 150
	processBatch(SoulWarQuest.ebbAndFlow.poolPositions, batchSize, delayBetweenBatches)
end
-- define getdistance
local function getDistance(pos1, pos2)
	return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

-- find nearest position
local function findNearestRoomPosition(playerPosition)
	local nearestPosition = nil
	local smallestDistance = nil
	for _, room in ipairs(SoulWarQuest.ebbAndFlow.centerRoomPositions) do
		local distance = getDistance(playerPosition, room.conor)
		if not smallestDistance or distance < smallestDistance then
			smallestDistance = distance
			nearestPosition = room.teleportPosition
		end
	end
	return nearestPosition
end

-- teleport system by stages
local function teleportCreatures(creatures, index)
	index = index or 1
	local creature = creatures[index]
	if not creature then
		return
	end

	local creatureMaster = creature:getMaster()
	if creature:isPlayer() or (creature:isMonster() and creatureMaster and creatureMaster:isPlayer()) then
		local pos = creature:getPosition()
		local tile = Tile(pos)
		if creature:isInBoatSpot() then
			local nearest = findNearestRoomPosition(pos)
			creature:teleportTo(nearest)
			pos:sendMagicEffect(CONST_ME_TELEPORT)
		else
			creature:teleportTo(SoulWarQuest.ebbAndFlow.waitPosition)
			pos:sendMagicEffect(CONST_ME_TELEPORT)
		end

		addEvent(teleportCreatures, 50, creatures, index + 1)
	end

	addEvent(teleportCreatures, 50, creatures, index + 1)
end

-- register callbacks
local function registerEventCallback(name, mapPath, handler)
	-- create a new callback
	local cb = EventCallback(name, true)
	function cb.mapOnLoad(loadedMapPath)
		if loadedMapPath == mapPath then
			handler()
		end
	end
	cb:register()

	-- reference
	SoulWarQuest.ebbAndFlow.eventCallbacks[name] = true
end

-- optimized preload maps
local function loadMapEmpty()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(true)
	SoulWarQuest.ebbAndFlow.setActive(false)

	local creatures = SoulWarQuest.ebbAndFlow.getZone():getCreatures()
	teleportCreatures(creatures)

	registerEventCallback("UpdatePlayersEmptyEbbFlowMap", SoulWarQuest.ebbAndFlow.mapsPath.empty, SoulWarQuest.ebbAndFlow.updateZonePlayers)

	addEvent(updateWaterPoolsSize, 80000)
end

local function loadMapInundate()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(false)
	SoulWarQuest.ebbAndFlow.setActive(true)

	local creatures = SoulWarQuest.ebbAndFlow.getZone():getCreatures()
	teleportCreatures(creatures)

	registerEventCallback("UpdatePlayersInundateEbbFlowMap", SoulWarQuest.ebbAndFlow.mapsPath.inundate, SoulWarQuest.ebbAndFlow.updateZonePlayers)
end

-- global events
local loadEmptyMap = GlobalEvent("EbbAndFlow_LoadEmptyMap")
function loadEmptyMap.onStartup()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.ebbFlow)
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)

=======
local eventCallbacks = {}

local function updateWaterPoolsSize()
	for _, pos in ipairs(SoulWarQuest.ebbAndFlow.poolPositions) do
		local tile = Tile(pos)
		if tile then
			local item = tile:getItemById(SoulWarQuest.ebbAndFlow.smallPoolId)
			if item then
				item:transform(SoulWarQuest.ebbAndFlow.MediumPoolId)
				local eventId = addEvent(function()
					local tile = Tile(pos)
					if tile then
						local item = tile:getItemById(SoulWarQuest.ebbAndFlow.MediumPoolId)
						if item then
							item:transform(SoulWarQuest.ebbAndFlow.smallPoolId)
						end
					end
				end, 40000) -- 40 seconds

				-- Store the event ID for new cleanup
				if not SoulWarQuest.ebbAndFlow.pendingEvents then
					SoulWarQuest.ebbAndFlow.pendingEvents = {}
				end
				table.insert(SoulWarQuest.ebbAndFlow.pendingEvents, eventId)
			end
		end
	end
end

-- Helper function to clear all pending events
local function clearPendingEvents()
	if SoulWarQuest.ebbAndFlow.pendingEvents then
		for _, eventId in ipairs(SoulWarQuest.ebbAndFlow.pendingEvents) do
			stopEvent(eventId)
		end
		SoulWarQuest.ebbAndFlow.pendingEvents = {}
	end
end

-- Helper function to unregister all event callbacks
local function unregisterEventCallbacks()
	for name, callback in pairs(eventCallbacks) do
		if callback and callback.unregister then
			callback:unregister()
		end
	end
	eventCallbacks = {}
end

local function loadMapEmpty()
	-- Clean up previous events before loading a new map
	clearPendingEvents()
	unregisterEventCallbacks()

	local playersInZone = SoulWarQuest.ebbAndFlow.getZone():countPlayers()
	local monstersInZone = SoulWarQuest.ebbAndFlow.getZone():countMonsters()
	if playersInZone > 0 or monstersInZone > 0 then
		local creatures = SoulWarQuest.ebbAndFlow.getZone():getCreatures()
		for _, creature in ipairs(creatures) do
			local creatureMaster = creature:getMaster()
			local player = creature:getPlayer()
			if creature:isPlayer() or (creature:isMonster() and creatureMaster and creatureMaster:getPlayer()) then
				if creature:getPosition().z == 8 then
					if creature:isInBoatSpot() then
						local teleportPosition = creature:getPosition()
						teleportPosition.z = 9
						creature:teleportTo(teleportPosition)
						logger.trace("Teleporting player to down.")
					end
					if player then
						player:sendCreatureAppear()
					end
				end
			end
		end
	end

	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(true)
	SoulWarQuest.ebbAndFlow.setActive(false)

	local updatePlayers = EventCallback("UpdatePlayersEmptyEbbFlowMap", true)
	function updatePlayers.mapOnLoad(mapPath)
		if mapPath ~= SoulWarQuest.ebbAndFlow.mapsPath.empty then
			return
		end

		SoulWarQuest.ebbAndFlow.updateZonePlayers()
	end

	updatePlayers:register()
	-- Store reference for later cleanup
	eventCallbacks["UpdatePlayersEmptyEbbFlowMap"] = updatePlayers

	local eventId = addEvent(function()
		updateWaterPoolsSize()
	end, 80000) -- 80 seconds

	if not SoulWarQuest.ebbAndFlow.pendingEvents then
		SoulWarQuest.ebbAndFlow.pendingEvents = {}
	end
	table.insert(SoulWarQuest.ebbAndFlow.pendingEvents, eventId)
end

local function getDistance(pos1, pos2)
	return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

local function findNearestRoomPosition(playerPosition)
	local nearestPosition = nil
	local smallestDistance = nil
	for _, room in ipairs(SoulWarQuest.ebbAndFlow.centerRoomPositions) do
		local distance = getDistance(playerPosition, room.conor)
		if not smallestDistance or distance < smallestDistance then
			smallestDistance = distance
			nearestPosition = room.teleportPosition
		end
	end
	return nearestPosition
end

local function loadMapInundate()
	clearPendingEvents()
	unregisterEventCallbacks()

	local playersInZone = SoulWarQuest.ebbAndFlow.getZone():countPlayers()
	local monstersInZone = SoulWarQuest.ebbAndFlow.getZone():countMonsters()
	if playersInZone > 0 or monstersInZone > 0 then
		local creatures = SoulWarQuest.ebbAndFlow.getZone():getCreatures()
		for _, creature in ipairs(creatures) do
			local creatureMaster = creature:getMaster()
			local player = creature:getPlayer()
			if creature:isPlayer() or (creature:isMonster() and creatureMaster and creatureMaster:getPlayer()) then
				local creaturePosition = creature:getPosition()
				if creaturePosition.z == 9 then
					if creature:isInBoatSpot() then
						local nearestCenterPosition = findNearestRoomPosition(creaturePosition)
						creature:teleportTo(nearestCenterPosition)
						logger.trace("Teleporting player to the near center position room and updating tile.")
					else
						creature:teleportTo(SoulWarQuest.ebbAndFlow.waitPosition)
						logger.trace("Teleporting player to wait position and updating tile.")
					end
					creaturePosition:sendMagicEffect(CONST_ME_TELEPORT)
				end
				if player then
					player:sendCreatureAppear()
				end
			end
		end
	end

	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(false)
	SoulWarQuest.ebbAndFlow.setActive(true)

	local updatePlayers = EventCallback("UpdatePlayersInundateEbbFlowMap", true)
	function updatePlayers.mapOnLoad(mapPath)
		if mapPath ~= SoulWarQuest.ebbAndFlow.mapsPath.inundate then
			return
		end

		SoulWarQuest.ebbAndFlow.updateZonePlayers()
	end

	updatePlayers:register()
	eventCallbacks["UpdatePlayersInundateEbbFlowMap"] = updatePlayers
end

local loadEmptyMap = GlobalEvent("SoulWarQuest.ebbAndFlow")

function loadEmptyMap.onStartup()
	SoulWarQuest.ebbAndFlow.pendingEvents = {}

	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.ebbFlow)
>>>>>>> Stashed changes
	loadMapEmpty()
	SoulWarQuest.ebbAndFlow.updateZonePlayers()
end

loadEmptyMap:register()

<<<<<<< Updated upstream
local eddAndFlowInundate = GlobalEvent("EbbAndFlow_Cycle")
function eddAndFlowInundate.onThink(interval, lastExecution)
	if SoulWarQuest.ebbAndFlow.isLoadedEmptyMap() then
		loadMapInundate()
	else
		loadMapEmpty()
	end
	return true
end
eddAndFlowInundate:interval(SoulWarQuest.ebbAndFlow.intervalChangeMap * 60 * 1000)
eddAndFlowInundate:register()
=======
local eddAndFlowInundate = GlobalEvent("eddAndFlowInundate")

function eddAndFlowInundate.onThink(interval, lastExecution)
	if SoulWarQuest.ebbAndFlow.isLoadedEmptyMap() then
		logger.trace("Map change to empty in {} minutes.", SoulWarQuest.ebbAndFlow.intervalChangeMap)
		loadMapInundate()
	elseif SoulWarQuest.ebbAndFlow.isActive() then
		logger.trace("Map change to inundate in {} minutes.", SoulWarQuest.ebbAndFlow.intervalChangeMap)
		loadMapEmpty()
	end

	return true
end
=======
local eventCallbacks = {}

local function updateWaterPoolsSize()
	for _, pos in ipairs(SoulWarQuest.ebbAndFlow.poolPositions) do
		local tile = Tile(pos)
		if tile then
			local item = tile:getItemById(SoulWarQuest.ebbAndFlow.smallPoolId)
			if item then
				item:transform(SoulWarQuest.ebbAndFlow.MediumPoolId)
				local eventId = addEvent(function()
					local tile = Tile(pos)
					if tile then
						local item = tile:getItemById(SoulWarQuest.ebbAndFlow.MediumPoolId)
						if item then
							item:transform(SoulWarQuest.ebbAndFlow.smallPoolId)
						end
					end
				end, 40000) -- 40 seconds

				-- Store the event ID for new cleanup
				if not SoulWarQuest.ebbAndFlow.pendingEvents then
					SoulWarQuest.ebbAndFlow.pendingEvents = {}
				end
				table.insert(SoulWarQuest.ebbAndFlow.pendingEvents, eventId)
			end
		end
	end
end

-- Helper function to clear all pending events
local function clearPendingEvents()
	if SoulWarQuest.ebbAndFlow.pendingEvents then
		for _, eventId in ipairs(SoulWarQuest.ebbAndFlow.pendingEvents) do
			stopEvent(eventId)
		end
		SoulWarQuest.ebbAndFlow.pendingEvents = {}
	end
end

-- Helper function to unregister all event callbacks
local function unregisterEventCallbacks()
	for name, callback in pairs(eventCallbacks) do
		if callback and callback.unregister then
			callback:unregister()
		end
	end
	eventCallbacks = {}
end

local function loadMapEmpty()
	-- Clean up previous events before loading a new map
	clearPendingEvents()
	unregisterEventCallbacks()

	local playersInZone = SoulWarQuest.ebbAndFlow.getZone():countPlayers()
	local monstersInZone = SoulWarQuest.ebbAndFlow.getZone():countMonsters()
	if playersInZone > 0 or monstersInZone > 0 then
		local creatures = SoulWarQuest.ebbAndFlow.getZone():getCreatures()
		for _, creature in ipairs(creatures) do
			local creatureMaster = creature:getMaster()
			local player = creature:getPlayer()
			if creature:isPlayer() or (creature:isMonster() and creatureMaster and creatureMaster:getPlayer()) then
				if creature:getPosition().z == 8 then
					if creature:isInBoatSpot() then
						local teleportPosition = creature:getPosition()
						teleportPosition.z = 9
						creature:teleportTo(teleportPosition)
						logger.trace("Teleporting player to down.")
					end
					if player then
						player:sendCreatureAppear()
					end
				end
			end
		end
	end

	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(true)
	SoulWarQuest.ebbAndFlow.setActive(false)

	local updatePlayers = EventCallback("UpdatePlayersEmptyEbbFlowMap", true)
	function updatePlayers.mapOnLoad(mapPath)
		if mapPath ~= SoulWarQuest.ebbAndFlow.mapsPath.empty then
			return
		end

		SoulWarQuest.ebbAndFlow.updateZonePlayers()
	end

	updatePlayers:register()
	-- Store reference for later cleanup
	eventCallbacks["UpdatePlayersEmptyEbbFlowMap"] = updatePlayers

	local eventId = addEvent(function()
		updateWaterPoolsSize()
	end, 80000) -- 80 seconds

	if not SoulWarQuest.ebbAndFlow.pendingEvents then
		SoulWarQuest.ebbAndFlow.pendingEvents = {}
	end
	table.insert(SoulWarQuest.ebbAndFlow.pendingEvents, eventId)
end

local function getDistance(pos1, pos2)
	return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

local function findNearestRoomPosition(playerPosition)
	local nearestPosition = nil
	local smallestDistance = nil
	for _, room in ipairs(SoulWarQuest.ebbAndFlow.centerRoomPositions) do
		local distance = getDistance(playerPosition, room.conor)
		if not smallestDistance or distance < smallestDistance then
			smallestDistance = distance
			nearestPosition = room.teleportPosition
		end
	end
	return nearestPosition
end

local function loadMapInundate()
	clearPendingEvents()
	unregisterEventCallbacks()

	local playersInZone = SoulWarQuest.ebbAndFlow.getZone():countPlayers()
	local monstersInZone = SoulWarQuest.ebbAndFlow.getZone():countMonsters()
	if playersInZone > 0 or monstersInZone > 0 then
		local creatures = SoulWarQuest.ebbAndFlow.getZone():getCreatures()
		for _, creature in ipairs(creatures) do
			local creatureMaster = creature:getMaster()
			local player = creature:getPlayer()
			if creature:isPlayer() or (creature:isMonster() and creatureMaster and creatureMaster:getPlayer()) then
				local creaturePosition = creature:getPosition()
				if creaturePosition.z == 9 then
					if creature:isInBoatSpot() then
						local nearestCenterPosition = findNearestRoomPosition(creaturePosition)
						creature:teleportTo(nearestCenterPosition)
						logger.trace("Teleporting player to the near center position room and updating tile.")
					else
						creature:teleportTo(SoulWarQuest.ebbAndFlow.waitPosition)
						logger.trace("Teleporting player to wait position and updating tile.")
					end
					creaturePosition:sendMagicEffect(CONST_ME_TELEPORT)
				end
				if player then
					player:sendCreatureAppear()
				end
			end
		end
	end

	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(false)
	SoulWarQuest.ebbAndFlow.setActive(true)

	local updatePlayers = EventCallback("UpdatePlayersInundateEbbFlowMap", true)
	function updatePlayers.mapOnLoad(mapPath)
		if mapPath ~= SoulWarQuest.ebbAndFlow.mapsPath.inundate then
			return
		end

		SoulWarQuest.ebbAndFlow.updateZonePlayers()
	end

	updatePlayers:register()
	eventCallbacks["UpdatePlayersInundateEbbFlowMap"] = updatePlayers
end

local loadEmptyMap = GlobalEvent("SoulWarQuest.ebbAndFlow")

function loadEmptyMap.onStartup()
	SoulWarQuest.ebbAndFlow.pendingEvents = {}

	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.ebbFlow)
	loadMapEmpty()
	SoulWarQuest.ebbAndFlow.updateZonePlayers()
end

loadEmptyMap:register()

local eddAndFlowInundate = GlobalEvent("eddAndFlowInundate")

function eddAndFlowInundate.onThink(interval, lastExecution)
	if SoulWarQuest.ebbAndFlow.isLoadedEmptyMap() then
		logger.trace("Map change to empty in {} minutes.", SoulWarQuest.ebbAndFlow.intervalChangeMap)
		loadMapInundate()
	elseif SoulWarQuest.ebbAndFlow.isActive() then
		logger.trace("Map change to inundate in {} minutes.", SoulWarQuest.ebbAndFlow.intervalChangeMap)
		loadMapEmpty()
	end

	return true
end
>>>>>>> Stashed changes

eddAndFlowInundate:interval(SoulWarQuest.ebbAndFlow.intervalChangeMap * 60 * 1000)
eddAndFlowInundate:register()

local cleanupOnSave = GlobalEvent("EbbFlowCleanupOnSave")

function cleanupOnSave.onSave()
	clearPendingEvents()
	unregisterEventCallbacks()
	return true
end

<<<<<<< Updated upstream
cleanupOnSave:register()
>>>>>>> Stashed changes
=======
cleanupOnSave:register()
>>>>>>> Stashed changes
