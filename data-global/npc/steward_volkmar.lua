local internalNpcName = "Steward Volkmar"
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
	lookHead = 78, -- TODO: Confirmar cor
	lookBody = 118, -- TODO: Confirmar cor
	lookLegs = 97, -- TODO: Confirmar cor
	lookFeet = 115, -- TODO: Confirmar cor
	lookAddons = 1, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "The estate must be maintained properly." }, -- TODO: Confirmar texto
	{ text = "Order brings efficiency." }, -- TODO: Confirmar texto
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Steward Volkmar, administrator of this estate." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I manage the {household} and ensure all {affairs} run smoothly." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "household" }, StdModule.say, { npcHandler = npcHandler, text = "A well-run household is the foundation of any noble house. Every detail must be attended to." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "affairs" }, StdModule.say, { npcHandler = npcHandler, text = "Financial matters, staff management, correspondence - all fall under my purview." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "steward" }, StdModule.say, { npcHandler = npcHandler, text = "A steward must be trustworthy above all else. I have served faithfully for many years." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "estate" }, StdModule.say, { npcHandler = npcHandler, text = "The estate has seen better days, but we maintain what we can." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "raubritter" }, StdModule.say, { npcHandler = npcHandler, text = "Those brigands have disrupted trade terribly. It's affecting the entire region's economy." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "If you're looking for work, I may have some tasks that need attending to." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "tasks" }, StdModule.say, { npcHandler = npcHandler, text = "There are always errands to be run and matters to be resolved." }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "Welcome. How may I assist you today?") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "Good day. Please close the door on your way out.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "Very well then.") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
