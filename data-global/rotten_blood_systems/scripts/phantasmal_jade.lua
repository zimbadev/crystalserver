--[[local itemMount = 34072
local mountId = 167
local requiredUses = 4
local storageKey = "phantasmal_jade_mount"

local cuatroItemMount = Action("cuatroItemMount")

function cuatroItemMount.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:hasMount(mountId) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own the phantasmal jade mount.")
        return false
    end

    local uses = tonumber(player:kv():get(storageKey)) or 0
    uses = uses + 1
    player:kv():set(storageKey, uses)
    item:remove(1)

    if uses >= requiredUses then
        player:addMount(mountId)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have obtained the phantasmal jade mount!")
        player:kv():set(storageKey, 0)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "spectral horseshoes used... (" .. uses .. "/" .. requiredUses .. ")")
    end

    return true
end

cuatroItemMount:id(itemMount)
cuatroItemMount:register()]]
