local internalNpcName = "An Ominous Bat"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = "an ominous bat"

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 122,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	if not player then
		return false
	end

	if player:getLevel() < 250 or player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline) > 0 then
		npcHandler:say("<the bat just glares at you>", npc, creature)
	else
		npcHandler:say("The grave is calling you.", npc, creature)
		player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 1)
		player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheGrave, 1)
	end

	npcHandler:resetNpc(creature)

	return false
end

npcHandler:setMessage(MESSAGE_WALKAWAY, "<the bat just glares at you>")
npcHandler:setMessage(MESSAGE_FAREWELL, "<the bat just glares at you>")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
