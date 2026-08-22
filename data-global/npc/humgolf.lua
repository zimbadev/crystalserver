local internalNpcName = "Humgolf"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 69,
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
		flatter = "Yeah, of course they can't do without my worms. Mining and worms go hand in hand. Well, in the case of the worms it is only an imaginary hand of course. I'll send them some of my finest worms.",
		threaten = "Hah! Now you talk like a dwarf! That's the spirit! Of course you can have some of my worms. I'll send a bunch to Farmine as soon as possible.",
		bluff = "Golden eggs and a fountain of youth? Bah, sounds like dwarf tales to me, but I like a good story. I'll send some worms along to see for myself.",
		impress = "Hrmpf, a whole new frontier indeed. Can't let the others have all the fun without my worms being part of it. I'll send some over.",
		reason = "Hm, you make a fair point. My worms could use some fresh soil to dig through anyway. I'll send some to Farmine.",
		plea = "Alright, alright, stop your whining! I'll send some worms to Farmine, just to get some peace and quiet.",
	}
	local persuasionKeywords = { "flatter", "threaten", "bluff", "impress", "reason", "plea" }

	if MsgContains(message, "farmine") and player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf) < 3 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 then
			if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf) == 1 then
				npcHandler:say("Bah, Farmine here, Farmine there. Is there nothing else than Farmine to talk about these days? Hrmpf, whatever. So what do you want?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("You are here to apologise? Have you got anything that would make me reconsider my decision never to talk to you again about this subject?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 and player:removeItem(10026, 1) then
			npcHandler:say("Uh, how cute! Look how he's snapping for my fingers! You really know how to make an old dwarf happy! Well, so let's try again. Why do you think I should send my precious worms to Farmine?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf, 1)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf, 2)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flatter") or MsgContains(message, "threaten") or MsgContains(message, "bluff") or MsgContains(message, "impress") or MsgContains(message, "reason") or MsgContains(message, "plea") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(10026, 1) then
				for _, keyword in ipairs(persuasionKeywords) do
					if MsgContains(message, keyword) then
						npcHandler:say(persuasionReplies[keyword], npc, creature)
						break
					end
				end
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf, 3)
			else
				npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf, 2)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			for _, keyword in ipairs(persuasionKeywords) do
				if MsgContains(message, keyword) then
					npcHandler:say(persuasionReplies[keyword], npc, creature)
					break
				end
			end
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf, 3)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") and (npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2) then
		npcHandler:say("Come back when you find any information.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "|PLAYERNAME|, good day .. or night, whatever.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
