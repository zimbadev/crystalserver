local internalNpcName = "Captain Marie-Denise Banner"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- TODO: Confirmar outfit na wiki (lookType, cores, addons)
npcConfig.outfit = {
	lookTypeEx = 52733,
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

-- Transcription from TibiaWiki
keywordHandler:addKeyword({ "wall" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"It's... alright. Alright... I can stand- no, well... I can't stand. But... I can still... help you. ...",
		"When I came to my senses, that golem... over there... was watching me. When I came to, it quickly pressed a combination of... buttons... at that wall... next to me. ...",
		"The combination is... upper, upper, lower, lower, left, right... just... go, or I... aaah. ...",
		"May this at least... be of... use to you... I know... what I have done.",
	},
})

keywordHandler:addKeyword({ "senses" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"I... killed... everyone. Their faces, their eyes... blood, everywhere. Aaah... I don't... know how it came to pass. But there is an... aaach.. entity, on this isle... ...",
		"Something... controls the doomed knights that roam this... isle. They must all have... succumbed, to the power of this... thing. Like I did... my... self. ...",
		"It was like a veil of blood before my eyes, I lost control of... everything. Witnessing... everything... aaah- helpless. ...",
		"After some time... I managed... to get ahold of myself and... dragged my body forward, deeper into the isle. I did... *cough* not encounter a single souls on my... way here, willing to... talk. ...",
		"You are the first... I meet who is not... openly hostile. Aaah...",
		"I... am sorry. Don't tell... Demeron... I survived. The captain he once looked up to... died in that silver mine. I... aaah... won't come back... I... leaving, the unit. ...",
		"There is... something... I have to do, when I recover. I can't help you much more... right now. But... ah... we will meet again.",
	},
})

npcHandler:setMessage(MESSAGE_GREET, "Wait... the wall... the... combination... aaah.")
npcHandler:setMessage(MESSAGE_FAREWELL, "...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
