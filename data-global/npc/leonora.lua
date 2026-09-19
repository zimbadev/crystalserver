local internalNpcName = "Leonora"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Leonora: Illuminator outfit (female = 1861), no addons.
-- TODO(colors): confirm head/body/legs/feet via the palette/StaticDataEditor.
npcConfig.outfit = {
	lookType = 1861,
	lookHead = 114,
	lookBody = 94,
	lookLegs = 86,
	lookFeet = 0,
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

-- Keywords about NPCs and topics
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Leonora." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I run the post office here in Targuna. Ask me for a {trade} if you need parcels, letters or labels." })
keywordHandler:addKeyword({ "parcel", "parcels", "post office", "post" }, StdModule.say, { npcHandler = npcHandler, text = "I sell parcels, letters and labels. Ask me for a {trade} if you're interested." })
keywordHandler:addKeyword({ "mission", "quest" }, StdModule.say, { npcHandler = npcHandler, text = "I'm just the postwoman here. But ask around, maybe someone else could need your help." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "Even on a small island like Targuna, the post must arrive!" })

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my post office! I can sell you {parcels} and the like.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye and take care.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye and take care.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, take a look at what I have to offer.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "parcel", clientId = 3503, buy = 15 },
	{ itemName = "letter", clientId = 3505, buy = 8 },
	{ itemName = "label", clientId = 3507, buy = 1 },
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

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
