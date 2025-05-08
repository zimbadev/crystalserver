local internalNpcName = "Tonar"
local npcType = Game.createNpcType("Tonar Oskayaat")
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 146,
	lookHead = 0,
	lookBody = 66,
	lookLegs = 124,
	lookFeet = 0,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "I don't feel safe here ... I hope we can return to Ankrahmun soon." },
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
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	local scarabOcarinaStorage = 2642025
	if MsgContains(message, "scarab") or MsgContains(message, "ocarina") then
		if player:getStorageValue(scarabOcarinaStorage) >= 1 then
			npcHandler:say("How does it sound? Did you liked it? Well, that's all I can do for you.", npc, creature)
		end
		npcHandler:say("An sacarb ocarina you say? Hmmm. I can make you one with an intact scarab shell that is not smudgy. Did you got any by any chance?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
		if player:removeItem(4195, 1) then
			npcHandler:say("Excelent. Hands at work then. ... Here is your scarab ocarina.", npc, creature)
			player:addItem(43740, 1)
			player:setStorageValue(scarabOcarinaStorage, 1)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say("Do you really have it there? Uh, I said not smudgy. If you got one wait some minutes for it to decompose.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end

	return true
end

-- Travel
local function addTravelKeyword(keyword, text, cost, destination, action, condition)
	if condition then
		keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = "You are not ready yet." }, condition)
	end

	local travelKeyword = keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = text, cost = cost, discount = "postman" })
	travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, text = "Alright, off we go!", cost = cost, discount = "postman", destination = destination }, nil, action)
	travelKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "We would like to serve you some time.", reset = true })
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
addTravelKeyword("passage", "A passage to Ankrahmun? Shall we cast off?", 0, Position(33182, 32883, 7))

npcHandler:setMessage(MESSAGE_GREET, "Welcome back, Sir.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
