local internalNpcName = "Viola"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 138,
	lookHead = 95,
	lookBody = 109,
	lookLegs = 94,
	lookFeet = 116,
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

-- Quest storage keys
local VIOLA_BOOK_QUEST_START = Storage.Quest.U15_12.newhavenViolaBookQuestStart
local VIOLA_BOOK_QUEST_DONE = Storage.Quest.U15_12.newhavenViolaBookQuestDone

-- Book of Wisdom item ID
local BOOK_OF_WISDOM_ID = 44774

-- Keywords about NPCs and places
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Viola, I am the spelltrainer here in Newhaven. So if you're interested in new spells, let me know." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Due to my knowledge in multiple different fields, I became a trainer for all vocations, teaching them some new spells." })
keywordHandler:addKeyword({ "newhaven", "island" }, StdModule.say, { npcHandler = npcHandler, text = "Our little island once had a strong economy based on the mines. Lots of workers came from overseas to work here. I still remember that beautiful harbour we had here, good old times." })
keywordHandler:addKeyword({ "mainland" }, StdModule.say, { npcHandler = npcHandler, text = "The mainland with its capital Thais." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "A good friend of mine used to live there, such a beautiful city. I always enjoyed my stay at Kingsday tho', can't recommend it enough." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The king's castle is in Thais, make sure to visit it someday." })
keywordHandler:addKeyword({ "avriel" }, StdModule.say, { npcHandler = npcHandler, text = "Avriel takes care of our little shop just west from my house. When you're looking for supplies or want to sell stuff, you should talk to him." })
keywordHandler:addKeyword({ "anna" }, StdModule.say, { npcHandler = npcHandler, text = "Anna always enjoyed the thrill of the open sea. She often supplies Avriels shop with goods for all of us. Then you're ready to leave I suggest talking to her." })
keywordHandler:addKeyword({ "flavius" }, StdModule.say, { npcHandler = npcHandler, text = "Flavius is the banker on our island. When you need any financial advice, you will find him just north of my house." })
keywordHandler:addKeyword({ "gustavo" }, StdModule.say, { npcHandler = npcHandler, text = "Ahh, yes my dearest Gustavo. He's the guard of our little village protecting us from the muglex. If you're interested in helping, you should talk to him." })
keywordHandler:addKeyword({ "tim" }, StdModule.say, { npcHandler = npcHandler, text = "He once visited over from Thais, I heard Gustavo and him are are good friends." })
keywordHandler:addKeyword({ "shop" }, StdModule.say, { npcHandler = npcHandler, text = "You can find the shop just east of here. Avriel will get you going with everything you need." })
keywordHandler:addKeyword({ "bank" }, StdModule.say, { npcHandler = npcHandler, text = "The bank can be found just north of us. Flavius will take care of all your financial needs." })
keywordHandler:addKeyword({ "guard" }, StdModule.say, { npcHandler = npcHandler, text = "Gustavo serves as our guard, keeping us safe from the northern part of the island. It can get pretty dangerous there, take care if you ever find yourself there." })
keywordHandler:addKeyword({ "danger" }, StdModule.say, { npcHandler = npcHandler, text = "Those muglex have been terrorising our little village for a while now, maybe you could talk to Gustavo. I bet he knows more about them." })
keywordHandler:addKeyword({ "muglex" }, StdModule.say, { npcHandler = npcHandler, text = "These little green goblins once arrived with ships, ever since our village has been under constant attack. Fortunately the wooden walls and Gustavo are keeping the danger out." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "These mines were once a thriving force for workers and investors alike, ever since the last ores have been mined, these trenches have been abandoned for good." })
keywordHandler:addKeyword({ "teach" }, StdModule.say, { npcHandler = npcHandler, text = "I see you are eager to learn new spells." })

npcHandler:setMessage(MESSAGE_GREET, "Welcome |PLAYERNAME|! Are you here to {learn} new wisdom or do you have time for a {mission}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye and take care.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye and take care.")

-- Spell teaching setup
npcConfig.spells = {
	-- Healing spells
	{ name = "Wound Cleansing", words = "exura infir ico", price = 0, level = 1, vocation = { "All" } },
	{ name = "Cure Poison", words = "exana pox", price = 150, level = 10, vocation = { "All" } },
	-- Support spells
	{ name = "Magic Rope", words = "exani tera", price = 200, level = 9, vocation = { "All" } },
	{ name = "Light", words = "utevo lux", price = 0, level = 8, vocation = { "All" } },
}

-- Function to give vocation-based reward
local function giveVocationReward(player)
	local vocationId = player:getVocation():getBaseId()
	local rewardItem = nil
	local rewardName = ""

	if vocationId == 1 then -- Sorcerer
		rewardItem = 3074 -- Wand of Vortex
		rewardName = "Wand of Vortex"
	elseif vocationId == 2 then -- Druid
		rewardItem = 3066 -- Snakebite Rod
		rewardName = "Snakebite Rod"
	elseif vocationId == 3 then -- Paladin
		rewardItem = 3350 -- Bow
		rewardName = "Bow"
	elseif vocationId == 4 then -- Knight
		rewardItem = 3264 -- Sword
		rewardName = "Sword"
	elseif vocationId == 11 then -- Monk
		rewardItem = 3290 -- Silver Dagger (fist weapon)
		rewardName = "Silver Dagger"
	else
		rewardItem = 3031 -- Gold coin
		rewardName = "some gold coins"
		player:addItem(3031, 50)
		return rewardName
	end

	player:addItem(rewardItem, 1)
	return rewardName
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- Mission/Quest logic
	if MsgContains(message, "mission") or MsgContains(message, "task") or MsgContains(message, "book") then
		local questStart = player:getStorageValue(VIOLA_BOOK_QUEST_START)
		local questDone = player:getStorageValue(VIOLA_BOOK_QUEST_DONE)

		if questDone == 1 then
			npcHandler:say("You have already helped me recover my book. Thank you again for your kindness!", npc, creature)
			return true
		end

		if questStart ~= 1 then
			npcHandler:say("Oh, I'm so glad you asked! A ghost took my precious Book of Wisdom into the {mines} to the northeast of the island. Would you be so kind as to retrieve it for me?", npc, creature)
			npcHandler:setTopic(playerId, 50)
			return true
		else
			-- Quest in progress, check if player has the book
			if player:getItemCount(BOOK_OF_WISDOM_ID) > 0 then
				npcHandler:say("You found my Book of Wisdom! Oh, thank you so much! Please, take this as a token of my gratitude.", npc, creature)
				player:removeItem(BOOK_OF_WISDOM_ID, 1)
				player:setStorageValue(VIOLA_BOOK_QUEST_DONE, 1)
				local rewardName = giveVocationReward(player)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Viola gave you a " .. rewardName .. " as a reward!")
				return true
			else
				npcHandler:say("Have you found my Book of Wisdom yet? It should be somewhere in the mines to the northeast. Be careful of the corrupted creatures down there!", npc, creature)
				return true
			end
		end
	end

	-- Handle yes response for quest start
	if MsgContains(message, "yes") then
		local topic = npcHandler:getTopic(playerId)

		if topic == 50 then
			npcHandler:say("Thank you so much! The ghost took my book into the corrupted mines to the northeast. Please be careful, there are dangerous creatures down there. The book should be in a chest somewhere inside.", npc, creature)
			player:setStorageValue(VIOLA_BOOK_QUEST_START, 1)
			npcHandler:setTopic(playerId, 0)
			return true
		end

		-- Spell learning yes responses
		if topic == 10 then -- Wound Cleansing (free)
			player:learnSpell("exura infir ico")
			npcHandler:say("Here you are. Look in your spellbook for the pronunciation of this spell.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		elseif topic == 11 then -- Cure Poison (150 gold)
			if player:removeMoney(150) then
				player:learnSpell("exana pox")
				npcHandler:say("Here you are. Look in your spellbook for the pronunciation of this spell.", npc, creature)
			else
				npcHandler:say("You don't have enough gold.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
			return true
		elseif topic == 12 then -- Magic Rope (200 gold)
			if player:removeMoney(200) then
				player:learnSpell("exani tera")
				npcHandler:say("Here you are. Look in your spellbook for the pronunciation of this spell.", npc, creature)
			else
				npcHandler:say("You don't have enough gold.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
			return true
		elseif topic == 13 then -- Light (free)
			player:learnSpell("utevo lux")
			npcHandler:say("Here you are. Look in your spellbook for the pronunciation of this spell.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	if MsgContains(message, "no") then
		local topic = npcHandler:getTopic(playerId)
		if topic == 50 then
			npcHandler:say("Oh, that's a shame. Please come back if you change your mind. That book is very important to me.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
		npcHandler:say("Maybe another time then.", npc, creature)
		npcHandler:setTopic(playerId, 0)
		return true
	end

	-- Spell learning logic
	if MsgContains(message, "learn") or MsgContains(message, "spells") then
		npcHandler:say("I see you are eager to learn new spells. I can teach you {instant spells}. What kind of spell do you wish to learn? You can also tell me for which level you would like to learn a spell, if you prefer that.", npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if npcHandler:getTopic(playerId) == 1 or MsgContains(message, "instant spells") then
		npcHandler:say("I sell {healing spells} and {support spells}. Which of these interests you most?", npc, creature)
		npcHandler:setTopic(playerId, 2)
		return true
	end

	if npcHandler:getTopic(playerId) == 2 then
		if MsgContains(message, "healing spells") or MsgContains(message, "healing") then
			npcHandler:say("In this category I have 'Wound Cleansing' and 'Cure Poison'.", npc, creature)
			npcHandler:setTopic(playerId, 3)
			return true
		elseif MsgContains(message, "support spells") or MsgContains(message, "support") then
			npcHandler:say("In this category I have 'Magic Rope' and 'Light'.", npc, creature)
			npcHandler:setTopic(playerId, 4)
			return true
		end
	end

	-- Teaching specific spells
	if MsgContains(message, "wound cleansing") then
		if player:hasLearnedSpell("exura infir ico") then
			npcHandler:say("You already know how to cast this spell.", npc, creature)
		else
			npcHandler:say("Do you want to have the spell 'Wound Cleansing' for free?", npc, creature)
			npcHandler:setTopic(playerId, 10)
		end
		return true
	end

	if MsgContains(message, "cure poison") then
		if player:hasLearnedSpell("exana pox") then
			npcHandler:say("You already know how to cast this spell.", npc, creature)
		else
			npcHandler:say("Do you want to buy the spell 'Cure Poison' for 150 gold?", npc, creature)
			npcHandler:setTopic(playerId, 11)
		end
		return true
	end

	if MsgContains(message, "magic rope") then
		if player:hasLearnedSpell("exani tera") then
			npcHandler:say("You already know how to cast this spell.", npc, creature)
		else
			npcHandler:say("Do you want to learn the spell 'Magic Rope' for 200 gold?", npc, creature)
			npcHandler:setTopic(playerId, 12)
		end
		return true
	end

	if MsgContains(message, "light") then
		if player:hasLearnedSpell("utevo lux") then
			npcHandler:say("You already know how to cast this spell.", npc, creature)
		else
			npcHandler:say("Do you want to have the spell 'Light' for free?", npc, creature)
			npcHandler:setTopic(playerId, 13)
		end
		return true
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
