local internalNpcName = "Telas"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 39,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 76,
	lookAddons = 1,
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

-- The New Frontier
local persuasionReplies = {
    flatter  = "Well, of course my worker golems are quite useful and it might indeed be a good idea to see how they operate on realistic conditions. I will send some to Farmine soon.",
    threaten = "Threatening me will get you nowhere, but I admire the boldness. Very well, let us see how my golems fare in Farmine.",
    bluff    = "Faces on stomachs and golden eggs, you say? Preposterous! Still, if there is any truth to it, my golems should be there to study it. I'll send them.",
    impress  = "I must admit, the scale of this whole excavation is rather impressive. Very well, I'll send some of my golems to assist.",
    reason   = "Well it sounds like a good idea to test my golems in some real environment. I think it is acceptable to send some of them to Farmine.",
    plea     = "Well, if the situation is that desperate I think it is possible to send some of the golems to help the poor dwarfs out of their misery."
}
local persuasionKeywords = { "flatter", "threaten", "bluff", "impress", "reason", "plea" }

if MsgContains(message, "farmine") and player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas) < 3 then
    if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 then
        if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas) == 1 then
            npcHandler:say("I have heard only little about this mine. I am a bit absorbed in my studies. But what does this mine have to do with me?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        else
            npcHandler:say("You are starting this discussion again? Why should I listen to you this time, do you have anything to convince me to let you even try?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        end
    end

elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
    if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 and player:removeItem(10027, 1) then
        npcHandler:say("Oh how nice of you. I might have misjudged you. So let us return to this matter of worker golems. Do you have any better arguments this time?", npc, creature)
        player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 1)
        npcHandler:setTopic(playerId, 3)
    else
        npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
        player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 2)
        npcHandler:setTopic(playerId, 0)
    end

elseif MsgContains(message, "flatter")
    or MsgContains(message, "threaten")
    or MsgContains(message, "bluff")
    or MsgContains(message, "impress")
    or MsgContains(message, "reason")
    or MsgContains(message, "plea") then

    if npcHandler:getTopic(playerId) == 1 then
        if player:removeItem(10027, 1) then
            for _, keyword in ipairs(persuasionKeywords) do
                if MsgContains(message, keyword) then
                    npcHandler:say(persuasionReplies[keyword], npc, creature)
                    break
                end
            end
            player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 3)
        else
            npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
            player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 2)
        end
        npcHandler:setTopic(playerId, 0)

    elseif npcHandler:getTopic(playerId) == 3 then
        for _, keyword in ipairs(persuasionKeywords) do
            if MsgContains(message, keyword) then
                npcHandler:say(persuasionReplies[keyword], npc, creature)
                break
            end
        end
        player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 3)
        npcHandler:setTopic(playerId, 0)
    end

elseif MsgContains(message, "no") and (npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2) then
    npcHandler:say("Come back when you find any information.", npc, creature)
    npcHandler:setTopic(playerId, 0)
end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello! Sorry I'm a bit busy.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "ancient stone", clientId = 9632, sell = 200 },
	{ itemName = "battle stone", clientId = 11447, sell = 290 },
	{ itemName = "broken gladiator shield", clientId = 9656, sell = 190 },
	{ itemName = "coal", clientId = 12600, sell = 20 },
	{ itemName = "crystal of balance", clientId = 9028, sell = 1000 },
	{ itemName = "crystal of focus", clientId = 9027, sell = 2000 },
	{ itemName = "crystal of power", clientId = 9067, sell = 3000 },
	{ itemName = "crystal pedestal", clientId = 9063, sell = 500 },
	{ itemName = "crystalline spikes", clientId = 16138, sell = 440 },
	{ itemName = "flintstone", clientId = 12806, sell = 800 },
	{ itemName = "gear crystal", clientId = 9655, sell = 200 },
	{ itemName = "gear wheel", clientId = 8775, sell = 500 },
	{ itemName = "huge chunk of crude iron", clientId = 5892, sell = 15000 },
	{ itemName = "magma clump", clientId = 16130, sell = 570 },
	{ itemName = "metal spike", clientId = 10298, sell = 320 },
	{ itemName = "piece of draconian steel", clientId = 5889, sell = 3000 },
	{ itemName = "piece of hell steel", clientId = 5888, sell = 500 },
	{ itemName = "piece of hellfire armor", clientId = 9664, sell = 550 },
	{ itemName = "piece of royal steel", clientId = 5887, sell = 10000 },
	{ itemName = "pulverized ore", clientId = 16133, sell = 400 },
	{ itemName = "shiny stone", clientId = 10310, sell = 500 },
	{ itemName = "stone nose", clientId = 16137, sell = 590 },
	{ itemName = "sulphurous stone", clientId = 10315, sell = 100 },
	{ itemName = "vein of ore", clientId = 16135, sell = 330 },
	{ itemName = "war crystal", clientId = 9654, sell = 460 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)
