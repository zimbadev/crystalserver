local internalNpcName = "Billy the tasker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 144,
	lookHead = 116,
	lookBody = 78,
	lookLegs = 94,
	lookFeet = 78,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.shop = {
	-- HuntsMan rank
	-- Sell offers
	{ clientId = 10297, sell = 50, itemName = "antlers", storageKey = POINTSSTORAGE, storageValue = 10 },
}

local messageStartTask = {
	["Beginner"] = {

    },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

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
	local playerId = player:getId()

	if player:getStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry) ~= 0 then
		npcHandler:setMessage(MESSAGE_GREET, "Hi there, do you want to to {join} the 'Paw and Fur - Hunting Elite'?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Welcome to the 'Paw and Fur - Hunting Elite' |PLAYERNAME|. Feel free to do {tasks} for us.")
	end

	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	message = message:gsub("(%l)(%w*)", function(a, b)
		return string.upper(a) .. b
	end)

	if (MsgContains("join", message) or MsgContains("yes", message)) and npcHandler:getTopic(playerId) == 0 and player:getStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry) ~= 0 then
		player:setStorageValue(JOIN_STOR, 1)
		player:setStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry, 0)
		player:setStorageValue(Storage.KosOts.TaskSystem.QuestLinePoints, 0)
		player:setStorageValue(Storage.KosOts.TaskSystem.POINTSSTORAGE, 0)
		npcHandler:say("Great! A warm welcome to our newest member: |PLAYERNAME|! Ask me for a {task} if you want to go on a hunt.", npc, creature)
	elseif table.contains({ "tasks", "task", "mission" }, message:lower()) then
		if player:getStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry) ~= 0 then
			return npcHandler:say("You'll have to {join}, to get any {tasks}.", npc, creature)
		end
	end
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Happy hunting, dear no-life!")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
