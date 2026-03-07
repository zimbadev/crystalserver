local config = {
    specPutrefactory = {
        from = Position(34002, 31658, 14),
        to = Position(34115, 31770, 15)
    },
    specLever = {
        from = Position(32969, 32328, 15),
        to = Position(32983, 32338, 15),
    },
    specVestibule = {
        from = Position(34095, 31675, 13),
        to = Position(34105, 31684, 14)
    },
    storageKey = Storage.Quest.U13_20.RottenBlood.PutrefactoryTask
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
    if not player:getPosition():isInRange(config.specPutrefactory.from, config.specPutrefactory.to) and
        not player:getPosition():isInRange(config.specLever.from, config.specLever.to) and
        not player:getPosition():isInRange(config.specVestibule.from, config.specVestibule.to) then
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

    if player:getPosition():isInRange(config.specPutrefactory.from, config.specPutrefactory.to) or
        player:getPosition():isInRange(config.specLever.from, config.specLever.to) or
        player:getPosition():isInRange(config.specVestibule.from, config.specVestibule.to) then
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
    local players = Game.getPlayers()

    for _, player in ipairs(players) do
        checkPlayerInZone(player)
    end

    return true
end

checkPlayersInZonePutrefactory:interval(500)
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

local config = {
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

    effect = 241
}

local function getPositionIndex(pos)
    for index, validPos in ipairs(config.positions) do
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

    local exhaustStorage = config.exhaustStorageBase + posIndex

    local now = os.time()
    local exhaust = player:getStorageValue(exhaustStorage)

    if exhaust > now then
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "You already exhausted this reservoir."
        )
        return true
    end

    local currentTicks = player:getStorageValue(config.storageKey)
    if currentTicks < 0 then
        currentTicks = 0
    end

    if currentTicks >= config.maxTicks then
        return true
    end

    local newTicks = math.min(currentTicks + config.ticksPerUse, config.maxTicks)

    player:setStorageValue(config.storageKey, newTicks)
    player:setStorageValue(exhaustStorage, now + config.cooldown)

    player:setIcon(
        "putrefactory-task-x",
        CreatureIconCategory_Quests,
        CreatureIconQuests_WhiteCross,
        newTicks
    )

    toPosition:sendMagicEffect(config.effect)

    return true
end

putrefactoryClick:aid(47953)
putrefactoryClick:register()