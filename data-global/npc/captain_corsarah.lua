local internalNpcName = "Captain Corsarah"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 151,
	lookHead = 40,
	lookBody = 79,
	lookLegs = 100,
	lookFeet = 114,
	lookAddons = 1,
	lookMount = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Passage to Venore? The ship is ready to sail!" },
	{ text = "The next passage to Venore leaves from here." },
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

-- She stands right on the dock the supply ship arrives at (34010, 32476, 6), so she is the way
-- back. 200 gold is the official fare.
local TRAVEL_COST = 200
local VENORE = Position(32954, 32022, 6)

local travelKeyword = keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "Do you seek a passage to Venore for |TRAVELCOST|?", cost = TRAVEL_COST, discount = "postman" })
travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = TRAVEL_COST, discount = "postman", destination = VENORE })
travelKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "The island keeps you a while longer, then.", reset = true })

keywordHandler:addKeyword({ "sail", "passage" }, StdModule.say, { npcHandler = npcHandler, text = "Do you seek a passage to {Venore}?" })
keywordHandler:addKeyword({ "kick" }, StdModule.kick, { npcHandler = npcHandler, destination = { Position(34010, 32476, 6) } })

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Captain Corsarah." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the captain of this sailing ship." })
keywordHandler:addKeyword({ "ship", "route" }, StdModule.say, { npcHandler = npcHandler, text = "The ship connects Thalassara and Venore." })

npcHandler:setMessage(MESSAGE_GREET, "Welcome on board, |PLAYERNAME|. You want to sail to {Venore}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Recommend us if you were satisfied with our service.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
