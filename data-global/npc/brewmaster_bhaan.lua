local internalNpcName = "Brewmaster Bhaan"
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
	lookType = 132, -- TODO: Confirmar lookType
	lookHead = 57, -- TODO: Confirmar cor
	lookBody = 113, -- TODO: Confirmar cor
	lookLegs = 95, -- TODO: Confirmar cor
	lookFeet = 115, -- TODO: Confirmar cor
	lookAddons = 0, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Fresh brews available!" }, -- TODO: Confirmar texto
	{ text = "The finest ales in all the land!" }, -- TODO: Confirmar texto
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Brewmaster Bhaan, master of the brewing arts." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I {brew} the finest ales and spirits you'll find anywhere. Care to sample my {wares}?" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "brew" }, StdModule.say, { npcHandler = npcHandler, text = "Brewing is both an art and a science. The perfect balance of ingredients, temperature, and time." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "wares" }, StdModule.say, { npcHandler = npcHandler, text = "I have various drinks for sale. Just ask about my {trade}." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "ale" }, StdModule.say, { npcHandler = npcHandler, text = "My ales are brewed with the finest hops and barley. Perfect for any occasion." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "spirits" }, StdModule.say, { npcHandler = npcHandler, text = "Strong drinks for those who can handle them. Not for the faint of heart!" }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "Welcome, welcome! Come, try my latest {brew}!") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "May your tankard never run dry!") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back when you're thirsty!") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
