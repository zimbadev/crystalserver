local internalNpcName = "Quill"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1848,
	lookHead = 78,
	lookBody = 108,
	lookLegs = 39,
	lookFeet = 114,
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	if not player then
		return false
	end

	local playerId = creature:getId()

	npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! How can I help you today?")
	npcHandler:setTopic(playerId, 0)

	return true
end

local function farewellCallback(npc, creature)
	npcHandler:say("Goodbye, take care!", npc, creature)
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local player = Player(creature)
	if not player then
		return false
	end

	local playerId = creature:getId()

	if MsgContains(message, "help") then
		npcHandler:say("I'm here to help! What do you need?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "job") or MsgContains(message, "work") then
		npcHandler:say("I have various tasks that need to be done. Are you interested?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "name") then
		npcHandler:say("I am Anaztassja Moroia.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Set standard farewell messages
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back anytime!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye, |PLAYERNAME|! Safe travels!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
