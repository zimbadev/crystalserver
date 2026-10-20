local internalNpcName = "Udu"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- TODO(outfit): placeholder until the official appearance is read from the client staticdata.
npcConfig.outfit = {
	lookType = 1538,
	lookHead = 114,
	lookBody = 95,
	lookLegs = 0,
	lookFeet = 76,
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

	if not MsgContains(message, "moon") then
		return true
	end

	npcHandler:say({
		"The light? Ha! I was wondering when someone would finally ask about it. Most nagas just observe the water.",
		"But when something happens in the sky, they only notice it once the world below has already been thrown off balance. A few nights ago, I was watching the eastern sky.",
		"Everything was calm ... until suddenly a glistening streak split the darkness. Not like a shooting star. No, much brighter. But also much slower.",
		"It seemed to be breaking away from the moon herself. A glowing fragment trailing a long silver tail behind it, like liquid moonlight. It fell into the sea east of Marapur, at the Emerald Gardens.",
		"I even saw the moment of impact: a brief flash, then nothing but mist over the water.",
		"So if you're looking for a source of your strange tides, altered plants and nervous yukti, that's exactly where I would start. Something from the sky now lies off our coast.",
		"And if my instincts are correct, this fragment carries within it a part of the moon's power.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Udu. Astronomer, insomniac, and the only one here who looks up." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I watch the sky above Marapur every night and write down what it does." })
keywordHandler:addKeyword({ "sky", "stars" }, StdModule.say, { npcHandler = npcHandler, text = "The stars are reliable. It is everything else that keeps surprising me." })
keywordHandler:addKeyword({ "emerald gardens" }, StdModule.say, { npcHandler = npcHandler, text = "East of Marapur, out where the water goes green. That is where it came down." })
keywordHandler:addKeyword({ "amati" }, StdModule.say, { npcHandler = npcHandler, text = "Whatever the priests say, something tore loose from her that night." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, two-leg.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Mind the sky once in a while.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Mind the sky once in a while.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
