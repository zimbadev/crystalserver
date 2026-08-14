local internalNpcName = "Wyrdin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 76,
	lookBody = 77,
	lookLegs = 79,
	lookFeet = 115,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{
		text = "<mumbles> So where was I again?",
	},
	{
		text = "<mumbles> Typical - you can never find a hero when you need one!",
	},
	{
		text = "<mumbles> Could the bonelord language be the invention of some madman?",
	},
	{
		text = "<mumbles> The curse algorithm of triplex shadowing has to be two times higher than an overcharged nanoquorx on the peripheral...",
	},
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

	-- The New Frontier
	local persuasionReplies = {
		flatter = "Hm, you are right, we are at the forefront of knowledge and innovation. Our dwarven friends could learn much from one of our representatives.",
		threaten = "I still don't think that any success or failure of this project will have an impact on the academy, but your persistence does you credit. Very well, we'll send a representative.",
		bluff = "What do you mean the druids of Carlin could provide the service as well? They are incompetent imposters! I will not allow them to ruin our reputation! I'll send some trader with supplies right away!",
		impress = "Well, the efforts of the dwarfs are indeed impressive. Perhaps a representative from the academy would not be out of place there after all.",
		reason = "Well, it can't be wrong to be there when new discoveries are made. Also, all those soldiers of fortune that might travel there could turn out to be a good source of income for a magic shop. I think we'll send a representative.",
		plea = "<sighs> Okay, sending some trader there won't hurt. I hope it will be worth the effort, though.",
	}
	local persuasionKeywords = { "flatter", "threaten", "bluff", "impress", "reason", "plea" }

	if MsgContains(message, "farmine") and player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin) < 3 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 then
			if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin) == 1 then
				npcHandler:say("I've heard some odd rumours about this new dwarven outpost. But tell me, what has the Edron academy to do with Farmine?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("I'm not sure if I'm in the mood to talk about that matter again. Or do you have anything that might change my mind?", npc, creature)
				npcHandler:setTopic(playerId, 4)
			end
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 4 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 and player:removeItem(10025, 1) then
			npcHandler:say({
				"By Uman! That's one of the rare almanacs of Origus! I had no idea that you are a scholar yourself! And a generous one on top of it! ...",
				"This book must be worth some thousand crystal coins on the free market. Look at the signature here, it's Origus' very own! ...",
				"Of course we should talk again about your request. What do you say makes Farmine important?",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin, 1)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin, 2)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flatter") or MsgContains(message, "threaten") or MsgContains(message, "bluff") or MsgContains(message, "impress") or MsgContains(message, "reason") or MsgContains(message, "plea") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:removeItem(10025, 1) then
				for _, keyword in ipairs(persuasionKeywords) do
					if MsgContains(message, keyword) then
						npcHandler:say(persuasionReplies[keyword], npc, creature)
						break
					end
				end
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin, 3)
			else
				npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin, 2)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			for _, keyword in ipairs(persuasionKeywords) do
				if MsgContains(message, keyword) then
					npcHandler:say(persuasionReplies[keyword], npc, creature)
					break
				end
			end
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin, 3)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") and (npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 4) then
		npcHandler:say("Come back when you find any information.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TheWayToYalahar) < 1 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine) >= 5 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.JoiningTheExplorers) >= 5 then
			npcHandler:say({
				"There is indeed something that needs our attention. In the far north, a new city named Yalahar was discovered. It seems to be incredibly huge. ...",
				"According to travelers, it's a city of glory and wonders. We need to learn as much as we can about this city and its inhabitants. ...",
				"Gladly the explorer's society already sent a representative there. Still, we need someone to bring us the information he was able to gather until now. ...",
				"Please look for the explorer's society's captain Maximilian in Liberty Bay. Ask him for a passage to Yalahar. There visit Timothy of the explorer's society and get his research notes. ...",
				"It might be a good idea to explore the city a bit on your own before you deliver the notes here, but please make sure you don't lose them.",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TheWayToYalahar, 1)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "research") or MsgContains(message, "notes") then
		if player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TheWayToYalahar) == 2 then
			npcHandler:say("Do you have the papers I asked you for with you?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
		if player:removeItem(9171, 1) then
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TheWayToYalahar, 3)
			npcHandler:say("Oh marvellous, please excuse me. I need to read this text immediately. Here, take this small reward of 500 gold pieces for your efforts.", npc, creature)
			player:addMoney(500)
			npcHandler:setTopic(playerId, 0)
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello, what brings you here?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good luck for your travels, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
