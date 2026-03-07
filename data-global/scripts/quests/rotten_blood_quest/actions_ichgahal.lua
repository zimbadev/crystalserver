local config = {
    bossName = "Ichgahal",
    bossPos = Position{x = 33008, y = 32331, z = 15},

    centerRoom = Position{x = 33008, y = 32334, z = 15},
    exitPosition = Position{x = 34103, y = 31681, z = 13},
    newPos = Position{x = 33004, y = 32341, z = 15},
    playerPositions = {
        Position{x = 32978, y = 32333, z = 15},
        Position{x = 32977, y = 32333, z = 15},
        Position{x = 32976, y = 32333, z = 15},
        Position{x = 32975, y = 32333, z = 15},
        Position{x = 32974, y = 32333, z = 15}
    },
    range = 10,
    time = 20,

    monsters = {
        { name = "Elder Bloodjaw", pos = Position(33010, 32335, 15) },
    },
}

local function spawnElderBloodjaw()
    local spectators = Game.getSpectators(config.centerRoom, false, false, 10, 10, 15, 15)
    local count = 0
    for _, c in ipairs(spectators) do
        if c:isMonster() and c:getName():lower() == "elder bloodjaw" then
            count = count + 1
        end
    end

    if count == 0 then
        for i = 1, #config.monsters do
            local m = config.monsters[i]
            Game.createMonster(m.name, m.pos, false, true)
            break
        end
    end

    addEvent(spawnElderBloodjaw, 30000)
end

function startBossFight()
    Game.createMonster(config.bossName, config.bossPos, true, true)
    spawnElderBloodjaw()
end

local function isInBossRoom(pos)
    return pos.z == 15 and
        pos.x >= 32998 and pos.x <= 33018 and
        pos.y >= 32324 and pos.y <= 32344
end

local function clearIchgahal()
    local spectators = Game.getSpectators(config.centerRoom, false, false, config.range, config.range, config.range, config.range)
    for i = 1, #spectators do
        local spectator = spectators[i]
        if spectator:isPlayer() and isInBossRoom(spectator:getPosition()) then
            spectator:teleportTo(config.exitPosition)
            spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
        elseif spectator:isMonster() then
            spectator:remove()
        end
    end
end

local Ichgahalaction = Action()
function Ichgahalaction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 8911 then
        if player:getPosition() ~= Position{x = 32978, y = 32333, z = 15} then
            return true
        end

        for x = 32974, 32978 do
            local playerTile = Tile(Position(x, 32333, 15)):getTopCreature()
            if playerTile and playerTile:isPlayer() then
                if playerTile:getGroup():getId() <= 5 and playerTile:getStorageValue(888904) > os.time() then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You or a member in your team have to wait to face Ichgahal again!")
                    return true
                end
            end
        end

        local specs = Game.getSpectators(config.centerRoom, false, false, 10, 10, 10, 10)
        for i = 1, #specs do
            if specs[i]:isPlayer() then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with Boss.")
                return true
            end
        end

        local spectators = Game.getSpectators(config.bossPos, false, false, 15, 15, 15, 15)
        for i = 1, #spectators do
            local spectator = spectators[i]
            if spectator:isMonster() then
                spectator:remove()
            end
        end

        for x = 32974, 32978 do
            local playerTile = Tile(Position(x, 32333, 15)):getTopCreature()
            if playerTile and playerTile:isPlayer() then
                stopEvent(EventIchgahalClear)

                playerTile:setStorageValue(Storage.Quest.U13_20.RottenBlood.PutrefactoryTask, 0)

                playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
                playerTile:teleportTo(config.newPos)
                playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

                if playerTile:getGroup():getId() < 5 then
                    playerTile:setStorageValue(888904, os.time() + 20 * 60 * 60)
                end

                EventIchgahalClear = addEvent(clearIchgahal, 60 * config.time * 1000)
            end
        end

        startBossFight()
    elseif item.itemid == 8912 then
        return true
    end
end

Ichgahalaction:aid(9804)
Ichgahalaction:register()