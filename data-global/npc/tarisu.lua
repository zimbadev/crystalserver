local internalNpcName = "Tarisu"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

-- TODO(outfit): placeholder until the official appearance is read from the client staticdata.
npcConfig.outfit = {
	lookType = 1539,
	lookHead = 114,
	lookBody = 124,
	lookLegs = 114,
	lookFeet = 51,
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

	if not MsgContains(message, "tides") then
		return true
	end

	npcHandler:say({
		"It's possible that something has disturbed the tides. I'm not sure what it could be. But it must be very powerful to cause something like this. Take this shell gauge.",
		"Use it at our three tide markers along the coast of the Sparkling Lagoon and the Emerald Gardens. Look out for any irregularities.",
		"If the tides really are disturbed, the instrument will show it.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Tarisu, shaman of Silvertides." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I listen to the sea and tell my people what it says." })
keywordHandler:addKeyword({ "sea", "ocean" }, StdModule.say, { npcHandler = npcHandler, text = "The sea has one voice for every hour of the day. Lately one of them is a stranger." })
keywordHandler:addKeyword({ "amati" }, StdModule.say, { npcHandler = npcHandler, text = "The moon pulls the water. When the moon is troubled, so is the tide." })
keywordHandler:addKeyword({ "marker", "markers" }, StdModule.say, { npcHandler = npcHandler, text = "Three stones along the coast, set by my grandmother's grandmother. They have measured the water ever since." })

npcHandler:setMessage(MESSAGE_GREET, "May the tides always guide you safely.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May the tides always guide you safely.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May the tides always guide you safely.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
