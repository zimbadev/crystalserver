local internalNpcName = "Eremo"
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
	lookHead = 0,
	lookBody = 109,
	lookLegs = 128,
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

local node1 = keywordHandler:addKeyword({ "first bless" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Do you want to buy the first blessing for 10000 gold?" })
node1:addChildKeyword({ "yes" }, StdModule.bless, { npcHandler = npcHandler, bless = 1, premium = true, cost = 10000 })
node1:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, reset = true, text = "Too expensive, eh?" })

local node2 = keywordHandler:addKeyword({ "second bless" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Do you want to buy the second blessing for 10000 gold?" })
node2:addChildKeyword({ "yes" }, StdModule.bless, { npcHandler = npcHandler, bless = 2, premium = true, cost = 10000 })
node2:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, reset = true, text = "Too expensive, eh?" })

local node3 = keywordHandler:addKeyword({ "third bless" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Do you want to buy the third blessing for 10000 gold?" })
node3:addChildKeyword({ "yes" }, StdModule.bless, { npcHandler = npcHandler, bless = 3, premium = true, cost = 10000 })
node3:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, reset = true, text = "Too expensive, eh?" })

local node4 = keywordHandler:addKeyword({ "fourth bless" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Do you want to buy the fourth blessing for 10000 gold?" })
node4:addChildKeyword({ "yes" }, StdModule.bless, { npcHandler = npcHandler, bless = 4, premium = true, cost = 10000 })
node4:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, reset = true, text = "Too expensive, eh?" })

local node5 = keywordHandler:addKeyword({ "fifth bless" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Do you want to buy the fifth blessing for 10000 gold?" })
node5:addChildKeyword({ "yes" }, StdModule.bless, { npcHandler = npcHandler, bless = 5, premium = true, cost = 10000 })
node5:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, reset = true, text = "Too expensive, eh?" })

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my little garden, adventurer |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "It was a pleasure to help you, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "It was a pleasure to help you, |PLAYERNAME|.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
