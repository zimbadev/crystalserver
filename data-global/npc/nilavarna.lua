local internalNpcName = "Nilavarna"
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
	lookType = 1539,
	lookHead = 57,
	lookBody = 125,
	lookLegs = 95,
	lookFeet = 69,
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
			"The yukti aren't working as they should; the plants have silvery veins and even the tides are out of balance. The sea and the land rarely speak with one voice.",
			"When they do, it means something momentous has happened. Your observations point to only one conclusion: something connected to the power of the moon has fallen from the sky.",
			"But speculation is not enough. We must know exactly where the light fell from the sky and what is happening there now.",
			"There is someone who watches the sky above Marapur every night: the astronomer Udu, in her tower at Moonfall. If anyone has seen where the light fell, it is her.",
			"Speak to her. Perhaps she can tell us where this light has touched the earth.",
		}, npc, creature)
		return true
	end

	npcHandler:say({
		"So, my people here in Silvertides noticed it too. It is true: Recently, the sky above Marapur has shown a mysterious sign.",
		"A light fell in the east, silent and silvery like a piece of the moon herself. Since then, our seers have reported unrest in the currents of magic.",
		"Our yukti react ... unwillingly, you might say, as if something foreign were disturbing their flow. Nipuna will probably be able to tell you more about this.",
		"Our shaman, Tarisu, is convinced he hears the sea rushing differently, and Dhira spoke of plants that have changed. Perhaps it is nothing.",
		"But when the sky sends a sign, it would be foolish to ignore it. Ask my people what they have observed and then report back to me.",
		"If something has truly fallen from the sky, we must know whether it is a gift or a warning.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Nilavarna, of the Silvertides." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I lead the nagas of these shores. The sea tells me what it wants and I listen." })
keywordHandler:addKeyword({ "silvertides" }, StdModule.say, { npcHandler = npcHandler, text = "Our home. Where the tide meets the stone and neither one wins." })
keywordHandler:addKeyword({ "amati" }, StdModule.say, { npcHandler = npcHandler, text = "The moon goddess. She fell once and the stars carried her back. We have not forgotten." })
keywordHandler:addKeyword({ "tarisu" }, StdModule.say, { npcHandler = npcHandler, text = "Our shaman. He hears the tides the way you hear voices." })
keywordHandler:addKeyword({ "dhira" }, StdModule.say, { npcHandler = npcHandler, text = "She cares for the beavers and knows the plants of the lagoon better than any scholar." })
keywordHandler:addKeyword({ "nipuna" }, StdModule.say, { npcHandler = npcHandler, text = "She keeps the shop and works the yukti. If the magic is off, she noticed first." })
keywordHandler:addKeyword({ "yukti" }, StdModule.say, { npcHandler = npcHandler, text = "The gestures that shape magic. Ask Nipuna, she lives by them." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, two-leg. What a rare sight around here.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Go with the tide.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Go with the tide.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
