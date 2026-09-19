local internalNpcName = "Milos"
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
	lookHead = 19,
	lookBody = 3,
	lookLegs = 3,
	lookFeet = 2,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "What a fascinating idea!" },
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
		if kv:get("research-milos") then
			npcHandler:say("We've already talked about this.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say("Oh, of course I'll send him my notes immediately. Perhaps he'll come back and visit us here sometime. Do pass on my regards to him, won't you?", npc, creature)
			kv:set("research-milos", 1)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Oh hello. I hardly noticed you. I'm afraid I am a bit distracted at the moment.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
