local internalNpcName = "Scutty"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 76,
	lookBody = 0,
	lookLegs = 19,
	lookFeet = 114,
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

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local kv = player:kv():scoped("shadows-of-yalahar")
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "research notes") and player:getStorageValue(ShadowsOfYalahar.Mission01) == 1 then
		if kv:get("research-scutty") then
			npcHandler:say("We've already talked about this.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say({
				"Ok, ok. Considering how much knowledge Telas was willing to share and keeping in mind that he promised to send me the results of his research I'll make an exception. I will send him the information he wants .. even a bit more. ...",
				"He'd better live up to his promises, a dwarf does not forget or forgive easily.",
			}, npc, creature)
			kv:set("research-scutty", 1)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello there.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
