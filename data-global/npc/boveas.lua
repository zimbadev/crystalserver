local internalNpcName = "Boveas"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 25,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
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
		if kv:get("research-boveas") then
			npcHandler:say("We've already talked about this.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say("Oh, of course I can send him my research notes. I'll drop them into the next mailbox as soon as possible. May the Gods bless the royal Tibian mail system and its fearless and sometimes maimed postmen.", npc, creature)
			kv:set("research-boveas", 1)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end
	return false
end

npcHandler:setMessage(MESSAGE_GREET, "Hi! I hope you're not going to kill me!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
