local internalNpcName = "Gustavo, The Guard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 134,
	lookHead = 95,
	lookBody = 0,
	lookLegs = 96,
	lookFeet = 116,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Bloody goblins!" },
	{ text = "Long live the king!" },
	{ text = "Hey there, young adventurer! Need a hint?" },
}

-- Quest storage keys
local NEWHAVEN_GOBLIN_QUEST_START = Storage.Quest.U15_12.newhavenGoblinQuestStart
local NEWHAVEN_GOBLIN_QUEST_DONE = Storage.Quest.U15_12.newhavenGoblinQuestDone
local MUGLEX_KILL_COUNT = Storage.Quest.U15_12.newhavenMuglexKillCount

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

	if MsgContains(message, "goblins") or MsgContains(message, "goblin") or MsgContains(message, "muglex") or MsgContains(message, "quest") or MsgContains(message, "mission") then
		local questStart = player:getStorageValue(NEWHAVEN_GOBLIN_QUEST_START)
		local questDone = player:getStorageValue(NEWHAVEN_GOBLIN_QUEST_DONE)

		if questDone == 1 then
			npcHandler:say("You rendered a great favour to this village. Thank you!", npc, creature)
			return true
		end

		if questStart ~= 1 then
			-- Start the quest
			npcHandler:say("They call themselves the Muglex Clan. They may be small, but don't be fooled, they can be quite dangerous. You seem capable enough, though. ... Please take down twenty of these Muglex goblins. That should make life in the village safer again.", npc, creature)
			player:setStorageValue(NEWHAVEN_GOBLIN_QUEST_START, 1)
			player:setStorageValue(MUGLEX_KILL_COUNT, 0)
		else
			-- Check kill count
			local kills = player:getStorageValue(MUGLEX_KILL_COUNT)
			if kills >= 20 then
				npcHandler:say("You rendered a great favour to this village. Thank you! Now take this ring as a form of my gratitude, I'm sure it will aid you in combat. Oh, and if you did not talk to Viola yet, you should visit her. ... She might also have a small task for you. I've heard she's missing one of her books.", npc, creature)
				player:setStorageValue(NEWHAVEN_GOBLIN_QUEST_DONE, 1)
				player:addItem(3052, 1) -- Ring of Healing or appropriate reward
			else
				npcHandler:say("You still need to kill " .. (20 - kills) .. " more Muglex goblins. Keep hunting!", npc, creature)
			end
		end
		return true
	end

	return true
end

-- Keywords about NPCs and topics
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Gustavo." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I used to serve in Thais, but I volunteered to protect this village. I wonder how Tim is doing in the capital." })
keywordHandler:addKeyword({ "newhaven" }, StdModule.say, { npcHandler = npcHandler, text = "Though it might not seem like it, our island once had a promising future ahead of it. Many workers came from abroad, looking for jobs in the mines and as helpers around the village. ... Anyway..." })
keywordHandler:addKeyword({ "island" }, StdModule.say, { npcHandler = npcHandler, text = "Being the only trained guard here on Newhaven makes things difficult sometimes. Fortunately for us, many young adventurers come to help with the ever growing danger from the goblins and the mines." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is our beautiful capital, ruled by our benevolent king Tibianus III." })
keywordHandler:addKeyword({ "king", "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Tibianus III is our beloved king! He resides in the castle in the city of Thais." })
keywordHandler:addKeyword({ "avriel" }, StdModule.say, { npcHandler = npcHandler, text = "Avriel runs a small shop here in the village. You can buy useful things there, but you can also sell things you no longer need. You will find his shop in the south of the village." })
keywordHandler:addKeyword({ "anna" }, StdModule.say, { npcHandler = npcHandler, text = "She offers a passage to the Mainland. You can find her at the ferry house." })
keywordHandler:addKeyword({ "viola" }, StdModule.say, { npcHandler = npcHandler, text = "She's a well-read woman who knows a thing or two about magic. Maybe she can teach you a few spells. She might also have a small task for you. I've heard she's missing one of her books." })
keywordHandler:addKeyword({ "flavius" }, StdModule.say, { npcHandler = npcHandler, text = "Flavius runs the small bank in this village. You can find him over there in his the house." })
keywordHandler:addKeyword({ "tim" }, StdModule.say, { npcHandler = npcHandler, text = "Tim is a good friend of mine. He works as a guard in the city of Thais." })
keywordHandler:addKeyword({ "ben" }, StdModule.say, { npcHandler = npcHandler, text = "You're talking about the bear, aren't you? Yes, it's a long story. And one that I don't necessarily want to share with everyone. It's personal, you could say." })
keywordHandler:addKeyword({ "banor" }, StdModule.say, { npcHandler = npcHandler, text = "Praise Banor! May the great warrior be with us!" })
keywordHandler:addKeyword(
	{ "crunor" },
	StdModule.say,
	{ npcHandler = npcHandler, text = "Crunor is the god of nature, trees, plants and fertility. He created all plants of Tibia after his own image. He is also called the Lord of The Trees and the Great Tree. ... Crunor also created the wolves in order to protect his forests against the orcs. There is a small shrine in his honour in the woods south of the village." }
)
keywordHandler:addKeyword({ "spells" }, StdModule.say, { npcHandler = npcHandler, text = "If you want to learn some spells, talk to Viola. She lives in the house south of the bank." })
keywordHandler:addKeyword({ "bank" }, StdModule.say, { npcHandler = npcHandler, text = "You can find the bank right over there." })
keywordHandler:addKeyword({ "shop" }, StdModule.say, { npcHandler = npcHandler, text = "Visit Avriel's shop to buy or sell wares. You can find him south of here." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Tibia is the world we live in, my friend." })
keywordHandler:addKeyword({ "hint" }, StdModule.say, { npcHandler = npcHandler, text = "If you're looking for adventure, ask me about the {goblins} that have been terrorising us!" })

npcHandler:setMessage(MESSAGE_GREET, "Those bloody goblins are too close to the village for my liking.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Take care!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Take care!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
