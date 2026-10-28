local config = {
	specPutrefactory = {
		from = Position(34002, 31658, 14),
		to = Position(34115, 31770, 15),
	},
	specLever = {
		from = Position(32969, 32328, 15),
		to = Position(32983, 32338, 15),
	},
	specVestibule = {
		from = Position(34095, 31675, 13),
		to = Position(34105, 31684, 14),
	},
	storageKey = Storage.Quest.U13_20.RottenBlood.PutrefactoryTask,
}

local activePlayers = {}

local function setWhiteCrossIcon(player, count)
	if type(count) ~= "number" or count < 1 then
		return
	end

	local adjustedCount = math.min(count, 100)
	player:setStorageValue(config.storageKey, adjustedCount)

	player:setIcon("putrefactory-task-x", CreatureIconCategory_Quests, CreatureIconQuests_WhiteCross, adjustedCount)
end

local function removeWhiteCrossIcon(player)
	if not player:getPosition():isInRange(config.specPutrefactory.from, config.specPutrefactory.to) and not player:getPosition():isInRange(config.specLever.from, config.specLever.to) and not player:getPosition():isInRange(config.specVestibule.from, config.specVestibule.to) then
		player:removeIcon("putrefactory-task-x")
	end
end

local function restoreWhiteCrossIcon(player)
	local storedTicks = player:getStorageValue(config.storageKey) or 0
	setWhiteCrossIcon(player, storedTicks)
end

local function processPlayerTicks(player)
	local playerId = player:getId()

	if player:getPosition():isInRange(config.specPutrefactory.from, config.specPutrefactory.to) then
		local putrefactoryTicks = 1

		local currentTicks = player:getStorageValue(config.storageKey) or 0
		setWhiteCrossIcon(player, math.min(currentTicks + putrefactoryTicks, 100))
	else
		activePlayers[playerId] = nil
		removeWhiteCrossIcon(player)
	end
end

local function checkPlayerInZone(player)
	local playerId = player:getId()

	if player:getPosition():isInRange(config.specPutrefactory.from, config.specPutrefactory.to) or player:getPosition():isInRange(config.specLever.from, config.specLever.to) or player:getPosition():isInRange(config.specVestibule.from, config.specVestibule.to) then
		if not activePlayers[playerId] then
			activePlayers[playerId] = true
			restoreWhiteCrossIcon(player)
		end
	else
		if activePlayers[playerId] then
			activePlayers[playerId] = nil
			removeWhiteCrossIcon(player)
		end
	end
end

local login_check_putrefactory = CreatureEvent("login_check_putrefactory")
function login_check_putrefactory.onLogin(creature)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	checkPlayerInZone(player)
	return true
end
login_check_putrefactory:register()

