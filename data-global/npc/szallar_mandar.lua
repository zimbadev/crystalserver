local internalNpcName = "S'Zallar M'Andar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000 -- TODO
-- npcConfig.walkRadius = 2 -- TODO

npcConfig.outfit = {
	lookType = 115,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	-- TODO: Add voices
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
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am S'Zallar M'Andar, keeper of the ancient traditionsss." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I presserve the {knowledge} of my people and guide thossse who ssseek enlightenment." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "knowledge" }, StdModule.say, { npcHandler = npcHandler, text = "The old waysss hold many ssecretsss. Not all are meant for mortal earsss." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "ancient" }, StdModule.say, { npcHandler = npcHandler, text = "We have walked thessse landsss sssince before the humansss came. Our memory isss long." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "traditions" }, StdModule.say, { npcHandler = npcHandler, text = "The traditionsss of my people are sssacred. They mussst be protected at all costsss." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "secrets" }, StdModule.say, { npcHandler = npcHandler, text = "Ssssome ssecretsss are too dangerousss for the uninitiated. Prove your worth firsst." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "If you ssseek my asssissstance, you mussst firsst prove yourssself worthy." }) -- TODO: Confirmar
keywordHandler:addKeyword({ "worthy" }, StdModule.say, { npcHandler = npcHandler, text = "Worthinessss isss proven through actionsss, not wordsss." }) -- TODO: Confirmar

npcHandler:setMessage(MESSAGE_GREET, "Greetingsss, warm-blood. What bringsss you to my pressence?") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "May the ancient onesss watch over you.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "The path awaitsss...") -- TODO: Confirmar

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
