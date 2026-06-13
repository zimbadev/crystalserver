local internalNpcName = "Dragon Ancestor Spirit"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000 -- TODO
-- npcConfig.walkRadius = 2 -- TODO

npcConfig.outfit = {
	lookType = 1883,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.speechBubble = 1

npcConfig.light = {
	level = 0,
	color = 0,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Zzzzz." }, -- TODO: Confirmar texto (placeholder)
	{ text = "Farewell, friend." }, -- TODO: Confirmar texto
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am but a whisper of what once was... an echo of the great dragons of old." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I guard the ancient knowledge of dragonkind. Few mortals are worthy to hear it." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "We were once the rulers of this world. Now, only memories remain... and spirits like myself." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "ancestor" }, StdModule.say, { npcHandler = npcHandler, text = "I have witnessed ages pass. The rise and fall of civilizations. All return to dust in time." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "spirit" }, StdModule.say, { npcHandler = npcHandler, text = "My physical form has long since turned to ash, but my essence persists, bound to this place." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "knowledge" }, StdModule.say, { npcHandler = npcHandler, text = "The wisdom of ages flows through me. But such knowledge is not freely given." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "worthy" }, StdModule.say, { npcHandler = npcHandler, text = "To prove your worth, you must show courage, wisdom, and respect for the ancient ways." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "ancient" }, StdModule.say, { npcHandler = npcHandler, text = "Before humans walked these lands, dragons ruled the skies. Those were glorious times." }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "Mortal... you stand before an ancient spirit. Speak, if you dare.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "The winds of time carry you away... for now.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "Flee, mortal. Perhaps you are not ready.") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