local checkPlayersInZonePutrefactory = GlobalEvent("checkPlayersInZonePutrefactory")
function checkPlayersInZonePutrefactory.onThink(interval, lastExecution)
	local checkedPlayers = {}

	-- Check putrefactory zone (large, 2 floors)
	local putrefactoryCenter = Position((config.specPutrefactory.from.x + config.specPutrefactory.to.x) / 2, (config.specPutrefactory.from.y + config.specPutrefactory.to.y) / 2, (config.specPutrefactory.from.z + config.specPutrefactory.to.z) / 2)
	local putrefactoryRangeX = (config.specPutrefactory.to.x - config.specPutrefactory.from.x) / 2
	local putrefactoryRangeY = (config.specPutrefactory.to.y - config.specPutrefactory.from.y) / 2
	local putrefactoryPlayers = Game.getSpectators(putrefactoryCenter, true, true, putrefactoryRangeX, putrefactoryRangeX, putrefactoryRangeY, putrefactoryRangeY)
	for _, player in ipairs(putrefactoryPlayers) do
		checkedPlayers[player:getId()] = true
		checkPlayerInZone(player)
	end

	-- Check lever zone
	local leverCenter = Position((config.specLever.from.x + config.specLever.to.x) / 2, (config.specLever.from.y + config.specLever.to.y) / 2, config.specLever.from.z)
	local leverRangeX = (config.specLever.to.x - config.specLever.from.x) / 2
	local leverRangeY = (config.specLever.to.y - config.specLever.from.y) / 2
	local leverPlayers = Game.getSpectators(leverCenter, false, true, leverRangeX, leverRangeX, leverRangeY, leverRangeY)
	for _, player in ipairs(leverPlayers) do
		if not checkedPlayers[player:getId()] then
			checkedPlayers[player:getId()] = true
			checkPlayerInZone(player)
		end
	end

	-- Check vestibule zone
	local vestibuleCenter = Position((config.specVestibule.from.x + config.specVestibule.to.x) / 2, (config.specVestibule.from.y + config.specVestibule.to.y) / 2, (config.specVestibule.from.z + config.specVestibule.to.z) / 2)
	local vestibuleRangeX = (config.specVestibule.to.x - config.specVestibule.from.x) / 2
	local vestibuleRangeY = (config.specVestibule.to.y - config.specVestibule.from.y) / 2
	local vestibulePlayers = Game.getSpectators(vestibuleCenter, true, true, vestibuleRangeX, vestibuleRangeX, vestibuleRangeY, vestibuleRangeY)
	for _, player in ipairs(vestibulePlayers) do
		if not checkedPlayers[player:getId()] then
			checkedPlayers[player:getId()] = true
			checkPlayerInZone(player)
		end
	end

	-- Clean up players who left all zones
	for playerId, _ in pairs(activePlayers) do
		if not checkedPlayers[playerId] then
			local player = Player(playerId)
			if player then
				activePlayers[playerId] = nil
				removeWhiteCrossIcon(player)
			else
				activePlayers[playerId] = nil
			end
		end
	end

	return true
end

checkPlayersInZonePutrefactory:interval(2000)
checkPlayersInZonePutrefactory:register()

local function startGlobalTickProcessing()
	addEvent(function()
		for playerId, _ in pairs(activePlayers) do
			local player = Player(playerId)
			if player then
				processPlayerTicks(player)
			end
		end

		startGlobalTickProcessing()
	end, 20000)
end

startGlobalTickProcessing()

local putrefactoryClickConfig = {
	positions = {
		Position(34081, 31704, 14),
		Position(34013, 31744, 14),
		Position(34044, 31712, 14),
		Position(34051, 31706, 15),
		Position(34060, 31735, 15),
		Position(34095, 31684, 15),
	},

	ticksPerUse = 20,
	maxTicks = 100,
	cooldown = 20,

	storageKey = Storage.Quest.U13_20.RottenBlood.PutrefactoryTask,
	exhaustStorageBase = Storage.Quest.U13_20.RottenBlood.PutrefactoryTask + 100,

	effect = 241,
}

local function getPositionIndex(pos)
	for index, validPos in ipairs(putrefactoryClickConfig.positions) do
		if pos.x == validPos.x and pos.y == validPos.y and pos.z == validPos.z then
			return index
		end
	end
	return nil
end

local putrefactoryClick = Action()

function putrefactoryClick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local posIndex = getPositionIndex(toPosition)
	if not posIndex then
		return false
	end

	local exhaustStorage = putrefactoryClickConfig.exhaustStorageBase + posIndex

	local now = os.time()
	local exhaust = player:getStorageValue(exhaustStorage)

	if exhaust > now then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already exhausted this reservoir.")
		return true
	end

	local currentTicks = player:getStorageValue(putrefactoryClickConfig.storageKey)
	if currentTicks < 0 then
		currentTicks = 0
	end

	if currentTicks >= putrefactoryClickConfig.maxTicks then
		return true
	end

	local newTicks = math.min(currentTicks + putrefactoryClickConfig.ticksPerUse, putrefactoryClickConfig.maxTicks)

	player:setStorageValue(putrefactoryClickConfig.storageKey, newTicks)
	player:setStorageValue(exhaustStorage, now + putrefactoryClickConfig.cooldown)

	player:setIcon("putrefactory-task-x", CreatureIconCategory_Quests, CreatureIconQuests_WhiteCross, newTicks)

	toPosition:sendMagicEffect(putrefactoryClickConfig.effect)

	return true
end

putrefactoryClick:aid(47953)
putrefactoryClick:register()
