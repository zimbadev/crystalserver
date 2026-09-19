local internalNpcName = "Raubritter Patrol"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 4

-- Outfit baseado no lookType do Raubritter Skirmisher (monster) - cores a confirmar na wiki
npcConfig.outfit = {
	lookType = 1900,
	lookHead = 94,
	lookBody = 19,
	lookLegs = 3, -- TODO: Confirmar cor
	lookFeet = 19, -- TODO: Confirmar cor
	lookAddons = 0, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "All clear." }, -- TODO: Confirmar texto
	{ text = "Patrolling the area." }, -- TODO: Confirmar texto
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
	npcHandler:say("Keep walking. This area is under Raubritter control.", npc, creature) -- TODO: Confirmar diálogo
	npcHandler:removeInteraction(npc, creature)
	npcHandler:resetNpc(creature)
	return false
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
