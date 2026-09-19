local internalNpcName = "Fitzduncan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- TODO: Confirmar outfit na wiki (lookType, cores, addons)
npcConfig.outfit = {
	lookType = 132, -- TODO: Confirmar lookType (Nobleman Male?)
	lookHead = 78, -- TODO: Confirmar cor
	lookBody = 97, -- TODO: Confirmar cor
	lookLegs = 116, -- TODO: Confirmar cor
	lookFeet = 115, -- TODO: Confirmar cor
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

-- TODO: Confirmar todos os diálogos/keywords na wiki
-- Basic keywords
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Fitzduncan, at your service." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I serve as an advisor and informant. Information is my trade." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "information" }, StdModule.say, { npcHandler = npcHandler, text = "I know many things about many people. The right information at the right time can be invaluable." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "raubritter" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, the Raubritter... I may know something about their operations. For a price, of course." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "price" }, StdModule.say, { npcHandler = npcHandler, text = "Everything has a price. Sometimes gold, sometimes favors. It depends on what you need." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "rumors" }, StdModule.say, { npcHandler = npcHandler, text = "Rumors are often more valuable than facts. They reveal what people believe, and belief shapes action." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "I can help you, if you're willing to help me in return. A fair exchange." }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "Ah, a new face. Looking for {information}, perhaps?") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "Remember, discretion is a virtue.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "Another time, then.") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
