local internalNpcName = "Rapanaio"
local npcType = Game.createNpcType("Rapanaio (Isle of Evil)")
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
	{ text = "Passage to {Kazordoon}." },
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

-- Travel
local function addTravelKeyword(keyword, cost, destination, action)
	local travelKeyword = keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = "Do you seek a passage to " .. keyword:titleCase() .. " for |TRAVELCOST|?", cost = cost, discount = "postman" })
	travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = cost, discount = "postman", destination = destination }, nil, action)
	travelKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "We would like to serve you some time.", reset = true })
end

addTravelKeyword("kazordoon", 0, Position(32700, 31990, 15))
-- Basic
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Rapanaio from the Royal Tibia Line." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the captain of this sailing-ship." })

-- The Isle of Evil Quest
local KV_SCOPE = "the-isle-of-evil"
local TheIsleOfEvil = Storage.Quest.U8_5.TheIsleOfEvil
local BACK_POSITION = Position(32700, 31990, 15)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(TheIsleOfEvil.Questline) == 13 then
			npcHandler:say("Now that we have arrived you should waste no time and fight your way to the lair of evil and destroy its master before it's too late!", npc, creature)
			player:setStorageValue(TheIsleOfEvil.Mission07, 1)
			player:setStorageValue(TheIsleOfEvil.Questline, 14)
			player:kv():scoped(KV_SCOPE):set("rapanaio-travel", true)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(TheIsleOfEvil.Questline) == 14 and player:getStorageValue(TheIsleOfEvil.Mission07) == 1 then
			npcHandler:say("You haven't finished destroying the evil master yet. Come back when you're done.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(TheIsleOfEvil.Questline) == 14 and player:getStorageValue(TheIsleOfEvil.Mission07) == 2 then
			npcHandler:say({
				"You made it?! Uhm, I mean of course you did! We did it! We have slain the master of all evil! The world will be a happier place from now on, thanks to our efforts. ...",
				"Concerning this membership card you have found, I think you should take it to King Tibianus, perhaps you will get a reward! Well, nothing stopping us going {back}, now, eh?",
			}, npc, creature)
			player:setStorageValue(TheIsleOfEvil.Mission07, 3)
			player:setStorageValue(TheIsleOfEvil.Questline, 15)
			npcHandler:setTopic(playerId, 1)
		end
		return true
	end

	if MsgContains(message, "back") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Time to leave this unfriendly place, eh? So are you ready to depart?", npc, creature)
		npcHandler:setTopic(playerId, 2)
		return true
	end

	if MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say("I thought you were going to stay here forever. Let's go.", npc, creature)
		player:teleportTo(BACK_POSITION)
		BACK_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
		npcHandler:setTopic(playerId, 0)
		return true
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, "Psht! Not that loud! Evil lurks everywhere.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Recommend us if you were satisfied with our service.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
