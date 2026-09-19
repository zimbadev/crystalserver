local internalNpcName = "Swashbuckling Lion Archer"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = "a swashbuckling lion archer"

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 3

-- Outfit baseado no lookType do Lion Archer (monster) - cores a confirmar na wiki
npcConfig.outfit = {
	lookType = 1316,
	lookHead = 0,
	lookBody = 78, -- TODO: Confirmar cor
	lookLegs = 57, -- TODO: Confirmar cor
	lookFeet = 57, -- TODO: Confirmar cor
	lookAddons = 2, -- TODO: Confirmar addons
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

-- TODO: Confirmar todos os diálogos/keywords na wiki
npcHandler:setMessage(MESSAGE_GREET, "Ha! Still standing, still fighting. That's what we do, friend!") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "Keep your bow ready!") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "...") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
