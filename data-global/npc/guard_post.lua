local internalNpcName = "Guard Post"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = "a guard post"

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- TODO: Confirmar outfit na wiki (lookType, cores, addons)
npcConfig.outfit = {
	lookType = 131, -- TODO: Confirmar lookType
	lookHead = 78, -- TODO: Confirmar cor
	lookBody = 52, -- TODO: Confirmar cor
	lookLegs = 94, -- TODO: Confirmar cor
	lookFeet = 116, -- TODO: Confirmar cor
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

-- TODO: Confirmar todos os diálogos na wiki
npcHandler:setMessage(MESSAGE_GREET, "Halt! This area is under watch. Move along, citizen.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "Stay safe out there.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "...") -- TODO: Confirmar

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a guard on post. That's all you need to know." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I watch this area for any suspicious activity." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "raubritter" }, StdModule.say, { npcHandler = npcHandler, text = "If you see any Raubritter, report them to Guard Captain Hartford immediately." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "Speak with our officers if you want to help. I just keep watch." }) -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
