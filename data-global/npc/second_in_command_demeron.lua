local internalNpcName = "Second in Command Demeron"
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
	lookLegs = 94, -- TODO: Confirmar cor
	lookFeet = 116, -- TODO: Confirmar cor
	lookAddons = 2, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Strategy wins wars, not just brute force." }, -- TODO: Confirmar texto
	{ text = "Every detail matters in battle." }, -- TODO: Confirmar texto
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

-- Transcription from TibiaWiki
keywordHandler:addKeyword({ "spares" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I will get back to this later. Now either you're just a confused bystander or you're on a mission to get on my nerves. What will it be?",
})

keywordHandler:addKeyword({ "mission" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "If you can't tell me why you're here, stop distracting me and at least try helping some of my men knocking this measly camp into shape!",
})

keywordHandler:addKeyword({ "tell" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "How did you even manage to get here with that sorry excuse of a sailing boat? So you say Kesar himself sent you, giving you details he did not disclose, even to us? And do you have any proof for that outrageous claim?",
})

-- TODO: Implementar quest dialogue completo com callbacks para "yes" responses
keywordHandler:addKeyword({ "proof" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Royal Bounacean advisor? Why should Kesar constitute someone like you, this is saying nothing without proof. Has he really told you what this is all about?",
})

keywordHandler:addKeyword({ "bastard" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "A bastard?! Lower your voice, stranger, that's no trifling matter. At all... you say you have solid evidence of this?",
})

keywordHandler:addKeyword({ "certificate" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"A certificate of... oh my. That should have stirred something up in the ivory tower, heh. ...",
		"Alright... well, excuse my temper, it's all hands on deck for us since we barely set foot on this accursed rock. Let's take a break and start this conversation properly. ...",
		"We need to find the heir of this Eldoran then. His knights must be on this island somewhere, but we did not encounter any of them so far. If the threat you mentioned is real, they may be in grave danger, as are we. ...",
		"Fight your way through the mines and further into the isle. We need to get to the bottom of this and we also need to find a way to survive: there is no escaping for us in our current state.",
	},
})

npcHandler:setMessage(MESSAGE_GREET, "If you don't carry any spares, state your business quickly or move along.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Move along.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
