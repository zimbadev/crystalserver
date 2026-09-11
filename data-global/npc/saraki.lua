local internalNpcName = "Saraki"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- TODO(outfit): placeholder until the official appearance is read from the client staticdata.
npcConfig.outfit = {
	lookType = 1543,
	lookHead = 114,
	lookBody = 113,
	lookLegs = 0,
	lookFeet = 114,
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

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if not (MsgContains(message, "moon") or MsgContains(message, "report")) then
		return true
	end

	if MsgContains(message, "report") then
		npcHandler:say({
			"Interesting. The yukti are behaving unpredictably, and on top of that there are silver veins in the plants and shifts in the tides. This is no coincidence.",
			"Such a change does not arise out of nowhere. A new source of power must have appeared in Marapur. If anyone has seen exactly where the light fell from the sky, it has to be Udu.",
			"Our astronomer observes the movements of the stars every night from her tower. She will know where the light came down. Go and ask her about it.",
			"If we know where this light touched the earth, we can hopefully finally understand what we are dealing with.",
		}, npc, creature)
		return true
	end

	npcHandler:say({
		"So, my people here in Moonfall noticed it too. It is true: Several nights ago, our watchmen saw a pale light descend in the east, like a second moon falling from the sky.",
		"Since then, my people have reported strange occurrences on our islands. Our mages say that their yukti no longer respond as reliably as before.",
		"Sundara may be able to tell you more about this. And the coastal nagas down in Silvertides report changes in the plants and claim that the tides are behaving unusually.",
		"Tarisu, the shaman of Silvertides, may know more about this. Perhaps it is just coincidence. Perhaps not. But I prefer to have certainty.",
		"Speak to Sundara here in Moonfall and to Tarisu down in Silvertides and ask them about the yukti, the tides and the changed plants.",
		"Listen to what they have observed and see if there is more to these rumours than meets the eye. Find out what has happened and then return to me. We need to know what we are dealing with.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Saraki, maharani of Moonfall." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I rule Moonfall and I watch over the peace of my people." })
keywordHandler:addKeyword({ "moonfall" }, StdModule.say, { npcHandler = npcHandler, text = "Moonfall is where the goddess touched the world. We have guarded this place ever since." })
keywordHandler:addKeyword({ "amati" }, StdModule.say, { npcHandler = npcHandler, text = "The Moon Goddess fell upon this island long ago, and the stars themselves descended to carry her home." })
keywordHandler:addKeyword({ "udu" }, StdModule.say, { npcHandler = npcHandler, text = "Our astronomer. She sleeps by day and argues with the sky by night." })
keywordHandler:addKeyword({ "sundara" }, StdModule.say, { npcHandler = npcHandler, text = "She keeps the potion shop here in Moonfall and knows the yukti better than anyone." })
keywordHandler:addKeyword({ "yukti" }, StdModule.say, { npcHandler = npcHandler, text = "Our magic. Ask Sundara about it, she will explain it far better than I could." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, traveller. May the Moon Goddess bless you.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May the Moon Goddess light your path.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May the Moon Goddess light your path.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
