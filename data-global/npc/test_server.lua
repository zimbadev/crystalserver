local internalNpcName = "Test Server"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1875,
	lookHead = 58,
	lookBody = 68,
	lookLegs = 109,
	lookFeet = 115,
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

npcHandler:setMessage(MESSAGE_GREET, "Welcome to Test Server")
npcHandler:setMessage(MESSAGE_FAREWELL, "Please come back from time to time.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Please come back from time to time.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "norcferatu skullguard", clientId = 51260, buy = 1 },
	{ itemName = "norcferatu bonehood", clientId = 51261, buy = 1 },
	{ itemName = "norcferatu tuskplate", clientId = 51262, buy = 1 },
	{ itemName = "norcferatu bloodhide", clientId = 51263, buy = 1 },
	{ itemName = "norcferatu bonecloak", clientId = 51264, buy = 1 },
	{ itemName = "norcferatu thornwraps", clientId = 51265, buy = 1 },
	{ itemName = "norcferatu bloodstrider", clientId = 51266, buy = 1 },
	{ itemName = "norcferatu fleshguards", clientId = 51267, buy = 1 },
	{ itemName = "norcferatu goretrampers", clientId = 51268, buy = 1 },
	{ itemName = "norcferatu fangstompers", clientId = 51269, buy = 1 },
	{ itemName = "greater garlic necklace", clientId = 51275, buy = 1 },
	{ itemName = "blank imbuement scroll", clientId = 51442, buy = 1 },
	{ itemName = "etcher", clientId = 51443, buy = 1 },
	{ itemName = "powerful bash scroll", clientId = 51444, buy = 1 },
	{ itemName = "powerful blockade scroll", clientId = 51445, buy = 1 },
	{ itemName = "powerful chop scroll", clientId = 51446, buy = 1 },
	{ itemName = "powerful cloud fabric scroll", clientId = 51447, buy = 1 },
	{ itemName = "powerful demon presence scroll", clientId = 51448, buy = 1 },
	{ itemName = "powerful dragon hide scroll", clientId = 51449, buy = 1 },
	{ itemName = "powerful electrify scroll", clientId = 51450, buy = 1 },
	{ itemName = "powerful epiphany scroll", clientId = 51451, buy = 1 },
	{ itemName = "powerful featherweight scroll", clientId = 51452, buy = 1 },
	{ itemName = "powerful frost scroll", clientId = 51453, buy = 1 },
	{ itemName = "powerful lich shroud scroll", clientId = 51454, buy = 1 },
	{ itemName = "powerful precision scroll", clientId = 51455, buy = 1 },
	{ itemName = "powerful punch scroll", clientId = 51456, buy = 1 },
	{ itemName = "powerful quara scale scroll", clientId = 51457, buy = 1 },
	{ itemName = "powerful reap scroll", clientId = 51458, buy = 1 },
	{ itemName = "powerful scorch scroll", clientId = 51459, buy = 1 },
	{ itemName = "powerful slash scroll", clientId = 51460, buy = 1 },
	{ itemName = "powerful snake skin scroll", clientId = 51461, buy = 1 },
	{ itemName = "powerful strike scroll", clientId = 51462, buy = 1 },
	{ itemName = "powerful swiftness scroll", clientId = 51463, buy = 1 },
	{ itemName = "powerful vampirism scroll", clientId = 51464, buy = 1 },
	{ itemName = "powerful venom scroll", clientId = 51465, buy = 1 },
	{ itemName = "powerful vibrancy scroll", clientId = 51466, buy = 1 },
	{ itemName = "powerful void scroll", clientId = 51467, buy = 1 },
	{ itemName = "proficiency catalyst", clientId = 51588, buy = 1 },
	{ itemName = "greater proficiency catalyst", clientId = 51589, buy = 1 },
	{ itemName = "ink sword", clientId = 51666, buy = 1 },
	{ itemName = "intricate bash scroll", clientId = 51724, buy = 1 },
	{ itemName = "intricate blockade scroll", clientId = 51725, buy = 1 },
	{ itemName = "intricate chop scroll", clientId = 51726, buy = 1 },
	{ itemName = "intricate cloud fabric scroll", clientId = 51727, buy = 1 },
	{ itemName = "intricate demon presence scroll", clientId = 51728, buy = 1 },
	{ itemName = "intricate dragon hide scroll", clientId = 51729, buy = 1 },
	{ itemName = "intricate electrify scroll", clientId = 51730, buy = 1 },
	{ itemName = "intricate epiphany scroll", clientId = 51731, buy = 1 },
	{ itemName = "intricate featherweight scroll", clientId = 51732, buy = 1 },
	{ itemName = "intricate frost scroll", clientId = 51733, buy = 1 },
	{ itemName = "intricate lich shroud scroll", clientId = 51734, buy = 1 },
	{ itemName = "intricate precision scroll", clientId = 51735, buy = 1 },
	{ itemName = "intricate punch scroll", clientId = 51736, buy = 1 },
	{ itemName = "intricate quara scale scroll", clientId = 51737, buy = 1 },
	{ itemName = "intricate reap scroll", clientId = 51738, buy = 1 },
	{ itemName = "intricate scorch scroll", clientId = 51739, buy = 1 },
	{ itemName = "intricate slash scroll", clientId = 51740, buy = 1 },
	{ itemName = "intricate snake skin scroll", clientId = 51741, buy = 1 },
	{ itemName = "intricate strike scroll", clientId = 51742, buy = 1 },
	{ itemName = "intricate swiftness scroll", clientId = 51743, buy = 1 },
	{ itemName = "intricate vampirism scroll", clientId = 51744, buy = 1 },
	{ itemName = "intricate venom scroll", clientId = 51745, buy = 1 },
	{ itemName = "intricate vibrancy scroll", clientId = 51746, buy = 1 },
	{ itemName = "intricate void scroll", clientId = 51747, buy = 1 },
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
