local internalNpcName = "Gunther"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 39,
	lookBody = 98,
	lookLegs = 123,
	lookFeet = 68,
	lookAddons = 0,
	lookMount = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "They have to believe me!" },
	{ text = "What a mess." },
	{ text = "Oh my!" },
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

local LINES = {
	adventurer = "I hoped to meet an adventurer such as you! No one is listening to me, they claim I am {mad}, but I am not!",
	mad = "Yes, YES! I've {seen} IT!",
	seen = "It was a plant! On open seas!!! I swear! And it was {humongous}!",
	humongous = "It was as big as a castle! And that was only the part I could see over water! And it {moved}!!!",
	moved = "Yes it was slowly but steadily heading straight for the {mainland}.",
	mainland = "I can't tell where or when it arrives at the shores. But somewhere at some point it will! And it will be a {disaster}!",
	disaster = "Can you imagine the damage a gigantic walking plant will cause? It will raze cities, stomp out armies! It has to be {stopped}!",
	stopped = "I called in a few favours from the adventurer's guild and the explorer society to fund an expedition to seek out that monster.",
}

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	for keyword, line in pairs(LINES) do
		if MsgContains(message, keyword) then
			npcHandler:say(line, npc, creature)
			return true
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Greetings {adventurer}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
