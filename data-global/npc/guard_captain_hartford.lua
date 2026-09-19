local internalNpcName = "Guard Captain Hartford"
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
	lookType = 131, -- TODO: Confirmar lookType (Knight Male?)
	lookHead = 78, -- TODO: Confirmar cor
	lookBody = 52, -- TODO: Confirmar cor
	lookLegs = 94, -- TODO: Confirmar cor
	lookFeet = 116, -- TODO: Confirmar cor
	lookAddons = 3, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Stay alert, guards!" }, -- TODO: Confirmar
	{ text = "No enemy shall pass our defenses!" }, -- TODO: Confirmar
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
keywordHandler:addKeyword({ "business" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"So you tell me you took a stroll all the way up the mountain, right through the middle of the enemy lines, past the bulk of the cursed hordes in the outskirts and in here. ...",
		"All this with a healthy disregard of our bastion's massive walls, the defense perimeter of my guards down in the dell and the influence of the warlock. Explain yourself.",
	},
})

keywordHandler:addKeyword({ "explain" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"I see. If Kesar himself got wind of this and decided to send help, then his court wizards must have to the same conclusion as Eldoran. We're screwed. ...",
		"Royally so, if I might add. There is no way through the outer perimeter right now. We need to defend the castle yard and I have no men to spare. ...",
		"That's the situation. If the others are pinned down and the mines are still lost, then we cannot get outside help or supplies. ...",
		"You have been very lucky - and very bold to make an attempt like this on your own. Alas, a few warriors would indeed have a greater chance than a battallion under these circumstances. ...",
		"I say we continue to stick to that plan. Say, are you in for another round?",
	},
})

-- TODO: Implementar quest dialogue completo com callbacks para "yes" response
keywordHandler:addKeyword({ "harpies" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"The winged horrors that haunt us during the night are another story entirely. We do not yet know how many of them exist or where their roost is located, but they want to occupy the bastion. ...",
		"If you can help us with those night harpies, we would be grateful and far in your debt. Just bring me a few of their beaks. ...",
		"To do so, gently pull the beak of a killed harpy, denn press it downward and pull it slightly to the left or right in a single, firm move. It takes some skill and my not always work but I need proof of at least a few more of them dead. ...",
		"If you show your goodwill, I will give you access to the upper hall, you will be able to contact Eldoran himself, if you can get through.",
	},
})

npcHandler:setMessage(MESSAGE_GREET, "HALT! Outsider, state your business!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Stay vigilant.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
