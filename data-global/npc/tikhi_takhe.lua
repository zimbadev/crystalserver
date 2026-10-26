local internalNpcName = "Tik'hi Tak'he"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1378,
	lookHead = 0,
	lookBody = 131,
	lookLegs = 97,
	lookFeet = 117,
	lookAddons = 3,
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

	if MsgContains(message, "name") then
		npcHandler:say("I am Tik'hi Tak'he, speaker of the Rascoohan people.", npc, creature)
	elseif MsgContains(message, "pirat") or MsgContains(message, "corym") then
		npcHandler:say({
			"The pirats were coryms once, and we lived in peace with them. ...",
			"Then they found a book of pirate teachings and took it for a way of life. Now they raid our island and the coasts of your world alike.",
		}, npc, creature)
	elseif MsgContains(message, "task") then
		npcHandler:say("Look all over Rascacoon and the isle to find opportunities to help us out. Even back in the Corym caves you might find something useful to do.", npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hail, visitor! Welcome!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell!")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
