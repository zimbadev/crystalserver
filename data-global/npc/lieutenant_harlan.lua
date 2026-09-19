local internalNpcName = "Lieutenant Harlan"
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
	lookType = 131, -- TODO: Confirmar lookType
	lookHead = 78, -- TODO: Confirmar cor
	lookBody = 76, -- TODO: Confirmar cor
	lookLegs = 76, -- TODO: Confirmar cor
	lookFeet = 95, -- TODO: Confirmar cor
	lookAddons = 1, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "The Raubritter will pay for their crimes!" }, -- TODO: Confirmar
	{ text = "Stay focused, soldiers!" }, -- TODO: Confirmar
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Lieutenant Harlan, field operations officer." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I coordinate our {field operations} against the {Raubritter}." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "field operations" }, StdModule.say, { npcHandler = npcHandler, text = "We conduct patrols, reconnaissance, and strike missions against enemy positions." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "raubritter" }, StdModule.say, { npcHandler = npcHandler, text = "Those criminals have terrorized this region for too long. We're putting an end to it." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "lieutenant" }, StdModule.say, { npcHandler = npcHandler, text = "I serve under Captain Marie-Denise Banner. She's a brilliant commander." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "captain" }, StdModule.say, { npcHandler = npcHandler, text = "Captain Banner leads our forces with skill and determination." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "hartford" }, StdModule.say, { npcHandler = npcHandler, text = "Guard Captain Hartford handles defensive operations. A solid officer." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "We have several missions available for capable adventurers. Are you interested in helping?" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "We need fighters willing to strike at the Raubritter strongholds." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "patrol" }, StdModule.say, { npcHandler = npcHandler, text = "Our patrols keep the roads safe, but the Raubritter are always lurking." }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "Greetings, soldier. Looking for a mission?") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "Good luck out there. Show those Raubritter no mercy.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "Stay alert.") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
