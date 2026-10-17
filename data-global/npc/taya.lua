local internalNpcName = "Taya"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Ninev's outfit, with Taya's own colours as seen in game.
npcConfig.outfit = {
	lookType = 1199,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 125,
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

-- The oracle mission of the Kilmaresh questline is not implemented, so she only talks about it.
keywordHandler:addKeyword({ "oracle" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"Have you ever heard of the Circle of the Midnight Flame? They are an order of seers and prophets. Since I was a little girl it was my greatest dream to join them. ...",
		"Sadly, I was not born with the gift of true seeing. But I firmly believe there is a way. I heard stories about an artefact that can grant the power of seeing.",
	},
})
keywordHandler:addKeyword({ "midnight flame" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "The Circle of the Midnight Flame is an order of seers and prophets. One day I will be one of them.",
})
keywordHandler:addKeyword({ "artefact" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "They say it is called the Eye of Suon. Ask Narsai in Issavi about it, I guess she knows more.",
})
keywordHandler:addKeyword({ "job" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I tend the sheep here in the steppe, but my heart belongs to the stars.",
})

npcHandler:setMessage(MESSAGE_GREET, "Suon's blessing!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Suon be praised.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Well, bye then.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
