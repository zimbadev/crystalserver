local goldToken = Action()
local boostStorage = 693690
local boostDuration = 3600
function goldToken.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local currentBoostEnd = player:getStorageValue(boostStorage)

    if currentBoostEnd >= os.time() then
        player:sendTextMessage(MESSAGE_LOOK, "You already have an XP boost active!")
        return true
    end
    local newBoostEnd = os.time() + boostDuration

    player:setStorageValue(boostStorage, newBoostEnd)
    player:sendTextMessage(MESSAGE_LOOK, "Your 1-hour XP boost has started! You will gain 50% extra experience while hunting.")
    item:remove(1)
	return true
end

goldToken:id(22721)
goldToken:register()
