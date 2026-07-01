local internalNpcName = "Aurelia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Aurelia: Breezy Garb outfit (female = 1246) with addon 1.
npcConfig.outfit = {
	lookType = 1246,
	lookHead = 77,
	lookBody = 86,
	lookLegs = 94,
	lookFeet = 60,
	lookAddons = 1,
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Aurelia." })
keywordHandler:addKeyword({ "aurelia" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, that's me." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the equipment trader here in Targuna. Ask me for a {trade} if you're interested." })
keywordHandler:addKeyword({ "shop", "goods", "equipment" }, StdModule.say, { npcHandler = npcHandler, text = "I am selling all kinds of equipment. Let me know if you're interested in a {trade}." })
keywordHandler:addKeyword({ "mission", "quest" }, StdModule.say, { npcHandler = npcHandler, text = "I'm just a trader. But ask around, maybe someone else could need your help." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "This little island is my home. Travellers always need good gear, so business is steady." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is our beautiful capital, ruled by our beloved king Tibianus III." })

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my {shop}! Are you looking for a {trade}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "See you around, adventurer.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "See you around, adventurer.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, take a look and see what might interest you.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	-- Sells (player buys)
	{ itemName = "arrow", clientId = 3447, buy = 3 },
	{ itemName = "bone sword", clientId = 3338, buy = 75 },
	{ itemName = "bow", clientId = 3350, buy = 350 },
	{ itemName = "fish", clientId = 3578, buy = 5 },
	{ itemName = "health potion", clientId = 266, buy = 50 },
	{ itemName = "light jo staff", clientId = 50166, buy = 250 },
	{ itemName = "light stone shower rune", clientId = 3178, buy = 25 },
	{ itemName = "lightest missile rune", clientId = 3174, buy = 20 },
	{ itemName = "mace", clientId = 3286, buy = 90 },
	{ itemName = "mana potion", clientId = 268, buy = 56 },
	{ itemName = "quiver", clientId = 35562, buy = 400 },
	{ itemName = "rapier", clientId = 3272, buy = 15 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "short sword", clientId = 3294, buy = 26 },
	{ itemName = "shovel", clientId = 3457, buy = 9 },
	{ itemName = "spear", clientId = 3277, buy = 9 },
	{ itemName = "the chiller", clientId = 21350, buy = 250 },
	{ itemName = "the scorcher", clientId = 21348, buy = 250 },
	{ itemName = "white mushroom", clientId = 3723, buy = 6 },

	-- Buys (player sells)
	{ itemName = "axe", clientId = 3274, sell = 7 },
	{ itemName = "bandana", clientId = 5917, sell = 150 },
	{ itemName = "bone club", clientId = 3337, sell = 5 },
	{ itemName = "bone sword", clientId = 3338, sell = 20 },
	{ itemName = "brass armor", clientId = 3359, sell = 150 },
	{ itemName = "brass legs", clientId = 3372, sell = 49 },
	{ itemName = "charmer's tiara", clientId = 3407, sell = 900 },
	{ itemName = "charred mask", clientId = 52964, sell = 1500 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "fire mushroom", clientId = 3731, sell = 200 },
	{ itemName = "fish", clientId = 3578, sell = 2 },
	{ itemName = "giant shimmering pearl", clientId = 281, sell = 3000 },
	{ itemName = "gold tooth", clientId = 53002, sell = 120 },
	{ itemName = "hatchet", clientId = 3276, sell = 25 },
	{ itemName = "infernoid ember", clientId = 53004, sell = 160 },
	{ itemName = "lizard leather", clientId = 5876, sell = 150 },
	{ itemName = "lizard scale", clientId = 5881, sell = 120 },
	{ itemName = "lizard tail", clientId = 53003, sell = 95 },
	{ itemName = "longsword", clientId = 3285, sell = 51 },
	{ itemName = "mace", clientId = 3286, sell = 30 },
	{ itemName = "mage hat", clientId = 7992, sell = 25 },
	{ itemName = "magician's robe", clientId = 7991, sell = 150 },
	{ itemName = "meat", clientId = 3577, sell = 2 },
	{ itemName = "plain monk robe", clientId = 50257, sell = 1 },
	{ itemName = "ranger legs", clientId = 8095, sell = 36 },
	{ itemName = "ranger's cloak", clientId = 3571, sell = 150 },
	{ itemName = "refined bow", clientId = 51760, sell = 150 },
	{ itemName = "rope", clientId = 3003, sell = 15 },
	{ itemName = "sabre", clientId = 3273, sell = 12 },
	{ itemName = "salamander shield", clientId = 3445, sell = 280 },
	{ itemName = "scale armor", clientId = 3377, sell = 75 },
	{ itemName = "sentinel shield", clientId = 3444, sell = 120 },
	{ itemName = "shovel", clientId = 3457, sell = 8 },
	{ itemName = "simple jo staff", clientId = 51119, sell = 10 },
	{ itemName = "small axe", clientId = 3462, sell = 5 },
	{ itemName = "small emerald", clientId = 3032, sell = 250 },
	{ itemName = "snakebite rod", clientId = 3066, sell = 100 },
	{ itemName = "soldier helmet", clientId = 3375, sell = 16 },
	{ itemName = "spear", clientId = 3277, sell = 3 },
	{ itemName = "spellbook", clientId = 3059, sell = 30 },
	{ itemName = "steel shield", clientId = 3409, sell = 80 },
	{ itemName = "stealth ring", clientId = 3049, sell = 200 },
	{ itemName = "templar scytheblade", clientId = 3345, sell = 200 },
	{ itemName = "throwing knife", clientId = 3298, sell = 2 },
	{ itemName = "wand of vortex", clientId = 3074, sell = 100 },
	{ itemName = "white mushroom", clientId = 3723, sell = 2 },
	{ itemName = "wolf paw", clientId = 5897, sell = 70 },
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
