local internalNpcName = "Anna"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1576,
	lookHead = 114,
	lookBody = 71,
	lookLegs = 71,
	lookFeet = 66,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.light = {
	level = 0,
	color = 0,
}

npcConfig.voices = {
	interval = 10000,
	chance = 50,
	{ text = "Ready for a passage to Targuna?" },
	{ text = "No fear! This ferry will take you safely to the island of Targuna." },
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

local TARGUNA_DESTINATION = Position(31938, 31928, 7)
local MIN_LEVEL_TO_TRAVEL = 8

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	if not player then
		return true
	end

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local playerId = player:getId()

	if MsgContains(message, "passage") then
		if player:getLevel() < MIN_LEVEL_TO_TRAVEL then
			npcHandler:say("You need to be at least level " .. MIN_LEVEL_TO_TRAVEL .. " to travel to Targuna. Keep training!", npc, creature)
			return true
		end

		npcHandler:say("I'm offering a ferry service to the island {Targuna}, are you interested?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "yes") then
		if player:getLevel() < MIN_LEVEL_TO_TRAVEL then
			npcHandler:say("You need to be at least level " .. MIN_LEVEL_TO_TRAVEL .. " to travel.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end

		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Very well, I'll take you to Targuna then. The locals there could use a helping hand!", npc, creature)
			player:teleportTo(TARGUNA_DESTINATION)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:setTopic(playerId, 0)

			player:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, -1)
			player:setStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting, -1)
			player:setStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor, -1)

			player:setTown(Town(TOWNS_LIST.TARGUNA))
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) >= 1 then
			npcHandler:say("No problem. Come back when you're ready to explore Targuna!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

-- Keywords about NPCs
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My full {name} is Anna Maria Mauricia, but you may call me just Anna." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm offering a ferry service to the island of {Targuna}." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "Targuna is a beautiful island where adventurers are always welcome. Ask me for a {passage} if you're interested." })
keywordHandler:addKeyword({ "mainland" }, StdModule.say, { npcHandler = npcHandler, text = "You chose a peaceful world. Not much danger from other adventurers. Just beware the monsters. Ask me for a passage if you're interested." })
keywordHandler:addKeyword({ "blue valley" }, StdModule.say, { npcHandler = npcHandler, text = "The {Blue Valley} is the heart of the {Merudri} culture, or what is left of it." })
keywordHandler:addKeyword({ "merudri" }, StdModule.say, { npcHandler = npcHandler, text = "The {Merudri} are warrior monks. Honing serenity, preserving their legacy, defending the {Blue Valley} and beyond." })
keywordHandler:addKeyword({ "newhaven" }, StdModule.say, { npcHandler = npcHandler, text = "Back when the mines were still full of ores, our island used to be a much busier place. Workers, suppliers and travelers from all over Tibia began visiting our small village." })
keywordHandler:addKeyword({ "island" }, StdModule.say, { npcHandler = npcHandler, text = "Back when the mines were still full of ores, our island used to be a much busier place. Workers, suppliers and travelers from all over Tibia began visiting our small village." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "{Thais} is actually the oldest city in Tibia. But be careful on those streets, there are bandits everywhere. ? It might be better if I take you to the {Thais Peninsula}. Ask me for a passage if you're interested." })
keywordHandler:addKeyword({ "peninsila" }, StdModule.say, { npcHandler = npcHandler, text = "The {Thais Peninsula} is highly recommendable for unexperienced and first-time adventurers, it's not far from the city {Thais}, too. I can take you there if you like. Ask me for a passage if you're interested." })
keywordHandler:addKeyword({ "avriel" }, StdModule.say, { npcHandler = npcHandler, text = "{Avriel} runs a small shop here in the village. You can buy useful things there, but you can also sell things you no longer need. You will find his shop right south of the ferry house." })
keywordHandler:addKeyword({ "flavius" }, StdModule.say, { npcHandler = npcHandler, text = "He runs the small bank in this village. You can find him over there in the house." })
keywordHandler:addKeyword({ "gustavo" }, StdModule.say, { npcHandler = npcHandler, text = "He is a capable fighter and keeps our village safe from the Muglex Clan goblins." })
keywordHandler:addKeyword({ "viola" }, StdModule.say, { npcHandler = npcHandler, text = "{Viola} is a good friend of mine and knows a thing or two about magic. Maybe she can teach you a few spells." })
keywordHandler:addKeyword({ "tim" }, StdModule.say, { npcHandler = npcHandler, text = "He is a friend of our guard {Gustavo} but he lives in the capital {Thais}." })
keywordHandler:addKeyword({ "ben" }, StdModule.say, { npcHandler = npcHandler, text = "Hmm, no one in the village has that {name}. Oh wait... {Gustavo} mentioned it once." })

npcHandler:setMessage(MESSAGE_GREET, "Hello, my friend. Do you seek {passage} to the island {Targuna}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Fair winds, |PLAYERNAME|! Safe travels!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Take care!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

npcType:register(npcConfig)
