-- Init
SoulWarQuest.ebbAndFlow.eventCallbacks = {}

-- Cache frequently used values
local SMALL_POOL_ID = SoulWarQuest.ebbAndFlow.smallPoolId
local MEDIUM_POOL_ID = SoulWarQuest.ebbAndFlow.MediumPoolId
local POOL_POSITIONS = SoulWarQuest.ebbAndFlow.poolPositions
local WAIT_POSITION = SoulWarQuest.ebbAndFlow.waitPosition

-- Event callback registration function
local function registerEventCallback(name, mapPath, handler)
	if SoulWarQuest.ebbAndFlow.eventCallbacks[name] then
		return
	end

	local callback = function(loadedMapPath)
		if loadedMapPath == mapPath then
			handler()
		end
	end

	EventCallback(name, true):register(callback)
	SoulWarQuest.ebbAndFlow.eventCallbacks[name] = true
end

-- Optimized distance calculation
local function getDistanceSquared(pos1, pos2)
	return (pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2
end

-- Find nearest position
local function findNearestRoomPosition(playerPosition)
	local nearestPosition = nil
	local smallestDistanceSq = math.huge

	for _, room in ipairs(SoulWarQuest.ebbAndFlow.centerRoomPositions) do
		local distanceSq = getDistanceSquared(playerPosition, room.conor)
		if distanceSq < smallestDistanceSq then
			smallestDistanceSq = distanceSq
			nearestPosition = room.teleportPosition
		end
	end

	return nearestPosition
end

-- Batch processing for water pools
local function processBatch(poolPositions, batchSize, delay, index)
	index = index or 1
	local endIndex = math.min(index + batchSize - 1, #poolPositions)

	for i = index, endIndex do
		local pos = poolPositions[i]
		if pos then
			local tile = Tile(pos)
			if tile then
				local item = tile:getItemById(SMALL_POOL_ID)
				if item then
					item:transform(MEDIUM_POOL_ID)
					addEvent(function()
						local tile = Tile(pos)
						if tile then
							local revertItem = tile:getItemById(MEDIUM_POOL_ID)
							if revertItem then
								revertItem:transform(SMALL_POOL_ID)
							end
						end
					end, 40000)
				end
			end
		end
	end

	if endIndex < #poolPositions then
		addEvent(processBatch, delay, poolPositions, batchSize, delay, endIndex + 1)
	end
end

local function updateWaterPoolsSize()
	processBatch(POOL_POSITIONS, 15, 150)
end

-- Main teleport logic for players only
local function teleportPlayers()
	local zone = SoulWarQuest.ebbAndFlow.getZone()
	if not zone then
		return
	end

	for _, creature in ipairs(zone:getCreatures()) do
		if creature:isPlayer() then
			local pos = creature:getPosition()
			local tile = Tile(pos)

			if not tile then
				goto continue
			end

			-- Check if player is standing on raft (ID 7272)
			local isOnRaft = tile:getItemById(7272) ~= nil

			-- 1. If on raft - teleport between floors 8 and 9
			if isOnRaft then
				local newPos
				if pos.z == 8 then
					newPos = Position(pos.x, pos.y, 9) -- Teleport up to floor 9
				elseif pos.z == 9 then
					newPos = Position(pos.x, pos.y, 8) -- Teleport down to floor 8
				end

				if newPos then
					local destTile = Tile(newPos)
					-- Only teleport if destination has raft
					if destTile and destTile:getItemById(7272) then
						creature:teleportTo(newPos)
						pos:sendMagicEffect(CONST_ME_TELEPORT)
					end
				end
				-- 2. If not on raft AND on floor 9 - teleport to nearest room
			elseif pos.z == 9 then
				local nearestPos = findNearestRoomPosition(pos)
				if nearestPos then
					creature:teleportTo(nearestPos)
					pos:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end

			::continue::
		end
	end
end

-- Map loading functions
local function loadMapEmpty()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.empty)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(true)
	SoulWarQuest.ebbAndFlow.setActive(false)

	teleportPlayers()
	registerEventCallback("UpdatePlayersEmptyEbbFlowMap", SoulWarQuest.ebbAndFlow.mapsPath.empty, SoulWarQuest.ebbAndFlow.updateZonePlayers)

	addEvent(updateWaterPoolsSize, 80000)
end

local function loadMapInundate()
	Game.loadMap(SoulWarQuest.ebbAndFlow.mapsPath.inundate)
	SoulWarQuest.ebbAndFlow.setLoadedEmptyMap(false)
	SoulWarQuest.ebbAndFlow.setActive(true)

	teleportPlayers()
	registerEventCallback("UpdatePlayersInundateEbbFlowMap", SoulWarQuest.ebbAndFlow.mapsPath.inundate, SoulWarQuest.ebbAndFlow.updateZonePlayers)
end

-- Global events
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
function ebbAndFlowCycle.onThink()
	if SoulWarQuest.ebbAndFlow.isLoadedEmptyMap() then
		loadMapInundate()
	else
		loadMapEmpty()
	end
	return true
end
ebbAndFlowCycle:interval(SoulWarQuest.ebbAndFlow.intervalChangeMap * 60 * 1000)
ebbAndFlowCycle:register()
