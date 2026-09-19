local internalNpcName = "Morla"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Morla is a turtle (tortoise creature outfit 197).
npcConfig.outfit = {
	lookType = 197,
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

-- Quest storage keys (A long lost treasure)
local TREASURE_MISSION = Storage.Quest.U15_24.Targuna.LongLostTreasure.Mission
local PIRATE_KILL_COUNT = Storage.Quest.U15_24.Targuna.LongLostTreasure.PirateKillCount
local TORTOISE_EGG_COUNT = Storage.Quest.U15_24.Targuna.LongLostTreasure.TortoiseEggCount
local MORLA_DONE = Storage.Quest.U15_24.Targuna.LongLostTreasure.MorlaDone

local PIRATES_REQUIRED = 20
local EGGS_REQUIRED = 10

local OLD_TREASURE_MAP_ID = 53158

-- Dialog topics
local TOPIC_TURNIN = 1

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(MORLA_DONE) == 1 then
			npcHandler:say("Thank you again for saving my eggs and dealing with those pirates. Go and see where that map leads you!", npc, creature)
			return true
		end

		if player:getStorageValue(TREASURE_MISSION) < 1 then
			npcHandler:say("Oh, you wandered all the way here? Talk to Sterling on Targuna, he'll tell you how you can help us.", npc, creature)
			return true
		end

		npcHandler:say({
			"Yes, I indeed have a mission for you though I bet Sterling might have already told you about it.",
			"Please take care of these pirates and collect and save my eggs around the island, did you already complete your objective?",
		}, npc, creature)
		npcHandler:setTopic(playerId, TOPIC_TURNIN)
		return true
	end

	if MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == TOPIC_TURNIN then
			npcHandler:setTopic(playerId, 0)

			if player:getStorageValue(MORLA_DONE) == 1 then
				npcHandler:say("You already saved my eggs, thank you again!", npc, creature)
				return true
			end

			local pirates = math.max(player:getStorageValue(PIRATE_KILL_COUNT), 0)
			local eggs = math.max(player:getStorageValue(TORTOISE_EGG_COUNT), 0)
			if pirates < PIRATES_REQUIRED or eggs < EGGS_REQUIRED then
				npcHandler:say(string.format("Not quite yet! You still need to defeat %d more pirates and rescue %d more eggs around the island.", math.max(PIRATES_REQUIRED - pirates, 0), math.max(EGGS_REQUIRED - eggs, 0)), npc, creature)
				return true
			end

			npcHandler:say({
				"Thank you so much for taking care of these pirates and collecting these precious eggs. Here take this as a sign of gratitude, I found it laying around in the sand near a rock, it might be useful once you've encrypted it.",
				"I bet Sterling can help you with that, now go and see where this map leads you, take care adventurer!",
			}, npc, creature)
			if OLD_TREASURE_MAP_ID > 0 then
				player:addItem(OLD_TREASURE_MAP_ID, 1)
			end
			player:setStorageValue(MORLA_DONE, 1)
			player:setStorageValue(TREASURE_MISSION, 3)
			return true
		end
	end

	if MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == TOPIC_TURNIN then
			npcHandler:say("Please hurry, those pirates won't stop on their own and my eggs need saving!", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	return true
end

-- Keywords / lore
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Morla, guardian of these turtles." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I watch over the wild turtles and their eggs on Aragonia." })
keywordHandler:addKeyword({ "sterling" }, StdModule.say, { npcHandler = npcHandler, text = "An old friend of mine from Targuna. I bet he sent you here." })
keywordHandler:addKeyword({ "pirates", "pirate" }, StdModule.say, { npcHandler = npcHandler, text = "They've been capturing turtles and stealing eggs. Please put a stop to them!" })
keywordHandler:addKeyword({ "eggs", "egg" }, StdModule.say, { npcHandler = npcHandler, text = "My precious turtle eggs are scattered all over the island. Please rescue them!" })

npcHandler:setMessage(MESSAGE_GREET, "Oh hello, I wasn't expecting anyone so soon ... What has Sterling told you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Take care, adventurer!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Take care, adventurer!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
