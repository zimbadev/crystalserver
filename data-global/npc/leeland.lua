local internalNpcName = "Leeland"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 19,
	lookBody = 53,
	lookLegs = 15,
	lookFeet = 95,
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

	-- The New Frontier
	local persuasionReplies = {
		flatter = "Flattery will get you far with us dwarves, my friend. Very well, I'll lend a hand to your cause.",
		threaten = "Threats? Bah, you'll have to do better than that to scare a dwarf. Still, I admire the nerve. Fine, I'll help, if only to see what you're really made of.",
		bluff = "Golden hens and a fountain of youth, you say? Ha! Even if half of that is nonsense, the other half is worth a look. I'll send some of our folk to investigate.",
		impress = "Hah, I am rather impressed by your resolve. Very well, I'll lend you my assistance. But listen, one day I'll ask you to return this favour. From now on, you owe me one.",
		reason = "The idea of a promising market and new resources suits us quite well. I think it is reasonable to send some assistance.",
		plea = "Your pathetic whimpering amuses me. For this I grant you my assistance. But listen, one day I'll ask you to return this favour. From now on, you owe me one.",
	}
	local persuasionKeywordsLeeland = { "flatter", "threaten", "bluff", "impress", "reason", "plea" }

	if MsgContains(message, "farmine") and player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland) < 3 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 then
			if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland) == 1 then
				npcHandler:say("Oh yes, that project the whole dwarven community is so excited about. I guess I already know why you are here, but speak up.", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("Oh yes, that project the whole dwarven community is so excited about. I guess I already know why you are here, but speak up. Do you want to try again?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 and player:removeItem(10028, 1) then
			npcHandler:say("Oh how nice of you. I might have misjudged you. So let us return to this matter of persuasion. Do you have any better arguments this time?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland, 1)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland, 2)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flatter") or MsgContains(message, "threaten") or MsgContains(message, "bluff") or MsgContains(message, "impress") or MsgContains(message, "reason") or MsgContains(message, "plea") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(10028, 1) then
				for _, keyword in ipairs(persuasionKeywordsLeeland) do
					if MsgContains(message, keyword) then
						npcHandler:say(persuasionReplies[keyword], npc, creature)
						break
					end
				end
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland, 3)
			else
				npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland, 2)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			for _, keyword in ipairs(persuasionKeywordsLeeland) do
				if MsgContains(message, keyword) then
					npcHandler:say(persuasionReplies[keyword], npc, creature)
					break
				end
			end
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland, 3)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") and (npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2) then
		npcHandler:say("Come back when you find any information.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
