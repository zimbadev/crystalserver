local internalNpcName = "Emiliana"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Emiliana: Sun Priest outfit (female = 1024) with addon 1.
-- TODO(colors): confirm head/body/legs/feet via the palette/StaticDataEditor.
npcConfig.outfit = {
	lookType = 1024,
	lookHead = 59,
	lookBody = 28,
	lookLegs = 19,
	lookFeet = 28,
	lookAddons = 1,
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

-- Quest storage keys (Burning Heart)
local BURNING_HEART_MISSION = Storage.Quest.U15_24.Targuna.BurningHeart.Mission
local HERALD_KILLED = Storage.Quest.U15_24.Targuna.BurningHeart.HeraldKilled
local TURNIPS_REWARD = Storage.Quest.U15_24.Targuna.BurningHeart.TurnipsReward
local TARGUNA_QUESTLINE = Storage.Quest.U15_24.Targuna.Questline

local HERALD_EXP_REWARD = 5000
local TURNIPS_REBUY_COST = 1000
local MIN_LEVEL_TO_HELP = 12

local BUNCH_OF_TURNIPS_ID = 53073

-- Dialog topics
local TOPIC_START_CONFIRM = 1
local TOPIC_REWARD_CONFIRM = 2
local TOPIC_LOSE_CONFIRM = 3

-- Emiliana exists in two places: Targuna (recruiter, surface) and Crimson Court (z 12).
local function isInTarguna(npc)
	return npc:getPosition().z <= 7
end

-- There are two Emiliana NPCs; the Crimson Court mission progress may only be
-- handled while the player is actually inside that NPC's designated area.
local CRIMSON_COURT_EMILIANA_FROM = Position(32409, 32683, 12)
local CRIMSON_COURT_EMILIANA_TO = Position(32420, 32693, 12)

local function isInCrimsonCourtArea(position)
	return position.x >= CRIMSON_COURT_EMILIANA_FROM.x and position.x <= CRIMSON_COURT_EMILIANA_TO.x and position.y >= CRIMSON_COURT_EMILIANA_FROM.y and position.y <= CRIMSON_COURT_EMILIANA_TO.y and position.z == CRIMSON_COURT_EMILIANA_FROM.z
end

local function greetCallback(npc, creature)
	local player = Player(creature)
	if isInTarguna(npc) then
		if player:getStorageValue(TURNIPS_REWARD) == 1 or player:getStorageValue(BURNING_HEART_MISSION) >= 4 then
			npcHandler:setMessage(MESSAGE_GREET, "Well well well, if that isn't the glorious |PLAYERNAME|!")
		elseif player:getStorageValue(HERALD_KILLED) == 1 then
			npcHandler:setMessage(MESSAGE_GREET, "Hello there traveller. What brings you here today?")
		else
			npcHandler:setMessage(MESSAGE_GREET, "Hey, I really need your {help} on an important mission urgently.")
		end
	else
		if player:getStorageValue(HERALD_KILLED) == 1 then
			npcHandler:setMessage(MESSAGE_GREET, "Hey adventurer |PLAYERNAME|! Is it just me or has it gotten hotter in here, anyways ... Tell me about your {mission}.")
		else
			npcHandler:setMessage(MESSAGE_GREET, "Great that you're here, we need to move quickly!")
		end
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local mission = player:getStorageValue(BURNING_HEART_MISSION)

	-- ===== Targuna (recruiter) =====
	if isInTarguna(npc) then
		if MsgContains(message, "help") or MsgContains(message, "mission") then
			if player:getStorageValue(TURNIPS_REWARD) == 1 then
				npcHandler:say("Thank you again for your help, adventurer. Take good care of that ram of yours!", npc, creature)
				return true
			end
			-- Boss defeated: hand over the reward here on Targuna.
			if player:getStorageValue(HERALD_KILLED) == 1 then
				npcHandler:say({
					"I can feel it already, the Herald has been defeated by your very own hands.",
					"I can't tell you how happy I am that my wicked portal won't be the beginning of a tragedy. Here this is for you, take it as a sign of gratitude for your hard work. Would you like to have it now?",
				}, npc, creature)
				npcHandler:setTopic(playerId, TOPIC_REWARD_CONFIRM)
				return true
			end
			if mission >= 1 then
				npcHandler:say("Go upstairs, open the door and walk through the portal. I'll be waiting for you on the other side.", npc, creature)
				return true
			end
			if player:getLevel() < MIN_LEVEL_TO_HELP then
				-- TODO(message): replace with the official low-level rejection message
				npcHandler:say("I respect your interest, but you're not strong enough yet for this challenge. Please come back when you're stronger.", npc, creature)
				return true
			end
			npcHandler:say("Ah yes, finally someone's ready for a real challenge. Are you willing to help me defeat the yet unknown danger inside the portal upstairs?", npc, creature)
			npcHandler:setTopic(playerId, TOPIC_START_CONFIRM)
			return true
		end

		-- Rebuy Bunch of Turnips
		if MsgContains(message, "lose") then
			if player:getStorageValue(TURNIPS_REWARD) ~= 1 then
				npcHandler:say("You haven't earned your reward yet, there's nothing for me to replace.", npc, creature)
				return true
			end
			npcHandler:say("Did you lose your Bunch of Turnips? I can get you another one for " .. TURNIPS_REBUY_COST .. " gold coins. Would you like that?", npc, creature)
			npcHandler:setTopic(playerId, TOPIC_LOSE_CONFIRM)
			return true
		end

		if MsgContains(message, "yes") then
			local topic = npcHandler:getTopic(playerId)
			if topic == TOPIC_START_CONFIRM then
				npcHandler:say("Great! Here's what I need you to do: Go upstairs, open the door and walk through the portal. I will hand you more information once we're inside.", npc, creature)
				player:setStorageValue(BURNING_HEART_MISSION, 1)
				if player:getStorageValue(TARGUNA_QUESTLINE) < 1 then
					player:setStorageValue(TARGUNA_QUESTLINE, 1)
				end
				npcHandler:setTopic(playerId, 0)
				return true
			elseif topic == TOPIC_REWARD_CONFIRM then
				npcHandler:setTopic(playerId, 0)
				if player:getStorageValue(TURNIPS_REWARD) == 1 then
					npcHandler:say("You've already received my gratitude, adventurer.", npc, creature)
					return true
				end
				npcHandler:say({
					"Well there you go, let me gift you this as a form of my gratitude for your help. Maybe the lonely ram on Targuna wouldn't mind taking a bite or two ...",
					"Anyways, I'll see you around.",
				}, npc, creature)
				if BUNCH_OF_TURNIPS_ID > 0 then
					player:addItem(BUNCH_OF_TURNIPS_ID, 1)
				end
				player:addExperience(HERALD_EXP_REWARD, true)
				player:setStorageValue(TURNIPS_REWARD, 1)
				player:setStorageValue(BURNING_HEART_MISSION, 4)
				return true
			elseif topic == TOPIC_LOSE_CONFIRM then
				npcHandler:setTopic(playerId, 0)
				if BUNCH_OF_TURNIPS_ID <= 0 then
					npcHandler:say("My apologies, I can't seem to find one right now.", npc, creature)
					return true
				end
				if player:removeMoney(TURNIPS_REBUY_COST) then
					player:addItem(BUNCH_OF_TURNIPS_ID, 1)
					npcHandler:say("Here you go, take good care of it this time!", npc, creature)
				else
					npcHandler:say("You don't have enough gold.", npc, creature)
				end
				return true
			end
		end

		if MsgContains(message, "no") then
			npcHandler:say("Good bye!", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end

		return true
	end

	-- ===== Crimson Court =====
	if not isInCrimsonCourtArea(player:getPosition()) then
		return true
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(TURNIPS_REWARD) == 1 then
			npcHandler:say("Thank you again for ending the Herald's reign of terror. I'll see you around.", npc, creature)
			return true
		end

		if mission < 1 then
			npcHandler:say("How did you even get here? Speak to me back on Targuna first, we'll need to go through the portal together.", npc, creature)
			return true
		end

		if player:getStorageValue(HERALD_KILLED) == 1 then
			npcHandler:say("You've done it! Now hurry back to Targuna and speak to me there, I have something for you.", npc, creature)
			return true
		end

		if mission == 1 then
			npcHandler:say({
				"Right, so I gathered some information. We currently are at an upper level of the Crimson Court. Down below are at least two more areas, though I haven't scouted anything related to the Herald yet.",
				"Your task is to do exactly that, find out where the Herald resides and defeat him to end his reign of terror once and for all.",
			}, npc, creature)
			player:setStorageValue(BURNING_HEART_MISSION, 2)
			return true
		end

		-- mission == 2, Herald not yet defeated
		npcHandler:say("The Herald still resides somewhere below us. Find him and defeat him to end his reign of terror!", npc, creature)
		return true
	end

	return true
end

-- Keywords / lore
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Nice to meet you |PLAYERNAME|, the name's Emiliana." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I used to teach imbuing all around the tibian world, maybe someday you will meet up with Alibinius at Thais. Imbuement is such a powerful thing if done correctly." })
keywordHandler:addKeyword({ "imbuement", "imbuing" }, StdModule.say, { npcHandler = npcHandler, text = "Having the option to imbue astral power into your gear making it stronger, more potent and fitting for your style really can make a night and day difference. You should try it out for yourself someday as well." })
keywordHandler:addKeyword({ "targuna" }, StdModule.say, { npcHandler = npcHandler, text = "Such a pleasant little island, it's the perfect place to enjoy my peace and finally go after my hobbies again after travelling around Tibia for quite some time." })
keywordHandler:addKeyword({ "travel" }, StdModule.say, { npcHandler = npcHandler, text = "I'd say you got two options, one reasonable and another one not as much. You could even travel with Matilda to Aragonia and see what the pirates are up to ... or you could be sane and travel to Thais with Captain Indigo and get to see the beauty of the Tibian mainland, your choice I suppose ..." })
keywordHandler:addKeyword({ "matilda" }, StdModule.say, { npcHandler = npcHandler, text = "Isn't that his turtle? She once got me to Aragonia and back for free. I definitely wasn't the smoothest ride, but I won't complain for that price ..." })
keywordHandler:addKeyword({ "captain indigo" }, StdModule.say, { npcHandler = npcHandler, text = "Our beloved Captain Indigo is the only way to travel to mainland from here, therefore she is the only connection for other resources, supplies and things alike. You can find and sell supplies at Aurelia's shop just south of my home." })
keywordHandler:addKeyword({ "indigo" }, StdModule.say, { npcHandler = npcHandler, text = "She owns the boat on the east of Targuna, which can take you straight to Thais, whenever you so desire. I heard if you hand her a ticket you get your ride free of charge. I tell you, that's a deal!" })
keywordHandler:addKeyword({ "aurelia" }, StdModule.say, { npcHandler = npcHandler, text = "Aurelia has a little shop just south of me, so whenever you might need new supplies or want to sell some stuff, I'd suggest paying her a visit." })
keywordHandler:addKeyword({ "shop" }, StdModule.say, { npcHandler = npcHandler, text = "Selling and buying supplies is all taken care off by our dearest Aurelia. You can find her at the south east side of Targuna, basically right south of my house." })
keywordHandler:addKeyword({ "aragonia" }, StdModule.say, { npcHandler = npcHandler, text = "That pirate island, yeah. Not going to be there anytime soon and I'd advise you to do the same, if you still want to leave alive. Those pirates are more dangerous than they might seem." })
keywordHandler:addKeyword({ "pirate", "pirates" }, StdModule.say, { npcHandler = npcHandler, text = "Who? Sterling?! Well I'd say that's not a real pirate, though if you're talking about these pesky pirates on Aragonia, then wow these are definitely pirates to be scared of. I wouldn't want to be around them." })
keywordHandler:addKeyword({ "sterling" }, StdModule.say, { npcHandler = npcHandler, text = "He's not a real pirate honestly, I think part-time seems more fitting here, nevertheless he's a nice pirate to have around. If you ever feel the need to travel to Aragonia, you should talk to him about it." })
keywordHandler:addKeyword({ "camilla" }, StdModule.say, { npcHandler = npcHandler, text = "Our precious mayor Camilla takes care of every official request and everything representative in and around Targuna. She's rather new here, though we couldn't be better off with anyone else." })
keywordHandler:addKeyword({ "mayor" }, StdModule.say, { npcHandler = npcHandler, text = "The mayor of Targuna has historically been residing in the upper floors and room of the depot in the middle of the Island, so if there's ever a need to visit Camilla at her office, you'll know exactly where to look." })
keywordHandler:addKeyword({ "adrian" }, StdModule.say, { npcHandler = npcHandler, text = "Having Adrian as our financial advisor and helper here is surely nothing short of a blessing, so whenever you find yourself having little fortune in your pockets, pay him a visit and make sure you deposit it." })
keywordHandler:addKeyword({ "leonora" }, StdModule.say, { npcHandler = npcHandler, text = "Everybody has to use the post office and so do we here on Targuna. Leonora takes care of all the work, by making it able to send and receive parcels, letters and many other things." })
keywordHandler:addKeyword({ "post office", "post" }, StdModule.say, { npcHandler = npcHandler, text = "Leonora is responsible for all our parcel and letter service here on Targuna, you can find her at her office just north of us." })
keywordHandler:addKeyword({ "lizzie" }, StdModule.say, { npcHandler = npcHandler, text = "She told me about her research on ancient lizard groups ... May sound interesting at first, but I wouldn't want to hear that again, I'll tell you that!" })
keywordHandler:addKeyword({ "lizard", "lizards" }, StdModule.say, { npcHandler = npcHandler, text = "We once had a lizard problem at the north of the island, but I think it has been there for quite some time now ... Maybe you could ask Lizzie about it, she's been researching them for some time now." })
keywordHandler:addKeyword({ "morla" }, StdModule.say, { npcHandler = npcHandler, text = "She's the cute turtle that Sterling once saved from a storm at Aragonia. Before these pirates took over it used to be paradise. If you're interested in turtles, you nearly have to pay her a visit." })
-- Quest hints (Burning Heart)
keywordHandler:addKeyword({ "portal" }, StdModule.say, { npcHandler = npcHandler, text = "My portal leads to the Crimson Court. Go upstairs, open the door and walk through it." })
keywordHandler:addKeyword({ "herald" }, StdModule.say, { npcHandler = npcHandler, text = "The Herald of Fire resides somewhere in the depths of the Crimson Court. He must be stopped." })
keywordHandler:addKeyword({ "crimson court" }, StdModule.say, { npcHandler = npcHandler, text = "An ancient and dangerous place, reachable only through my portal." })
keywordHandler:addKeyword({ "ram" }, StdModule.say, { npcHandler = npcHandler, text = "There's a lonely ram on Targuna. Maybe it wouldn't mind a bite of turnips ..." })

npcHandler:setMessage(MESSAGE_GREET, "Hey, I really need your {help} on an important mission urgently.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye!")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
