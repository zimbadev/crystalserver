local enter_putrefactory = Action()
function enter_putrefactory.onUse(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    local teleportPosition = Position(34101, 31679, 13)
    player:teleportTo(teleportPosition, true)
    teleportPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

    return true
end
enter_putrefactory:aid(34120)
enter_putrefactory:register()

local exit_putrefactory = Action()
function exit_putrefactory.onUse(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    local teleportPosition = Position(34120, 31980, 14)
    player:teleportTo(teleportPosition, true)
    teleportPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

    return true
end
exit_putrefactory:aid(34101)
exit_putrefactory:register()

local config = {
    storageKey = Storage.Quest.U13_20.RottenBlood.PutrefactoryTask,
    requiredTicks = 100
}

local enter_lever_Ichgahal = Action()

function enter_lever_Ichgahal.onUse(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    local teleportPosition = Position(32972, 32336, 15)
    local playerPos = player:getPosition()

    local ticks = player:getStorageValue(config.storageKey)
    if ticks < 0 then
        ticks = 0
    end

    if ticks >= config.requiredTicks then
        player:teleportTo(teleportPosition, true)
        teleportPosition:sendMagicEffect(CONST_ME_ENERGYHIT)
    else
        player:sendCancelMessage("You need to reach 100 points to enter.")
        playerPos:sendMagicEffect(CONST_ME_POFF)
    end

    return true
end

enter_lever_Ichgahal:aid(34065)
enter_lever_Ichgahal:register()

local exit_putrefactory_lever = MoveEvent()

function exit_putrefactory_lever.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    local teleportPosition = Position(34065, 31718, 15)
    player:teleportTo(teleportPosition, true)
    teleportPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

    return true
end

exit_putrefactory_lever:position({ x = 32970, y = 32337, z = 15 })
exit_putrefactory_lever:register()