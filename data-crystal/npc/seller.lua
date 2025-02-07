local internalNpcName = "Seller"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 3

npcConfig.outfit = {
	lookType = 134,
	lookHead = 114,
	lookBody = 113,
	lookLegs = 113,
	lookFeet = 133,
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

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I sell amulet of loss, backpacks, light shovel, shovel and rope")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, |PLAYERNAME|, may the winds guide your way.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back soon!")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Take all the time you need to decide what you want!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "amulet of loss", clientId = 3057, buy = 50000 },
	{ itemName = "backpack", clientId = 2854, buy = 20 },
	{ itemName = "green backpack", clientId = 2865, buy = 20 },
	{ itemName = "yellow backpack", clientId = 2866, buy = 20 },
	{ itemName = "red backpack", clientId = 2867, buy = 20 },
	{ itemName = "purple backpack", clientId = 2868, buy = 20 },
	{ itemName = "blue backpack", clientId = 2869, buy = 20 },
	{ itemName = "grey backpack", clientId = 2870, buy = 20 },
	{ itemName = "golden backpack", clientId = 2871, buy = 20 },
	{ itemName = "camouflage backpack", clientId = 2872, buy = 20 },
	{ itemName = "jewelled backpack", clientId = 5801, buy = 20 },
	{ itemName = "pirate backpack", clientId = 5926, buy = 20 },
	{ itemName = "beach backpack", clientId = 5949, buy = 20 },
	{ itemName = "fur backpack", clientId = 7342, buy = 20 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "shovel", clientId = 3457, buy = 50 },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
