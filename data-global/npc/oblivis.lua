local internalNpcName = "Oblivis"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1221,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 114,
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

	if MsgContains(message, "reset quest") then
		npcHandler:say("I don't have a quest for you exactly. Though I could help you {replay} certain experiences with the help of my {spell}.", npc, creature)
		return true
	end

	if MsgContains(message, "replay") then
		npcHandler:say("Wouldn't it be nice to go back and do things differently? I might have the right {spell} that could help you with that.", npc, creature)
		return true
	end

	if MsgContains(message, "spell") then
		npcHandler:say("What experience should I let people forget with my spell?", npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if npcHandler:getTopic(playerId) == 1 then
		if MsgContains(message, "jack in the future") or MsgContains(message, "jack") then
			npcHandler:say("Jack? Ah yes, you must have done some quest for Spectulus, would you like to play those memories again? I could help you with that, for a price obviously.", npc, creature)
			npcHandler:setTopic(playerId, 2)
			return true
		end
	end

	if MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Are you sure, you want to spend 100000000 gold to be able to replay this quest?", npc, creature)
			npcHandler:setTopic(playerId, 3)
			return true
		elseif npcHandler:getTopic(playerId) == 3 then
			-- Check if player has enough gold
			if player:removeMoney(100000000) then
				-- Reset the quest storage (this would need actual storage keys)
				npcHandler:say("Done. The memories have been erased. You may now experience the quest anew.", npc, creature)
				-- player:setStorageValue(JACK_IN_THE_FUTURE_QUEST, -1) -- Example reset
			else
				npcHandler:say("You don't have enough gold for this service.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	if MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) >= 2 then
			npcHandler:say("Perhaps another time then. The memories will wait.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end

	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Oblivis, keeper of forgotten memories." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I have the power to make you forget certain {quests} you have completed, allowing you to experience them anew." })
keywordHandler:addKeyword({ "quest" }, StdModule.say, { npcHandler = npcHandler, text = "Some quests can be {reset} if you wish to attempt them again or choose a different path." })
keywordHandler:addKeyword({ "quests" }, StdModule.say, { npcHandler = npcHandler, text = "Some quests can be {reset} if you wish to attempt them again or choose a different path." })
keywordHandler:addKeyword({ "forget" }, StdModule.say, { npcHandler = npcHandler, text = "Forgetting is sometimes necessary to move forward. I can help you with that." })
keywordHandler:addKeyword({ "memory" }, StdModule.say, { npcHandler = npcHandler, text = "Memories can be a burden. I help those who wish to start anew." })
keywordHandler:addKeyword({ "achievement" }, StdModule.say, { npcHandler = npcHandler, text = "By resetting certain quests, you can obtain achievements that were previously locked due to your past choices." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, adventurer! How can I help you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "May your memories serve you well... or not at all.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Until we meet again...")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
