local internalNpcName = "Raubritter Honour Guard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- Outfit baseado no lookType do Raubritter Chastener (monster) - cores a confirmar na wiki
npcConfig.outfit = {
	lookType = 1902,
	lookHead = 94,
	lookBody = 19,
	lookLegs = 21, -- TODO: Confirmar cor
	lookFeet = 78, -- TODO: Confirmar cor
	lookAddons = 0, -- TODO: Confirmar addons
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
	local playerId = creature:getId()
	npcHandler:say("I serve the Raubritter with honour. You are not permitted here.", npc, creature) -- TODO: Confirmar diálogo
	npcHandler:removeInteraction(npc, creature)
	npcHandler:resetNpc(creature)
	return false
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
