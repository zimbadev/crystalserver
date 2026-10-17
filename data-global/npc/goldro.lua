local internalNpcName = "Goldro"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 160,
	lookHead = 39,
	lookBody = 79,
	lookLegs = 97,
	lookFeet = 98,
	lookAddons = 0,
	lookMount = 0,
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

-- TODO(text): no official transcript exists for this one yet - a roleplay NPC of Salgadora with
-- no trade. These lines are ours, written to match the town's situation after the moon fragment
-- fell. Replace them if the real dialogue shows up.
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Goldro." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I count what comes in and what goes out. Lately far more goes out." })
keywordHandler:addKeyword({ "salgadora" }, StdModule.say, { npcHandler = npcHandler, text = "What is left of it. The mayor holds it together, more or less." })
keywordHandler:addKeyword({ "moonspawn", "moonspawns" }, StdModule.say, { npcHandler = npcHandler, text = "They come from the wastes east of here. They were not there before the sky broke." })
keywordHandler:addKeyword({ "moonsilver" }, StdModule.say, { npcHandler = npcHandler, text = "Everyone wants it. Nobody agrees on who it belongs to. That is the whole story of this island." })

npcHandler:setMessage(MESSAGE_GREET, "Hello there, |PLAYERNAME|. Another one off the boat, I see.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Keep your head down.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Keep your head down.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
