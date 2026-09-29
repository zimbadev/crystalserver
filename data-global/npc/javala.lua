local internalNpcName = "Javala"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- Feverbloom asuri appearance, read from the client staticdata (true feverbloom asura,
-- raceId 2805). See docs/update-15.30-criaturas.md.
npcConfig.outfit = {
	lookType = 1068,
	lookHead = 114,
	lookBody = 97,
	lookLegs = 114,
	lookFeet = 94,
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

	if not MsgContains(message, "moon") then
		return true
	end

	npcHandler:say({
		"You have come far below the surface, little mortal. Far enough to discover things that were never meant for your eyes. You seek to enter the lower areas of this complex, don't you?",
		"Where the moonsilver is extracted and where my misguided sisters conduct their experiments. The midnights and frostflowers believe they have discovered a path to power.",
		"They combine the moonsilver with blood and certain plants and infuse themselves with it, hoping to bend its power to their will. Fools. They do not understand what they are awakening.",
		"We, the dawnfire and {feverbloom} asuri, have watched these experiments with growing concern. Sun and fire are the true sources of might. Power drawn from the moon is unstable and corrupting.",
		"If our midnight and frostflower sisters succeed, they will dominate all other asuri. That we cannot allow. And that is where you enter the story, mortal. Let's ally in this matter.",
		"The entrance to the lower areas is sealed. Only a handful of keys exist but I possess one of them. If I give it to you, you will descend into the lower halls.",
		"Sabotage the experiments and sever my sisters' connection to the moonsilver. Do this and the dawnfire and feverbloom asuri will consider you an ally.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Javala, of the dawnfire." })
keywordHandler:addKeyword({ "feverbloom" }, StdModule.say, { npcHandler = npcHandler, text = "The feverbloom bloom in heat and fever, as we burn in sunlight. Both of us take our strength from fire, not from that cold silver light my sisters worship." })
keywordHandler:addKeyword({ "dawnfire" }, StdModule.say, { npcHandler = npcHandler, text = "We greet the sun before it rises. That is where power comes from, mortal. Not from a dead rock in the sky." })
keywordHandler:addKeyword({ "midnight", "frostflower" }, StdModule.say, { npcHandler = npcHandler, text = "My misguided sisters. They drink the moon and call the poisoning a gift." })
keywordHandler:addKeyword({ "moonsilver" }, StdModule.say, { npcHandler = npcHandler, text = "Unstable, corrupting and utterly fascinating to those with no patience." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, little mortal.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Go quietly, mortal.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Go quietly, mortal.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
