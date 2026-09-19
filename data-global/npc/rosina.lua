local internalNpcName = "Rosina"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 140,
	lookHead = 78,
	lookBody = 39,
	lookLegs = 39,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Rosina." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am here to help travelers and adventurers who pass through." })
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "I can provide information about the surrounding area and its dangers." })
keywordHandler:addKeyword({ "danger" }, StdModule.say, { npcHandler = npcHandler, text = "There are many creatures out there. Be prepared before you venture forth." })
keywordHandler:addKeyword({ "advice" }, StdModule.say, { npcHandler = npcHandler, text = "Always be prepared for the unexpected. Bring enough supplies and stay alert." })

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|! How may I assist you today?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Take care out there!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
