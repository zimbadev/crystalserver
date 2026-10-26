local internalNpcName = "Fernlor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 1642,
	lookHead = 57,
	lookBody = 132,
	lookLegs = 98,
	lookFeet = 124,
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

	if MsgContains(message, "help") then
		npcHandler:say("I am the High Scryer of the Arcane Academy. With my mystical tools, I constantly {monitor} the magical aether for any trace of {anomalies}.", npc, creature)
	elseif MsgContains(message, "monitor") then
		npcHandler:say({
			"I constantly scan the magical aether for any trace of anomalies. ...",
			"Usually, my findings are just of academic importance, but recently I stumbled over spikes far beyond the normal and usual scale.",
		}, npc, creature)
	elseif MsgContains(message, "anomal") then
		npcHandler:say({
			"I found a recent disturbance at some remote, uncharted isle far away in the east. This disturbance has to be investigated! ...",
			"Uhm, yet I am no way an adventurer and hold my prestigious position in the academy not for taking risky chances.",
		}, npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "I am the High Scryer of the Arcane Academy. I monitor the magical aether for any {anomaly} that I discover.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
