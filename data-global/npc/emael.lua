local internalNpcName = "Emael"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 289,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 75,
	lookFeet = 113,
	lookAddons = 1,
	lookMount = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Not enough space for all my trophies..." },
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

-- Winter Update 2026: proficiency catalysts can be traded up, keeping the total proficiency experience
-- (20 lesser = 4 normal = 1 greater).
local CATALYST_GREATER = 51589
local catalystExchanges = {
	-- topic = { itemId, amount needed for 1 greater proficiency catalyst, name }
	[3] = { itemId = 54266, amount = 20, name = "lesser proficiency catalysts" },
	[4] = { itemId = 51588, amount = 4, name = "proficiency catalysts" },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	local catalystExchange = catalystExchanges[npcHandler:getTopic(playerId)]
	if npcHandler:getTopic(playerId) == 2 and MsgContains(message, "lesser") then
		npcHandler:say("Do you want to exchange 20 lesser proficiency catalysts for 1 greater proficiency catalyst?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif npcHandler:getTopic(playerId) == 2 and MsgContains(message, "normal") then
		npcHandler:say("Do you want to exchange 4 proficiency catalysts for 1 greater proficiency catalyst?", npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif MsgContains(message, "catalyst") or MsgContains(message, "exchange") then
		npcHandler:say("I can exchange 20 lesser proficiency catalysts or 4 proficiency catalysts for 1 greater proficiency catalyst. Which ones do you want to exchange, the {lesser} or the {normal} ones?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif catalystExchange and message == "yes" then
		if player:getItemCount(catalystExchange.itemId) < catalystExchange.amount then
			npcHandler:say("You don't have " .. catalystExchange.amount .. " " .. catalystExchange.name .. ".", npc, creature)
		elseif player:removeItem(catalystExchange.itemId, catalystExchange.amount) then
			player:addItem(CATALYST_GREATER, 1)
			npcHandler:say("Here is your greater proficiency catalyst.", npc, creature)
		else
			npcHandler:say("You don't have " .. catalystExchange.amount .. " " .. catalystExchange.name .. ".", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif catalystExchange and message == "no" then
		npcHandler:say("Blessings on your hunts!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif message == "podium" then
		npcHandler:say("Do you want to appropriately show off your boss trophies and buy an additional podium of vigour for 1000000 Gold?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif message == "yes" and npcHandler:getTopic(playerId) == 1 then
		if player:getStorageValue(30020) == 1 then
			local inbox = player:getStoreInbox()
			if not inbox or #inbox:getItems() >= inbox:getMaxCapacity() then
				npcHandler:say("Please make sure you have free slots in your store inbox.", npc, creature)
			elseif player:removeMoney(1000000) then
				npcHandler:say("Ah, I see you killed a lot of dangerous creatures. Here's your podium of vigour!", npc, creature)
				local decoKit = inbox:addItem(ITEM_DECORATION_KIT, 1)
				if decoKit then
					decoKit:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Unwrap it in your own house to create a <" .. ItemType(38707):getName() .. ">.")
					decoKit:setCustomAttribute("unWrapId", 38707)
				end
			else
				npcHandler:say("You don'\t have enough money.", npc, creature)
			end
		else
			npcHandler:say("You have not aquired enough knowledge in hunting big scary creatures.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif message == "no" and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Blessings on your hunts!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
end

npcHandler:setMessage(MESSAGE_GREET, { "Hello! Ever asked yourself who killed all the monsters for the wall trophies? Yeah, that was me, Emael the Beasthunter! I am an expert in displaying trophies. ...", "So if you have at least some dangerous monster to show off I strongly advise you to aquire a {podium} of vigour. I can also {exchange} proficiency catalysts for greater ones." })
npcHandler:setMessage(MESSAGE_FAREWELL, "I wish you a good hunt. Goodbye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good hunting!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
