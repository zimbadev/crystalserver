local internalNpcName = "Ariella"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 155,
	lookHead = 115,
	lookBody = 3,
	lookLegs = 1,
	lookFeet = 76,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Have a drink in Meriana's only tavern!" },
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- what a foolish quest
	if MsgContains(message, "cookie") then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 31 and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Ariella) ~= 1 then
			npcHandler:say("So you brought a cookie to a pirate?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
		if not player:removeItem(130, 1) then
			npcHandler:say("You have no cookie that I'd like.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
		npc:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
		npcHandler:say("How sweet of you ... Uhh ... OH NO ... Bozo did it again. Tell this prankster I'll pay him back.", npc, creature)
		npcHandler:removeInteraction(npc, creature)
		npcHandler:resetNpc(creature)
		player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Ariella, 1)
		if not player:hasAchievement("Allow Cookies?") then
			player:addAchievement("Allow Cookies?")
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("I really wanted a cookie.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	-- addon
	if MsgContains(message, "addon") and player:getStorageValue(Storage.Quest.U7_8.PirateOutfits.PirateBaseOutfit) == 1 and player:getStorageValue(Storage.Quest.U7_8.PirateOutfits.PirateHatAddon) < 1 then
		npcHandler:say("You mean my hat? Well, I might have another one just like that, but I won't simply give it away, even if you earned our trust. You'd have to fulfil a {task} first.", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "task") and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say("Are you up to the task which I'm going to give you and willing to prove you're worthy of wearing such a hat?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say({
			"Alright, listen closely. There are four pirate leaders who have been troubling us for a long time now. ...",
			"They often lead raids on Liberty Bay and wreck havoc in the settlement - and afterwards, the blame is put on us. ...",
			"Their names are 'Lethal Lissy', 'Ron the Ripper', 'Brutus Bloodbeard' and 'Deadeye Devious'. ...",
			"If you can find and kill them all, be sure to retrieve an item from them as proof that you killed them. ...",
			"Bring me the shirt of Lissy, the sabre of Ron, the hat of Brutus and the eye patch of Deadeye and you will be rewarded. ...",
			"Have you understood everything I told you and are willing to handle this task?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 4 then
		npcHandler:say("Good! Come back to me once you have all four items and ask me about that {task}.", npc, creature)
		player:setStorageValue(Storage.Quest.U7_8.PirateOutfits.PirateHatAddon, 1)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") and (npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 3 or npcHandler:getTopic(playerId) == 4) then
		npcHandler:say("Maybe another time.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "task") and player:getStorageValue(Storage.Quest.U7_8.PirateOutfits.PirateHatAddon) == 1 then
		npcHandler:say("Your task is to bring me the shirt of the Lethal Lissy, the sabre of Ron the Ripper, the hat of Brutus Bloodbeard and the eye patch of Deadeye Devious. Did you succeed?", npc, creature)
		npcHandler:setTopic(playerId, 5)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 5 then
		if player:getItemCount(6101) > 0 and player:getItemCount(6102) > 0 and player:getItemCount(6100) > 0 and player:getItemCount(6099) > 0 then
			if player:removeItem(6101, 1) and player:removeItem(6102, 1) and player:removeItem(6100, 1) and player:removeItem(6099, 1) then
				npcHandler:say("INCREDIBLE! You have found all four of them! |PLAYERNAME|, you have my respect. You more than deserve this hat. There you go.", npc, creature)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
				player:addOutfitAddon(155, 2)
				player:addOutfitAddon(151, 2)
				player:setStorageValue(Storage.Quest.U7_8.PirateOutfits.PirateHatAddon, 2)
				npcHandler:setTopic(playerId, 0)
			end
		else
			npcHandler:say("You don't have all four of them yet.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 5 then
		npcHandler:say("Let me know when you succeed on your task.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	-- bread/beer
	if MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 1 then
			npcHandler:say("You know, we have plenty of rum here but we lack some basic food. Especially food that easily becomes mouldy is a problem. Bring me 100 breads and you will help me a lot.", npc, creature)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven, 2)
		elseif player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 2 then
			npcHandler:say("Are you here to bring me the 100 pieces of bread that I requested?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		elseif player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 3 then
			npcHandler:say({
				"The sailors always tell tales about the famous beer of Carlin. You must know, alcohol is forbidden in that city. ...",
				"The beer is served in a secret whisper bar anyway. Bring me a sample of the whisper beer, NOT the usual beer but whisper beer. I hope you are listening.",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven, 4)
		elseif player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 4 then
			npcHandler:say("Did you get a sample of the whisper beer from Carlin?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		end
	elseif MsgContains(message, "yes") then
		if player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 2 and npcHandler:getTopic(playerId) == 6 then
			if player:removeItem(3600, 100) then
				npcHandler:say("What a joy. At least for a few days adequate supply is ensured.", npc, creature)
				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven, 3)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have enough bread.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 4 and npcHandler:getTopic(playerId) == 7 then
			if player:removeItem(6106, 1) then
				npcHandler:say("Thank you very much. I will test this beauty in privacy.", npc, creature)
				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven, 5)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Whatever you got there is not whisper beer.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("Hurry up then! I can't wait to taste it.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hi there.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "banana", clientId = 3587, buy = 5 },
	{ itemName = "blueberry", clientId = 3588, buy = 1 },
	{ itemName = "cheese", clientId = 3607, buy = 6 },
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "juice squeezer", clientId = 5865, buy = 100 },
	{ itemName = "mango", clientId = 5096, buy = 10 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "melon", clientId = 3593, buy = 10 },
	{ itemName = "orange", clientId = 3586, buy = 10 },
	{ itemName = "pear", clientId = 3584, buy = 5 },
	{ itemName = "pumpkin", clientId = 3594, buy = 10 },
	{ itemName = "red apple", clientId = 3585, buy = 5 },
	{ itemName = "strawberry", clientId = 3591, buy = 2 },
	{ itemName = "valentine's cake", clientId = 6392, buy = 100 },
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
