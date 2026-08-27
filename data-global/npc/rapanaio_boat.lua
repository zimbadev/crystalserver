local internalNpcName = "Rapanaio"
local npcType = Game.createNpcType("Rapanaio (Boat)")
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 0,
	lookBody = 21,
	lookLegs = 20,
	lookFeet = 39,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Passage to {Evil Isle}." },
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

-- Basic
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Rapanaio from the Royal Tibia Line." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the captain of this sailing-ship." })

-- The Isle of Evil Quest
local KV_SCOPE = "the-isle-of-evil"
local TheIsleOfEvil = Storage.Quest.U8_5.TheIsleOfEvil
local ISLE_DESTINATION = Position(32668, 31457, 6)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "evil isle") then
		local kv = player:kv():scoped(KV_SCOPE)

		if kv:get("rapanaio-travel") == true then
			npcHandler:say("Do you seek a passage to Evil Isle?", npc, creature)
			npcHandler:setTopic(playerId, 9)
		else
			npcHandler:say("Never heard about a place like this.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end

	if MsgContains(message, "mission") and npcHandler:getTopic(playerId) == 0 then
		if player:getStorageValue(TheIsleOfEvil.Mission06) ~= 1 then
			npcHandler:say("I don't have any mission for you right now.", npc, creature)
			return true
		end

		npcHandler:say({
			"Hello, my friend, what took you so long? Some sightseeing in my cavern, perhaps? You did not even notice me when I passed you in the cavern earlier. Tsk, you really should be more alert if you value your life. ...",
			"This here is my secret. An underwater boat! Evil will not even see us coming! I hope you are prepared for a big battle on that isle! If not, you had better go and get some additional resources and then return. So, do you feel ready for our trip?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if MsgContains(message, "yes") and npcHandler:getTopic(playerId) >= 1 and npcHandler:getTopic(playerId) <= 8 then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				"You are aware that this could mean your death? I mean the evil is probably overpowering and .. and I will not be able to help you. I will have to stay with the boat to ensure the fight goes on even if you die.",
				"So, do you still think it is a good idea?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({
				"Now seriously, we .. I mean, you don't have to do this! I would not blame you at all. You probably have plans for your future which don't contain being chained up in some madman's dungeon for the rest of your life, being cruelly tortured. ...",
				"Do you really want to take the risk upon yourself?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Are you absolutely sure?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif npcHandler:getTopic(playerId) == 4 then
			npcHandler:say("Honestly?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		elseif npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("This is your last chance - do you really want to do this?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say("Well .. I guess then it is time for us to depart, right?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("I really hope I won't regret what you are doing here. Uhm, I mean I hope that we will not regret what we are doing, of course. We had better talk about your future mission when we arrive. So .. shall we really depart?", npc, creature)
			npcHandler:setTopic(playerId, 8)
		elseif npcHandler:getTopic(playerId) == 8 then
			npcHandler:say("So be it!", npc, creature)
			player:setStorageValue(TheIsleOfEvil.Mission06, 2)
			player:setStorageValue(TheIsleOfEvil.Questline, 13)
			player:teleportTo(ISLE_DESTINATION)
			ISLE_DESTINATION:sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 9 then
			player:teleportTo(ISLE_DESTINATION)
			ISLE_DESTINATION:sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end

	if MsgContains(message, "no") and npcHandler:getTopic(playerId) >= 1 then
		npcHandler:say("Very well. Come find me again when you are ready.", npc, creature)
		npcHandler:setTopic(playerId, 0)
		return true
	end

	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, "Psht! Not that loud! Evil lurks everywhere.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Recommend us if you were satisfied with our service.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
