local internalNpcName = "Lizzie"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Lizzie: Retro Summoner outfit (female = 965), no addons.
-- TODO(colors): confirm head/body/legs/feet via the palette/StaticDataEditor.
npcConfig.outfit = {
	lookType = 965,
	lookHead = 40,
	lookBody = 23,
	lookLegs = 38,
	lookFeet = 39,
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

-- Quest storage keys (An Ancient Enemy)
local ANCIENT_ENEMY_MISSION = Storage.Quest.U15_24.Targuna.AncientEnemy.Mission
local LIZARD_COMMANDER_KILLED = Storage.Quest.U15_24.Targuna.AncientEnemy.LizardCommanderKilled
local TARGUNA_QUESTLINE = Storage.Quest.U15_24.Targuna.Questline

-- Dialog topics
local TOPIC_START_CONFIRM = 1

-- Mission storage values: 1 = informed by the arrival hint (not yet talked to Lizzie),
-- 2 = accepted and hunting the Lizard Commander, 3 = reported back (completed).
local function greetCallback(npc, creature)
	local player = Player(creature)
	if player:getStorageValue(ANCIENT_ENEMY_MISSION) < 2 then
		npcHandler:setMessage(MESSAGE_GREET, "Hey there. I need your help urgently, we have to {save} Targuna!")
	else
		npcHandler:setMessage(MESSAGE_GREET, "There you are! How's our {mission} doing?")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local mission = player:getStorageValue(ANCIENT_ENEMY_MISSION)

	-- Report progress (after the quest has started): "mission"
	if mission >= 2 and MsgContains(message, "mission") then
		if mission >= 3 then
			npcHandler:say("Thank you again for putting an end to that ancient lizard clan. Make sure to visit {Camilla} at her office, and talk to {Sterling} and {Emiliana} if you're in for more trouble.", npc, creature)
			return true
		end

		if player:getStorageValue(LIZARD_COMMANDER_KILLED) == 1 then
			npcHandler:say({
				"Thank you for finally putting an end to this ancient lizard clan hidden inside the temple here on Targuna.",
				"Make sure to visit Camilla at her office, if you haven't already. And if you're in for more trouble then I'd suggest talking to Sterling and Emiliana.",
			}, npc, creature)
			player:setStorageValue(ANCIENT_ENEMY_MISSION, 3)
			return true
		end

		npcHandler:say("The lizards still lurk inside the temple. Find and defeat their {Lizard Commander} deep within, then come back to me!", npc, creature)
		return true
	end

	-- Start the quest: save / lizards / mission
	if MsgContains(message, "save") or MsgContains(message, "lizard") or MsgContains(message, "mission") then
		if mission >= 2 then
			npcHandler:say("We've already started, the lizards won't wait for us! Tell me about our {mission}.", npc, creature)
			return true
		end
		npcHandler:say({
			"Finally! I need your help here adventurer.",
			"My research suggests there is an ancient lizard group, which poses a real threat to us here on Targuna. We need to put a stop to that NOW! Are you ready?",
		}, npc, creature)
		npcHandler:setTopic(playerId, TOPIC_START_CONFIRM)
		return true
	end

	-- Confirm start
	if MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == TOPIC_START_CONFIRM then
			npcHandler:say({
				"I finally found someone to help me, seriously thank you!",
				"Though we must start now, the lizards won't wait for us! I've marked the temple entrance on your map.",
			}, npc, creature)
			player:setStorageValue(ANCIENT_ENEMY_MISSION, 2)
			if player:getStorageValue(TARGUNA_QUESTLINE) < 1 then
				player:setStorageValue(TARGUNA_QUESTLINE, 1)
			end
			-- Mark the Hidden Lizard Temple entrance (north stairs) on the player's map.
			player:addMapMark(Position(31936, 31862, 7), MAPMARK_REDSOUTH, "Hidden Lizard Temple")
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	if MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == TOPIC_START_CONFIRM then
			npcHandler:say("Please come back when your interests might have changed for the better.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	return true
end

-- Keywords / lore
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "It's Lizzie, with double z." })
keywordHandler:addKeyword({ "lizzie" }, StdModule.say, { npcHandler = npcHandler, text = "That's the name, I bet you are here for the lizards." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Well, short and simple - I research many types of lizards." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "What a beautiful place it has become over the years. Especially after we constructed more buildings and opened more stores and offices, in order to make sure that every visitor has their need fulfilled." })
keywordHandler:addKeyword({ "indigo" }, StdModule.say, { npcHandler = npcHandler, text = "She's done quite the traveling to get here, if I remember correctly she started her journey somewhere in Ankrahmun, had to deal with something in Svargrond and ended up here on Targuna. What a journey!" })
keywordHandler:addKeyword({ "captain" }, StdModule.say, { npcHandler = npcHandler, text = "The boat on the south side of this island can bring you to Thais and back to Targuna. You should talk to the Captain whenever you're ready for the Tibian Mainland." })
keywordHandler:addKeyword({ "travel" }, StdModule.say, { npcHandler = npcHandler, text = "We have a few main travel options here, you can travel with Captain Indigo to Thais or use the turtle to travel to Aragonia. Though I keep forgetting the turtle's name ... What was it again, arrg!" })
keywordHandler:addKeyword({ "turtle" }, StdModule.say, { npcHandler = npcHandler, text = "What turtle? I do research on lizards." })
keywordHandler:addKeyword({ "aragonia" }, StdModule.say, { npcHandler = npcHandler, text = "That pirate island?! I wouldn't want to mess with them, no thank you!" })
keywordHandler:addKeyword({ "pirate", "pirates" }, StdModule.say, { npcHandler = npcHandler, text = "Nothing in this world will bring me close to any of these dangerous pirates on Aragonia. But if we're talking about Sterling, well then I have another opinion ..." })
keywordHandler:addKeyword({ "sterling" }, StdModule.say, { npcHandler = npcHandler, text = "He's great, I always enjoyed the after hours while fishing on the beach in the south. You can really talk about a lot with him, he's always open for adventures." })
keywordHandler:addKeyword({ "adrian" }, StdModule.say, { npcHandler = npcHandler, text = "At the bank you can deposit your well earned money, withdraw from your already existing fortune and even make transactions for other things in the tibian world." })
keywordHandler:addKeyword({ "bank" }, StdModule.say, { npcHandler = npcHandler, text = "Adrian has been doing all of our finances for quite some time now. The bank can be found right next to us, you can spot it easily with the sign next to it." })
keywordHandler:addKeyword({ "aurelia" }, StdModule.say, { npcHandler = npcHandler, text = "Aurelia is taking care of all supplies that come in on a regular basis from Thais. She sells these in her shop south of the depot." })
keywordHandler:addKeyword({ "shop" }, StdModule.say, { npcHandler = npcHandler, text = "The shop is right here, you can resupply and freshen up before heading into battle, Aurelia will take care of all these needs." })
keywordHandler:addKeyword({ "camilla" }, StdModule.say, { npcHandler = npcHandler, text = "Our mayor Camilla can be found in the upper levels of the depot. Once you're done with my mission you can make a report on my research and your findings." })
keywordHandler:addKeyword({ "mayor" }, StdModule.say, { npcHandler = npcHandler, text = "The mayor was elected unanimously, Camilla does such a great job of representing our island and us as citizens." })
keywordHandler:addKeyword({ "emiliana" }, StdModule.say, { npcHandler = npcHandler, text = "Isn't she the imbuement expert?! I heard she made quite the fortune with that and then settled down here on Targuna. I bet she has a lot to tell." })
keywordHandler:addKeyword({ "leonora" }, StdModule.say, { npcHandler = npcHandler, text = "Leonora runs the post office here in Targuna. Everything related to parcels and letters can be done in the post office." })
keywordHandler:addKeyword({ "post office", "post" }, StdModule.say, { npcHandler = npcHandler, text = "If there's ever a need to send a letter or a parcel, Leonora has you covered. Her office is in the northern part of the island." })
keywordHandler:addKeyword({ "morla" }, StdModule.say, { npcHandler = npcHandler, text = "Who? I don't know anybody of that name ..." })

npcHandler:setMessage(MESSAGE_GREET, "Hey there. I need your help urgently, we have to {save} Targuna!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye!")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
