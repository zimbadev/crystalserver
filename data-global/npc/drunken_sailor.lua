local internalNpcName = "Drunken Sailor"
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
	lookType = 128, -- TODO: Confirmar lookType (Citizen Male?)
	lookHead = 95, -- TODO: Confirmar cor
	lookBody = 95, -- TODO: Confirmar cor
	lookLegs = 95, -- TODO: Confirmar cor
	lookFeet = 95, -- TODO: Confirmar cor
	lookAddons = 0, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "*hic*" }, -- TODO: Confirmar texto
	{ text = "Another round!" }, -- TODO: Confirmar texto
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "*hic* Me name? I... I don't remember... *hic*" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "*hic* I'm a... a sailor! The besht sailor on the sheven sheas! *hic*" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "sailor" }, StdModule.say, { npcHandler = npcHandler, text = "*hic* I've shailed all the oceansh! *hic*" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "drunk" }, StdModule.say, { npcHandler = npcHandler, text = "Drunk?! I'm not drunk! *hic* You're drunk!" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "rum" }, StdModule.say, { npcHandler = npcHandler, text = "*hic* Rum! Where'sh the rum?!" }) -- TODO: Confirmar
keywordHandler:addKeyword({ "ship" }, StdModule.say, { npcHandler = npcHandler, text = "*hic* My ship... it'sh... somewhere..." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "*hic* Help? I need another drink! *hic*" }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "*hic* Oh... hello there, matey! *hic*") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "*hic* Shee ya later! *hic*") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "*hic*") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
