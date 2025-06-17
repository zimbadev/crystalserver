local internalNpcName = "Henricus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
    lookType = 132,
    lookHead = 79,
    lookBody = 0,
    lookLegs = 96,
    lookFeet = 0,
    lookAddons = 0,
}

npcConfig.flags = {
    floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
    npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
    npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
    npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
    npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
    npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
    npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local questStorage = Storage.Quest.U8_0.TheInquisitionQuest.Questline
    local playerQuestStatus = player:getStorageValue(questStorage)
    local missing, totalBlessPrice = Blessings.getInquisitionPrice(player)

    -- Misja 7: The Shadow Nexus
    if MsgContains(message, "mission") or MsgContains(message, "report") then
        if playerQuestStatus < 21 then
            npcHandler:say("Destroy the shadow nexus using this vial of holy water and kill all demon lords.", npc, creature)
            player:setStorageValue(questStorage, 21)
            player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Mission07, 1) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
            player:addItem(133, 1) -- holy water
            npcHandler:setTopic(playerId, 0)
        elseif playerQuestStatus == 21 or playerQuestStatus == 22 then
            npcHandler:say("Your current mission is to destroy the shadow nexus in the Demon Forge. Are you done with that mission?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        elseif playerQuestStatus >= 23 then
             npcHandler:say("You have already defeated the shadow nexus and proven your worth, High Inquisitor.", npc, creature)
        end
    -- Błogosławieństwo po ukończeniu questu
    elseif MsgContains(message, "blessing") or MsgContains(message, "bless") then
        if playerQuestStatus >= 23 then
            npcHandler:say("Do you want to receive the blessing of the inquisition - which means " .. (missing == 5 and "all five available" or missing) .. " blessings - for " .. totalBlessPrice .. " gold?", npc, creature)
            npcHandler:setTopic(playerId, 7)
        else
            npcHandler:say("You cannot get this blessing unless you have completed The Inquisition Quest.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    -- Outfit po ukończeniu questu
    elseif MsgContains(message, "outfit") then
        if playerQuestStatus == 23 then
            npcHandler:say("Here is the final addon for your demon hunter outfit. Congratulations!", npc, creature)
            player:setStorageValue(questStorage, 24)
            player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Mission07, 4) -- Questlog update
            player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.RewardDoor, 1)
            player:addOutfitAddon(288, 2)
            player:addOutfitAddon(289, 2)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addAchievement("Demonbane")
            npcHandler:setTopic(playerId, 0)
        elseif playerQuestStatus > 23 then
            npcHandler:say("You have already received all available addons for your brave deeds.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    -- Odpowiedzi na "yes"
    elseif MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 6 then
            if playerQuestStatus == 22 then
                npcHandler:say({
                    "Incredible! You're a true defender of faith! I grant you the title of a High Inquisitor for your noble deeds. From now on you can obtain the blessing of the inquisition which makes the pilgrimage of ashes obsolete ...",
                    "The blessing of the inquisition will bestow upon you all available blessings. Also, don't forget to ask me about your {outfit} to receive the final addon as demon hunter.",
                }, npc, creature)
                player:setStorageValue(questStorage, 23)
                player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Mission07, 3) -- Questlog update
                player:addAchievement("High Inquisitor")
            else
                npcHandler:say("Come back when you have destroyed the shadow nexus.", npc, creature)
            end
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 7 then
            if missing == 0 then
                npcHandler:say("You already have been blessed!", npc, creature)
            elseif player:removeMoneyBank(totalBlessPrice) then
                npcHandler:say("You have been blessed by all of five gods!, |PLAYERNAME|.", npc, creature)
                player:addMissingBless(false)
                player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
            else
                npcHandler:say("Come back when you have enough money.", npc, creature)
            end
            npcHandler:setTopic(playerId, 0)
        end
    -- Odpowiedź na "no"
    elseif MsgContains(message, "no") then
        if npcHandler:getTopic(playerId) > 0 then
            npcHandler:say("Then no.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
    return true
end


-- Zachowane ogólne słowa kluczowe dla klimatu gry
keywordHandler:addKeyword({ "inquisitor" }, StdModule.say, { npcHandler = npcHandler, text = "The churches of the gods entrusted me with the enormous and responsible task to lead the inquisition. I leave the field work to inquisitors who I recruit from fitting people that cross my way." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "By edict of the churches I'm the Lord Inquisitor." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Henricus, the Lord Inquisitor." })
keywordHandler:addKeyword({ "demon" }, StdModule.say, { npcHandler = npcHandler, text = "Demons exist in many different shapes and levels of power. In general, they are servants of the dark gods and command great powers of destruction." })
keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "We owe to the gods of good our creation and continuing existence. If it weren't for them, we would surely fall prey to the minions of the vile and dark gods." })
keywordHandler:addKeyword({ "church" }, StdModule.say, { npcHandler = npcHandler, text = "The churches of the gods united to fight heresy and dark magic. They are the shield of the true believers, while the inquisition is the sword that fights all enemies of virtuousness." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The Thaian kings are crowned by a representative of the churches. This means they reign in the name of the gods of good and are part of the godly plan for humanity." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, fellow {believer} |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Always be on guard, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "This ungraceful haste is most suspicious!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)