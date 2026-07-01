local internalNpcName = "Adrian"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Adrian: outfit 931 (banker).
npcConfig.outfit = {
	lookType = 931,
	lookHead = 76,
	lookBody = 70,
	lookLegs = 89,
	lookFeet = 41,
	lookAddons = 0,
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

npcType:addDialogOptions("withdraw", "deposit all", "balance")
npcType:speechBubble(SPEECHBUBBLE_TRADE)

-- Targuna secondary tasks: Deposit/Withdraw gold are completed here by comparing
-- the bank balance before and after parseBank runs (no dedicated engine event exists for them).
local DEPOSIT_GOLD_TASK = Storage.Quest.U15_24.Targuna.SecondaryTasks.DepositGold
local WITHDRAW_GOLD_TASK = Storage.Quest.U15_24.Targuna.SecondaryTasks.WithdrawGold

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local balanceBefore = player:getBankBalance()

	npc:parseBank(message, npc, creature, npcHandler)
	npc:parseGuildBank(message, npc, creature, playerId, npcHandler)
	npc:parseBankMessages(message, npc, creature, npcHandler)

	local balanceAfter = player:getBankBalance()
	if balanceAfter > balanceBefore and player:getStorageValue(DEPOSIT_GOLD_TASK) == 1 then
		player:setStorageValue(DEPOSIT_GOLD_TASK, 2)
	elseif balanceAfter < balanceBefore and player:getStorageValue(WITHDRAW_GOLD_TASK) == 1 then
		player:setStorageValue(WITHDRAW_GOLD_TASK, 2)
	end

	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Adrian, how may I assist you today?" })
keywordHandler:addKeyword({ "adrian" }, StdModule.say, { npcHandler = npcHandler, text = "Mhm?" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I`m the banker here in Targuna. It's my job to manage your bank account and change currencies." })
keywordHandler:addKeyword({ "mission", "quest" }, StdModule.say, { npcHandler = npcHandler, text = "I'm just a banker, ask around maybe someone else could need your help." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "This is our little island here. We are just a small community, but we have good trade relations with the Thais." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is our beautiful capital, ruled by our beloved king Tibianus III." })
keywordHandler:addKeyword({ "bank" }, StdModule.say, { npcHandler = npcHandler, text = "You can deposit and withdraw money from your bank account here. I can also change money for you." })
keywordHandler:addKeyword({ "functions" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Every Tibian has a global bank account. This means you can deposit your gold in one bank, and withdraw it from the same or any other Tibian bank in any city. ... Here on Targuna, I run the bank. I keep any gold you deposit safe, so you can't lose it when you're out fighting or dying, heh. Ask me for your {balance} to learn how much money you've already saved.",
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

npcType:register(npcConfig)
