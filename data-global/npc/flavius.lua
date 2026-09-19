local internalNpcName = "Flavius"
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
	lookHead = 39,
	lookBody = 44,
	lookLegs = 49,
	lookFeet = 76,
	lookAddons = 1,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 10000,
	chance = 50,
	{ text = "Any questions about the functions of your bank account? Feel free to ask me for help!" },
	{ text = "Deposit your money here!" },
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

-- NPC dialog options for banker
npcType:addDialogOptions("withdraw", "deposit all", "balance")
npcType:speechBubble(SPEECHBUBBLE_TRADE)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- Parse bank
	npc:parseBank(message, npc, creature, npcHandler)
	-- Parse guild bank
	npc:parseGuildBank(message, npc, creature, playerId, npcHandler)
	-- Normal messages
	npc:parseBankMessages(message, npc, creature, npcHandler)
	return true
end

-- Keywords about NPCs and topics
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Flavius, how may I assist you today?" })
keywordHandler:addKeyword({ "flavius" }, StdModule.say, { npcHandler = npcHandler, text = "Mhm?" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I`m the banker here in Newhaven. It's my job to manage your bank account and change currencies. Though I may also help with questions you might have." })
keywordHandler:addKeyword({ "mission", "quest" }, StdModule.say, { npcHandler = npcHandler, text = "I'm just a banker, ask around maybe someone else could need your help." })
keywordHandler:addKeyword({ "anna" }, StdModule.say, { npcHandler = npcHandler, text = "She often travels to the mainland for supplies. I bet she can help you once you've reached level 8. You can find her at the ferry house just west of here." })
keywordHandler:addKeyword({ "avriel" }, StdModule.say, { npcHandler = npcHandler, text = "Avriel runs a small shop here in the village. You can buy useful things for your adventures, but also sell things you might not need any longer. You will find his shop in the south of the village." })
keywordHandler:addKeyword({ "gustavo" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, my good friend Gustavo, he's keeping us safe from the north part of this island. It can get pretty dangerous out there." })
keywordHandler:addKeyword({ "viola" }, StdModule.say, { npcHandler = npcHandler, text = "She's a well-read woman who knows a thing or two about magic. Maybe she can teach you a few spells. She might also have a small task for you. I've heard she's missing one of her books." })
keywordHandler:addKeyword({ "tim" }, StdModule.say, { npcHandler = npcHandler, text = "Isn't that the guard from Thais? I heard Gustavo talking about their ongoing friendship despite being apart." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is our beautiful capital, ruled by our beloved king Tibianus III." })
keywordHandler:addKeyword({ "newhaven" }, StdModule.say, { npcHandler = npcHandler, text = "I heard the name refers to older times, where the economy was thriving much more than it does today." })
keywordHandler:addKeyword({ "island" }, StdModule.say, { npcHandler = npcHandler, text = "If you enjoy the life outside of busy cities, you've come to the right place." })
keywordHandler:addKeyword({ "king", "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Our dearest King Tibianus, maybe someday I will be able to meet his highness. He resides at his castle in Thais." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "Ever since the mining industry left our beautiful village, the mines have been haunted. I'd rather stay away from any kind of danger. But I heard Viola could need your help, adventurer." })
keywordHandler:addKeyword({ "bank" }, StdModule.say, { npcHandler = npcHandler, text = "You can deposit and withdraw money from your bank account here. I can also change money for you." })
keywordHandler:addKeyword({ "functions" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Every Tibian has a global bank account. This means you can deposit your gold in one bank, and withdraw it from the same or any other Tibian bank in any city. ... Here on Newhaven, I run the bank. I keep any gold you deposit safe, so you can't lose it when you're out fighting or dying, heh. Ask me for your {balance} to learn how much money you've already saved. ... There are also {advanced} functions, but those are only available to you once you have reached the Tibian mainland.",
})
keywordHandler:addKeyword({ "advanced" }, StdModule.say, { npcHandler = npcHandler, text = "Your bank account will be used automatically when you want to rent a house or place an offer on an item on the market. Let me know if you want to know about how either one works." })
keywordHandler:addKeyword({ "rent" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Renting a house has never been this easy. Simply make a bid for an auction on the house section of the official Tibia website. We will check immediately if you have enough money ... Please keep in mind that the sum you have used to bid will be unavailable unless somebody places a higher bid. Once you have acquired a house the rent will be charged automatically from your bank account every month.",
})
keywordHandler:addKeyword({ "market" }, StdModule.say, { npcHandler = npcHandler, text = "If you buy an item from the market, the required gold will be deducted from your bank account automatically. On the other hand, money you earn for selling items via the market will be added to your account. It's easy!" })

npcHandler:setMessage(MESSAGE_GREET, "Welcome to the Tibian bank, young adventurer! Deposit your gold or withdraw your money from your bank account. Remember to deposit all of your gold before you leave here. I can also explain the {functions} of your bank account to you.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye.")
npcHandler:setCallback(CALLBACK_GREET, NpcBankGreetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
