local items = {
    {itemId = 50060, addon = 1},
    {itemId = 50061, addon = 2},
}

local FiendSlayerAddons = Action("FiendSlayerAddons")

function FiendSlayerAddons.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local maleOutfitId = 1809
    local femaleOutfitId = 1808

    local addon
    for _, data in ipairs(items) do
        if item.itemid == data.itemId then
            addon = data.addon
            break
        end
    end

    if not addon then
        return false
    end

    if not (player:hasOutfit(1809) or player:hasOutfit(1808)) then
        player:addOutfit(1809)
        player:addOutfit(1808)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have obtained the Fiend Slayer Outfit.")
    end

    local hasBothAddons = true
    if not player:hasOutfitAddon(1809, addon) then
        player:addOutfitAddon(1809, addon)
        hasBothAddons = false
    end

    if not player:hasOutfitAddon(1808, addon) then
        player:addOutfitAddon(1808, addon)
        hasBothAddons = false
    end

    if hasBothAddons then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You already have the Fiend Slayer Addon %d.", addon))
        return false
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have obtained the Fiend Slayer Addon %d.", addon))
        item:remove(1)
        return true
    end
end

for _, data in ipairs(items) do
    FiendSlayerAddons:id(data.itemId)
end

FiendSlayerAddons:register()

local itemMount = 50064

local PrimalDemonosaur = Action("PrimalDemonosaur")

function PrimalDemonosaur.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:hasMount(232) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own the Primal Demonosaur Mount.")
        return false
    else
        player:addMount(232)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have obtained the Primal Demonosaur Mount.")
        item:remove(1)
        return true
    end
end

PrimalDemonosaur:id(itemMount)
PrimalDemonosaur:register()