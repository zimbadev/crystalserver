local internalNpcName = "Dhira"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- TODO(outfit): placeholder until the official appearance is read from the client staticdata.
npcConfig.outfit = {
	lookType = 1539,
	lookHead = 114,
	lookBody = 96,
	lookLegs = 21,
	lookFeet = 115,
	lookAddons = 0,
	lookMount = 0,
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

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "moon") then
		npcHandler:say("Even the beavers feel it. They grow restless when the moon rises.", npc, creature)
		return true
	end

	if not MsgContains(message, "plant") then
		return true
	end

	npcHandler:say({
		"Strange things about plants? Hmm, perhaps. I spend a lot of time out here with the beavers.",
		"Sometimes, despite the dangers posed by parders and jungle moas, I venture into the Sparkling Lagoon to gather special food plants for my wards.",
		"And on my last visit there, just recently, I saw that some of the plants had changed. Their leaves have a strange, almost silvery sheen.",
		"I'm no scholar, but I can see when something's wrong with the plants. Take a look for yourself, maybe you'll notice more than I did.",
		"The affected plants I've discovered are tide veil and whisper reed. You should take a sample of each and examine them at the laboratory here in Silvertides.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Dhira. The beavers call me something else, but you could not pronounce it." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I look after the beavers of Silvertides." })
keywordHandler:addKeyword({ "beaver", "beavers" }, StdModule.say, { npcHandler = npcHandler, text = "They are cleverer than most two-legs and they complain less." })
keywordHandler:addKeyword({ "lagoon", "sparkling lagoon" }, StdModule.say, { npcHandler = npcHandler, text = "Beautiful place, if you keep an eye out for parders and jungle moas." })
keywordHandler:addKeyword({ "tide veil", "whisper reed" }, StdModule.say, { npcHandler = npcHandler, text = "Both grow out in the lagoon, and both have that silvery sheen now. Cut a sample with a knife and take it to the laboratory." })
keywordHandler:addKeyword({ "laboratory" }, StdModule.say, { npcHandler = npcHandler, text = "The refiner of magic in the laboratory here in Silvertides will tell you what is in those leaves." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, two-leg.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Mind the beavers on your way out.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Mind the beavers on your way out.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
