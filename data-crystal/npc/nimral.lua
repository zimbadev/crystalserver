local internalNpcName = "Nimral"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 114,
	lookBody = 119,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Come travel with me traveler." },
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

local function addTravelKeyword(keyword, text, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = text, cost = cost, discount = "postman" })
	travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, text = "Hold on!", cost = cost, discount = "postman", destination = destination })
	travelKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "You shouldn't miss the experience.", reset = true })
end

addTravelKeyword("karmia", "Should I bring you to Karmia for 200 gold?", 200, Position(454, 480, 6))
addTravelKeyword("folda", "Should I bring you to Folda for 150 gold?", 150, Position(266, 316, 6))
addTravelKeyword("desert", "Should I bring you to Desert City for 120 gold?", 120, Position(399, 481, 6))
addTravelKeyword("inferno", "Should I bring you to Inferno for 150 gold?", 150, Position(517, 437, 6))
addTravelKeyword("venore", "Should I bring you to Venore for 130 gold?", 130, Position(431, 420, 6))

keywordHandler:addKeyword({ "sail" }, StdModule.say, { npcHandler = npcHandler, text = "Welcome on board, noble |PLAYERNAME|. I can bring you to {Karmia}, {Folda}, {Desert}, {Inferno} or {Venore}. Where would you like to go?." })
keywordHandler:addKeyword({ "passage" }, StdModule.say, { npcHandler = npcHandler, text = "Welcome on board, noble |PLAYERNAME|. I can bring you to {Karmia}, {Folda}, {Desert}, {Inferno} or {Venore}. Where would you like to go?." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the captain of this ship." })
keywordHandler:addKeyword({ "captain" }, StdModule.say, { npcHandler = npcHandler, text = "I am the captain of this ship." })

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I can travel to {Karmia}, {Folda}, {Desert}, {Inferno} and {Venore}. Where would you like to go?.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
