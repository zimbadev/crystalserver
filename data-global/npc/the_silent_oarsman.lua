local internalNpcName = "The Silent Oarsman"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 18,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

-- Transcription from TibiaWiki - NPC is a skeleton that offers passage for 500 gold
keywordHandler:addKeyword({ "passage" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "<The oarsman's bony fingers tighten on the oar with his other hand outstretched.>",
})

keywordHandler:addKeyword({ "hand" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "<Do you want to pay the oarsman 500 gold for a passage? Yes or no?>",
})

-- TODO: Implementar travel system com pagamento de 500 gold
-- Quando o jogador diz "yes" após "hand", deve cobrar 500 gold e teleportar

npcHandler:setMessage(MESSAGE_GREET, "<he glares at you from empty eye sockets. Yet perhaps he might offer you a passage.>")
npcHandler:setMessage(MESSAGE_FAREWELL, "<The oarsman nods.>")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

npcType:register(npcConfig)
