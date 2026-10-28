local internalNpcName = "Captain Coohan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 1378,
	lookHead = 57,
	lookBody = 121,
	lookLegs = 132,
	lookFeet = 127,
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

	if MsgContains(message, "name") then
		npcHandler:say("My name is Ca'coohan Tse, which translates to 'rides even an alligator'. But you can call me, Captain Coohan.", npc, creature)
	elseif MsgContains(message, "job") then
		npcHandler:say("Me is the greatest captn' of all ye' isle.", npc, creature)
	elseif MsgContains(message, "island") then
		npcHandler:say({
			"Aye, there are rumours about a hidden treasure on a small island east of here. If you are interested, why not go on a little journey with me? I have a raft which lays at anchor in the north of the island. ...",
			"Meet me there and we will set forth on a fantastic voyage!",
		}, npc, creature)
	elseif MsgContains(message, "pirat") then
		npcHandler:say("Captain Coohan is afraid if no pirat. With cleverness and luck I always evaded their ships.", npc, creature)
	elseif MsgContains(message, "trekkie") then
		npcHandler:say("I worked on that raft for years. Now that it's ready to conquer the seas, I only need a decent crew.", npc, creature)
	elseif MsgContains(message, "captain") or MsgContains(message, "captn") then
		npcHandler:say("I don't have a boat, friend! I have a raft! I call it the Trekkie.", npc, creature)
	elseif MsgContains(message, "crew") then
		npcHandler:say({
			"I'm considering to hire a diverse crew, Perhaps an orc for security issues, and some soulless golem to keep all the information that we might gather. ...",
			"I might even consider to hire an elf, because I kind of like their ears.",
		}, npc, creature)
	elseif MsgContains(message, "washingstone") then
		npcHandler:say("One day I will rediscover the fabled city of Washingstone.", npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Ahoy, Ahoy, Ye' Landlubber.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Fair winds!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Fair winds!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
