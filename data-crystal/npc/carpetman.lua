local internalNpcName = "Carpetman"
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
	lookHead = 114,
	lookBody = 77,
	lookLegs = 77,
	lookFeet = 114,
	lookAddons = 3,
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

addTravelKeyword("premium island", "Should I bring you to Premium island for 200 gold?", 200, Position(435, 623, 6))
addTravelKeyword("tortoise", "Should I bring you to Torrtoise for 150 gold?", 150, Position(620, 627, 7))
addTravelKeyword("karmia", "Should I bring you to Karmia for 250 gold?", 250, Position(520, 533, 6))
addTravelKeyword("tiquanda", "Should I bring you to Tiquanda for 150 gold?", 150, Position(567, 464, 6))
addTravelKeyword("liberty bay", "Should I bring you to Venore for 130 gold?", 130, Position(567, 696, 6))
addTravelKeyword("cobra bastion", "Should I bring you to Venore for 130 gold?", 130, Position(221, 608, 7))

keywordHandler:addKeyword({ "sail" }, StdModule.say, { npcHandler = npcHandler, text = "Welcome on board, noble |PLAYERNAME|. I can bring you to {Premium Island}, {Karmia}, {Cobra Bastion}, {Tiquanda}, {Liberty Bay} or {Tortoise}. Where would you like to go?." })
keywordHandler:addKeyword({ "passage" }, StdModule.say, { npcHandler = npcHandler, text = "Welcome on board, noble |PLAYERNAME|. I can bring you to {Premium Island}, {Karmia}, {Tiquanda}, {Liberty Bay} or {Tortoise}. Where would you like to go?." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the captain of this ship." })
keywordHandler:addKeyword({ "captain" }, StdModule.say, { npcHandler = npcHandler, text = "I am the captain of this ship." })

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I can travel to {Premium Island}, {Karmia}, {Cobra Bastion}, {Tiquanda}, {Liberty Bay} or {Tortoise}. Where would you like to go?.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
