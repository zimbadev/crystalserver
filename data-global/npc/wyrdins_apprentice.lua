local internalNpcName = "Wyrdin's Apprentice"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 2,
	lookBody = 20,
	lookLegs = 37,
	lookFeet = 57,
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

	if MsgContains(message, "yalahar") then
		npcHandler:say({
			"They discovered a new city to the far north. I've been there, it's huge and bustling, filled to the brim with exotic wares, magic and adventure. ...",
			"I was an apprentice to the researcher {Wyrdin} in Edron, he sent me there. He wanted to retrieve some research from the explorer society's representative Timothy, who is stationed there. ...",
			"However, after seeing what the city had to offer, I took matters in my own hands and started my own venture. Independence and stuff. ...",
			"I am now translating scientific books from all kinds of sources in Yalahar and beyond. Once I have completed enough tracts, reports and encyclopedias, I will open a store.",
		}, npc, creature)
	elseif MsgContains(message, "wyrdin") then
		npcHandler:say({
			"Pah, Wyrdin. With a mentor like that, you'll get absolutely nowhere, let me tell you. This guy is completely stuck in his research - because he never gets out. ...",
			"Seeing Yalahar for the first time was a revelation. The knowledge, the mystery, the adventure - pure excitement compared to dusty tomes in mouldy rooms up in the academy.",
		}, npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hm? Who's disturbing my perusal! I've just returned from {Yalahar} and have a lot of reading to do - make it short.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
