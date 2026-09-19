local internalNpcName = "Sterling"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Sterling: Pirate outfit (male = 151) with both addons.
-- TODO(colors): confirm head/body/legs/feet via the palette/StaticDataEditor.
npcConfig.outfit = {
	lookType = 151,
	lookHead = 39,
	lookBody = 25,
	lookLegs = 38,
	lookFeet = 26,
	lookAddons = 3,
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
local MORLA_DONE = Storage.Quest.U15_24.Targuna.LongLostTreasure.MorlaDone
local TREASURE_MARKED = Storage.Quest.U15_24.Targuna.LongLostTreasure.TreasureMarked
local TARGUNA_QUESTLINE = Storage.Quest.U15_24.Targuna.Questline

-- Treasure dig spot on Targuna (marked on the player's map when Sterling reads the map).
local TREASURE_SPOT = Position(31948, 31924, 7)
local MIN_LEVEL_TO_TRAVEL = 10

-- Dialog topics
local TOPIC_START_CONFIRM = 1
local TOPIC_MAP_TURNIN = 2

local function greetCallback(npc, creature)
	local player = Player(creature)
	if player:getStorageValue(TREASURE_MISSION) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Ahoyyy there, you might be just who I'm looking for. I need some help on an adventure ...")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Ahoyyy there, back from your quest I see.")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local mission = player:getStorageValue(TREASURE_MISSION)

	if MsgContains(message, "mission") then
		if mission < 1 then
			npcHandler:say({
				"I do have something that's been bothering me as of late. On the closest island, Aragonia, some pirates crash landed.",
				"Ever since they arrived, these pirates have been wreaking havoc on the surrounding islands and capturing wild turtles, including Targuna itself. Could you help me and this island by taking care of this threat with that?",
			}, npc, creature)
			npcHandler:setTopic(playerId, TOPIC_START_CONFIRM)
			return true
		end

		if mission == 1 then
			npcHandler:say("Matilda is waiting for you, just sit on her back whenever you're ready to travel to Aragonia.", npc, creature)
			return true
		end

		if mission == 2 then
			npcHandler:say("Have you dealt with those pirates on Aragonia and saved the turtle eggs yet? Once you have, speak to Morla in the cave to the south of the island.", npc, creature)
			return true
		end

		if mission == 3 then
			npcHandler:say({
				"Oh, would you look at that, you really helped us out here. I'm glad to see you alive and well!",
				"Did Morla hand you anything for your service?",
			}, npc, creature)
			npcHandler:setTopic(playerId, TOPIC_MAP_TURNIN)
			return true
		end

		-- mission >= 4
		npcHandler:say("The X that marks the spot is here on Targuna. Don't wait too long to grab the treasure, it'd be a shame if you were too late ...", npc, creature)
		return true
	end

	if MsgContains(message, "yes") then
		local topic = npcHandler:getTopic(playerId)

		if topic == TOPIC_START_CONFIRM then
			if player:getLevel() < MIN_LEVEL_TO_TRAVEL then
				npcHandler:say("I respect your interest, but you're not strong enough yet. We don't want to risk anything here! Please come back when you're stronger.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			npcHandler:say("Thank you adventurer! In order to travel to Aragonia just sit down on the back of my turtle Matilda here and enjoy the ride - free of charge of course!", npc, creature)
			player:setStorageValue(TREASURE_MISSION, 1)
			if player:getStorageValue(TARGUNA_QUESTLINE) < 1 then
				player:setStorageValue(TARGUNA_QUESTLINE, 1)
			end
			npcHandler:setTopic(playerId, 0)
			return true
		end

		if topic == TOPIC_MAP_TURNIN then
			if player:getStorageValue(MORLA_DONE) ~= 1 then
				npcHandler:say("It seems Morla hasn't handed you anything yet. Make sure to speak with her first.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end
			npcHandler:say({
				"Thank you for bringing me that map. If I see that correctly the X that marks the spot seems to be here on Targuna.",
				"Let me mark it for you, don't wait too long to grab it. It'd be a shame if you were too late ...",
			}, npc, creature)
			player:setStorageValue(TREASURE_MISSION, 4)
			player:setStorageValue(TREASURE_MARKED, 1)
			-- Mark the treasure spot ("X marks the spot") on the player's map.
			player:addMapMark(TREASURE_SPOT, MAPMARK_CROSS, "Treasure")
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	if MsgContains(message, "no") then
		local topic = npcHandler:getTopic(playerId)
		if topic == TOPIC_START_CONFIRM or topic == TOPIC_MAP_TURNIN then
			npcHandler:say("Alright, come back if you change your mind.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	return true
end

-- Keywords / lore
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Sterling's the name, adventuring's the game!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm an old adventurer who's seen his fair share of the seas." })
keywordHandler:addKeyword({ "aragonia" }, StdModule.say, { npcHandler = npcHandler, text = "The closest island, where those pesky pirates crash landed." })
keywordHandler:addKeyword({ "pirates", "pirate" }, StdModule.say, { npcHandler = npcHandler, text = "They've been wreaking havoc and capturing wild turtles. Someone has to stop them!" })
keywordHandler:addKeyword({ "morla" }, StdModule.say, { npcHandler = npcHandler, text = "A dear friend of mine. You'll find her in the cave to the south of Aragonia." })
keywordHandler:addKeyword({ "matilda" }, StdModule.say, { npcHandler = npcHandler, text = "My trusty turtle! Sit on her back and she'll carry you to Aragonia." })

npcHandler:setMessage(MESSAGE_GREET, "Ahoyyy there, you might be just who I'm looking for. I need some help on an adventure ...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Safe travels, adventurer!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Safe travels, adventurer!")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
