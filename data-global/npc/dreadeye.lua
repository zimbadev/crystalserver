local internalNpcName = "Dreadeye"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 256,
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
		if kv:get("research-dreadeye") then
			npcHandler:say("We've already talked about this.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say({
				"Of course! He will receive the knowledge that I choose to share with him - although with his limited intelligence I doubt he will grasp the concepts I send him. ...",
				"Warn him that the consequences, for you both, will be dire if you fail to succeed in your undertaking. Your limited intellect cannot comprehend the importance of this. ...",
				"Even I do not know what this portends. But.. yet .. sometimes .. there is a glimpse. An insight that unsettles me. An emotion long forgotten.",
			}, npc, creature)
			kv:set("research-dreadeye", 1)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Ah, a visitor to intimidate. Splendid!")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
