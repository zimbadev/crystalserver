local internalNpcName = "A Seagull"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 3

npcConfig.outfit = {
	lookType = 223,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 10000,
	chance = 50,
	{ text = "*squawk*" },
	{ text = "*screech*" },
}

npcType:speechBubble(SPEECHBUBBLE_TRAVELER)

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

-- Rookgaard destination
local ROOKGAARD_DESTINATION = Position(32097, 32219, 7)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "rookgaard") then
		npcHandler:say("Squawk! Long time I visited that isle. Why do you ask? Do you wish to go there?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Careful, it's a one-way ticket! Squawk! You can never come back here if you leave now! Are you {SURE} you want to go to Rookgaard?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Squawk! Then so be it.", npc, creature)
			player:teleportTo(ROOKGAARD_DESTINATION)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) >= 1 then
			npcHandler:say("Squawk! Wise decision perhaps.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sure") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Squawk! Then so be it.", npc, creature)
			player:teleportTo(ROOKGAARD_DESTINATION)
			local town = Town(TOWNS_LIST.ROOKGAARD)
			player:setTown(town)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:setTopic(playerId, 0)

			player:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, -1)
			player:setStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting, -1)
			player:setStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor, -1)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Squawk!")
npcHandler:setMessage(MESSAGE_FAREWELL, "*screech*")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Squawk!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
