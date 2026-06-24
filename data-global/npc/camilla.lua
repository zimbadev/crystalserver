local internalNpcName = "Camilla"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Camilla: outfit 1385 (mayor).
npcConfig.outfit = {
	lookType = 1385,
	lookHead = 78,
	lookBody = 94,
	lookLegs = 67,
	lookFeet = 79,
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
local CAMILLA_REWARD = Storage.Quest.U15_24.Targuna.AncientEnemy.CamillaReward

local CAMILLA_EXP_REWARD = 1500

-- Dialog topics
local TOPIC_REWARD_CONFIRM = 1

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(CAMILLA_REWARD) == 1 then
			npcHandler:say("Thank you again for ending the threat of those ancient lizards. Targuna is safe thanks to you.", npc, creature)
			return true
		end

		if player:getStorageValue(LIZARD_COMMANDER_KILLED) ~= 1 then
			npcHandler:say("What mission? I didn't order any mission here.", npc, creature)
			return true
		end

		npcHandler:say({
			"What mission? The hidden temple?! Ohh my, they were hiding inside the temple ruins on Targuna? How many you say?! How could we be so blind ...",
			"Now tell me, did you put an end to their commander?",
		}, npc, creature)
		npcHandler:setTopic(playerId, TOPIC_REWARD_CONFIRM)
		return true
	end

	if MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == TOPIC_REWARD_CONFIRM then
			if player:getStorageValue(CAMILLA_REWARD) == 1 then
				npcHandler:say("You have already received my gratitude, my friend.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end
			npcHandler:say({
				"Ohh ... Wow, these lizards ... I'm glad you could put an end to it, I don't want to think about what could've happened if this problem had gone under our radar.",
				"Thank you! There's a gift as a sign of gratitude for all you've done. I'm sure you'll find some interesting things in Aurelia's shop.",
			}, npc, creature)
			player:addExperience(CAMILLA_EXP_REWARD, true)
			player:setStorageValue(CAMILLA_REWARD, 1)
			player:setStorageValue(ANCIENT_ENEMY_MISSION, 4)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	if MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == TOPIC_REWARD_CONFIRM then
			npcHandler:say("Then make sure to deal with that commander deep inside the temple. We can't take any risks.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end

	return true
end

-- Keywords / lore
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Camilla." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the {mayor} of this isle." })
keywordHandler:addKeyword({ "mayor" }, StdModule.say, { npcHandler = npcHandler, text = "Well, mayor is perhaps a bit of an exaggeration. Targuna is very small, after all. Nevertheless, I take care of important matters, represent the village in Thais if necessary, and try to ensure that everyone here is doing well and that there are no disputes." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is our capital city, on the main continent. Captain Indigo offers a passage, if you want to go there. You can find her on her ship east of here." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "This is our small island here, our safe haven. Not many things of interest here for an adventurer, I assume." })
keywordHandler:addKeyword({ "isle" }, StdModule.say, { npcHandler = npcHandler, text = "We call our small island Targuna." })
keywordHandler:addKeyword({ "king", "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Tibianus III is our king. He resides in the capital Thais." })
keywordHandler:addKeyword({ "sell", "buy" }, StdModule.say, { npcHandler = npcHandler, text = "You should visit Aurelia's shop if you wish to sell or buy something." })
keywordHandler:addKeyword({ "lizzie" }, StdModule.say, { npcHandler = npcHandler, text = "Lizzie does important research on the dangers around Targuna. You'll find her to the south-west." })
keywordHandler:addKeyword({ "aurelia" }, StdModule.say, { npcHandler = npcHandler, text = "Aurelia runs a fine shop. I'm sure you'll find some interesting things there." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings my friend!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
