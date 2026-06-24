local internalNpcName = "Captain Indigo"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Captain Indigo: Pirate outfit (female = 155) with both addons.
-- TODO(colors): confirm head/body/legs/feet via the palette/StaticDataEditor.
npcConfig.outfit = {
	lookType = 155,
	lookHead = 85,
	lookBody = 0,
	lookLegs = 76,
	lookFeet = 126,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Sail with the Royal Tibia Line to Thais!" },
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

-- Return travel (Targuna -> Thais). Each trip needs a Sail Pass, otherwise it costs 5000 gold.
local THAIS_DESTINATION = Position(32312, 32208, 6)
local SAIL_PASS_ID = 53167
local RETURN_FEE = 5000

local TOPIC_TRAVEL_CONFIRM = 1

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "passage") or MsgContains(message, "sail") or MsgContains(message, "thais") then
		npcHandler:say("If you want I can sail you to {Thais}. It is our capital and the oldest city in Tibia.", npc, creature)
		if player:getItemCount(SAIL_PASS_ID) > 0 then
			npcHandler:say("Your Sail Pass will cover the trip. Do you wish to set sail to Thais?", npc, creature)
		else
			npcHandler:say("Without a Sail Pass the trip costs " .. RETURN_FEE .. " gold coins. Do you wish to set sail to Thais?", npc, creature)
		end
		npcHandler:setTopic(playerId, TOPIC_TRAVEL_CONFIRM)
		return true
	end

	if MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) ~= TOPIC_TRAVEL_CONFIRM then
			return true
		end
		npcHandler:setTopic(playerId, 0)

		-- A Sail Pass covers the trip, otherwise charge the fee.
		if player:getItemCount(SAIL_PASS_ID) > 0 then
			player:removeItem(SAIL_PASS_ID, 1)
		elseif not player:removeMoney(RETURN_FEE) then
			npcHandler:say("You need a Sail Pass or " .. RETURN_FEE .. " gold coins to sail to Thais.", npc, creature)
			return true
		end

		npcHandler:say("Set the sails!", npc, creature)
		player:teleportTo(THAIS_DESTINATION)
		THAIS_DESTINATION:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	if MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == TOPIC_TRAVEL_CONFIRM then
			npcHandler:say("We would like to serve you some time.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	return true
end

-- Keywords / lore
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Captain Indigo from the Royal Tibia Line." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the captain of this ship." })
keywordHandler:addKeyword({ "captain" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the captain of this ship." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia." })
keywordHandler:addKeyword({ "line", "ship" }, StdModule.say, { npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "This little island is a pleasant place, but if you seek adventure the mainland awaits." })

npcHandler:setMessage(MESSAGE_GREET, "Welcome on board. Where can I {sail} you today?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Recommend us if you were satisfied with our service.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

npcType:register(npcConfig)
