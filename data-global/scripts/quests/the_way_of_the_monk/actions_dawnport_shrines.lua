local shrineConfig = {
        counterStorage = 290500,
}
local shrines = {
        [7101] = { storage = 290126, messageIndex = 1 },
        [7102] = { storage = 290226, messageIndex = 2 },
        [7103] = { storage = 290326, messageIndex = 3 },
        [7104] = { storage = 290426, messageIndex = 4 },
}
local shrineAction = Action()
function shrineAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
        local shrine = shrines[item.actionid]
        if not shrine then
                player:sendCancelMessage("Sorry, not possible.")
                return true
        end
        if player:getStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.Questline) < 1 then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ambassador Manop at the Adventurer's Outpost may be able to tell you more about this mysterious shrine.")
                return true
        end
        if player:getStorageValue(shrine.storage) ~= 1 then
                player:setStorageValue(shrine.storage, 1)
                local currentCount = math.max(0, player:getStorageValue(shrineConfig.counterStorage))
                player:setStorageValue(shrineConfig.counterStorage, currentCount + 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You honor the ways of the Merudri at the shrine of Darkness.")
                toPosition:sendMagicEffect(CONST_ME_FIREATTACK)
                item:transform(50244)
        else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already honor this shrine.")
        end
        return true
end
for aid, _ in pairs(shrines) do
        shrineAction:aid(aid)
end
shrineAction:register()
