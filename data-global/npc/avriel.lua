local internalNpcName = "Avriel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 472,
	lookHead = 78,
	lookBody = 25,
	lookLegs = 32,
	lookFeet = 118,
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Avriel is the name, I take care of all goods, gear and supplies. Though I'm also a great at chest, ah nevermind...." })
keywordHandler:addKeyword({ "avriel" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, that's me." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the shop owner here, if you're interested ask me for a {trade}." })
keywordHandler:addKeyword({ "shop", "goods", "equipment", "potions" }, StdModule.say, { npcHandler = npcHandler, text = "I am selling all kinds of equipment. Let me know if you're interested in a {trade}." })
keywordHandler:addKeyword({ "quest", "mission" }, StdModule.say, { npcHandler = npcHandler, text = "Quest? Oh no, I can't help you with that. But maybe {Viola} or {Gustavo} could use some help." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Our King Tibianus rules over everything." })
keywordHandler:addKeyword({ "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Our King Tibianus rules over everything." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "You should visit Thais someday, it's our capital with lots of shops, trainers and great people." })
keywordHandler:addKeyword({ "newhaven", "island" }, StdModule.say, { npcHandler = npcHandler, text = "Ever since I moved here, life has just been great, if only those goblins wouldn't terrorise us. Maybe you could help us, talk to {Gustavo} for more information." })
keywordHandler:addKeyword({ "gustavo" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, my good friend Gustavo, he's keeping us safe from the north part of this island. I heard he's talking about needing some assistance, if you're interested don't be shy to talk to him." })
keywordHandler:addKeyword({ "viola" }, StdModule.say, { npcHandler = npcHandler, text = "Viola always wins on our quiz nights, one can really learn much from her. I guess if your interested in learning more, she's the right person to talk to." })
keywordHandler:addKeyword({ "flavius" }, StdModule.say, { npcHandler = npcHandler, text = "Flavius is running the bank here in Newhaven." })
keywordHandler:addKeyword({ "anna" }, StdModule.say, { npcHandler = npcHandler, text = "Anna often travels to the mainland to get supplies for my shop, it's great working with her. You can find her at the ferry house just north of here." })
keywordHandler:addKeyword({ "tim" }, StdModule.say, { npcHandler = npcHandler, text = "If you ever need someone to handle the ugly things, he's your guard to do it." })
keywordHandler:addKeyword({ "guard" }, StdModule.say, { npcHandler = npcHandler, text = "Oh yes, our Gustavo is the guard here in Newhaven. I heard he could use some help with the muglex problem, though." })
keywordHandler:addKeyword({ "muglex" }, StdModule.say, { npcHandler = npcHandler, text = "These little creatures have been terrorising our village for quite some time now, I just hope we stay safe here." })
keywordHandler:addKeyword({ "goblin", "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "These little creatures have been terrorising our village for quite some time now, I just hope we stay safe here." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "Legends say that a tragic accident buried a group of miners alive. Since then their souls have been roaming these tunnels, willing to find their next victim. So please be careful there!" })
keywordHandler:addKeyword({ "mainland" }, StdModule.say, { npcHandler = npcHandler, text = "I once lived on the mainland a long time ago, I was working at a shop in Yalahar, but they had to close it due to some monster problems." })

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my little shop, |PLAYERNAME|! Are you looking to {trade} anything precious?")
npcHandler:setMessage(MESSAGE_FAREWELL, "See you around, adventurer.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "See you around, adventurer.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, take a look and see what might interest you.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bone sword", clientId = 3338, buy = 75 },
	{ itemName = "bow", clientId = 3350, buy = 350 },
	{ itemName = "fish", clientId = 3578, buy = 5 },
	{ itemName = "health potion", clientId = 266, buy = 50 },
	{ itemName = "light jo staff", clientId = 50166, buy = 250 },
	{ itemName = "light stone shower rune", clientId = 3178, buy = 25 },
	{ itemName = "lightest missile rune", clientId = 3174, buy = 20 },
	{ itemName = "mace", clientId = 3286, buy = 90 },
	{ itemName = "mana potion", clientId = 268, buy = 56 },
	{ itemName = "rapier", clientId = 3272, buy = 15 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "short sword", clientId = 3294, buy = 30 },
	{ itemName = "simple arrow", clientId = 21470, buy = 2 },
	{ itemName = "spear", clientId = 3277, buy = 10 },
	{ itemName = "the chiller", clientId = 21350, buy = 250 },
	{ itemName = "the scorcher", clientId = 21348, buy = 250 },
	{ itemName = "white mushroom", clientId = 3723, buy = 6 },

	{ itemName = "axe", clientId = 3274, sell = 7 },
	{ itemName = "bone club", clientId = 3337, sell = 5 },
	{ itemName = "bone sword", clientId = 3338, sell = 20 },
	{ itemName = "brass armor", clientId = 3359, sell = 150 },
	{ itemName = "brass legs", clientId = 3372, sell = 49 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "fish", clientId = 3578, sell = 2 },
	{ itemName = "longsword", clientId = 3285, sell = 51 },
	{ itemName = "mace", clientId = 3286, sell = 30 },
	{ itemName = "mage hat", clientId = 7992, sell = 25 },
	{ itemName = "magician's robe", clientId = 7991, sell = 150 },
	{ itemName = "plain monk robe", clientId = 50257, sell = 1 },
	{ itemName = "ranger legs", clientId = 8095, sell = 36 },
	{ itemName = "ranger's cloak", clientId = 3571, sell = 150 },
	{ itemName = "refined bow", clientId = 51760, sell = 150 },
	{ itemName = "rope", clientId = 3003, sell = 8 },
	{ itemName = "short sword", clientId = 3294, sell = 10 },
	{ itemName = "simple jo staff", clientId = 51119, sell = 10 },
	{ itemName = "small axe", clientId = 3462, sell = 5 },
	{ itemName = "snakebite rod", clientId = 3066, sell = 100 },
	{ itemName = "soldier helmet", clientId = 3375, sell = 16 },
	{ itemName = "spear", clientId = 3277, sell = 3 },
	{ itemName = "spellbook", clientId = 3059, sell = 30 },
	{ itemName = "stealth ring", clientId = 3049, sell = 200 },
	{ itemName = "steel shield", clientId = 3409, sell = 80 },
	{ itemName = "stone skin amulet", clientId = 3081, sell = 500 },
	{ itemName = "wand of vortex", clientId = 3074, sell = 100 },
	{ itemName = "white mushroom", clientId = 3723, sell = 2 },
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

-- npcType registering the npcConfig table

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)
