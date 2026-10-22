local internalNpcName = "Kesar the Younger"
local npcType = Game.createNpcType("Kesar the Younger (Day)")
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1317,
	lookHead = 38,
	lookBody = 76,
	lookLegs = 57,
	lookFeet = 114,
	lookAddons = 2,
}

npcConfig.respawnType = {
	period = RESPAWNPERIOD_DAY,
	underground = false,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {}

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

local TEN_MINUTES = 10 * 60
local ONE_TIBIAN_DAY = 60 * 60
local TWENTY_HOURS = 20 * 60 * 60

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	-- The Order of the Stag (W: Transcripts "Etzel Writ" and "Isle of Ada"; Optional 3: King's Council)
	if OrderOfTheStag.lionDone(player) then
		local stagStage = OrderOfTheStag.getStage(player)
		local Stage = OrderOfTheStag.Stage

		if MsgContains(message, "problem") and stagStage < Stage.WRIT then
			npcHandler:say({
				"I have sent a party of my best men on a mission to a certain island to... investigate a royal matter. However, they have yet to send news from their quest. ...",
				"Hero of {Bounac} and royal advisor of the court, I am in need of your {help} once again.",
			}, npc, creature)
			return true
		end

		if MsgContains(message, "banner") then
			npcHandler:say("Strong, resilient and completely trustworthy. Currently out on an expedition, it's been a while, actually...", npc, creature)
			return true
		end

		if MsgContains(message, "help") then
			if stagStage < Stage.WRIT then
				OrderOfTheStag.setStage(player, Stage.WRIT)
				npcHandler:say({
					"My knights embarked on the Emmanuelle, our flagship. They were to set sail for the Isle of Ada to retrieve word from an old order of... knights, residing there. ...",
					"There is, however, another twist to this tale, I fear I cannot keep from you. A long kept Bounacean secret is about to be lifted, all in due time. ...",
					"There is a room below the cathedral that was once the stage for quite the spectacle. By decree a guard was to be garrisoned there at all times, day as well as night, an armed magic wielder. ...",
					"The room was locked from the inside and there was no other direct access. All of this to protect a single chest. Its... precarious content was subject of several attacks, in hope to destabilise the then still struggling Bounaceans and their leader. ...",
					"During one of these attacks, a hired magician found a way to enter the room. The warlock down there managed to subdue the perpetrator but had to seal the room... and ultimately himself from the inside. ...",
					"The shift was never changed again, the room was kept unbreached until this day. The chest houses a writ that was quite important for Kesar Etzel, my ancestor. And it still is to the Etzels, in this case: me. ...",
					"I will not tell you what is written there but I want you to retrieve it and bring it to me. You will have to find a way from the sacred halls directly above it.",
				}, npc, creature)
				return true
			end

			if stagStage == Stage.WRIT then
				-- NOT CONFIRMED: reminder while the writ has not been brought
				npcHandler:say("The writ is still sealed below the cathedral. Find a way down from the sacred halls directly above it.", npc, creature)
				return true
			end

			if stagStage == Stage.CERTIFICATE then
				npcHandler:say({
					"Now that you know our family secret, I want you to take the writ with you and show it to Captain {Banner}, leader of this expedition. ...",
					"The Isle of Ada is uncharted and difficult to reach. Either you have a very strong ship or a very nimble boat. ...",
					"Since the port of Bounac is still in quite the turmoil, find a boat to the south near the old fisherman's hut. Say no word to anyone besides the captain and make utmost haste. Are you prepared?",
				}, npc, creature)
				npcHandler:setTopic(playerId, 10)
				return true
			end

			if stagStage >= Stage.DONE then
				if player:getStorageValue(Storage.Quest.U15_20.TheOrderOfTheStag.KingsCouncil) < 1 then
					player:setStorageValue(Storage.Quest.U15_20.TheOrderOfTheStag.KingsCouncil, 1)
					player:addOutfitAddon(1436, 2)
					player:addOutfitAddon(1437, 2)
					if not player:hasAchievement("King's Council") then
						player:addAchievement("King's Council")
					end
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					-- NOT CONFIRMED: the Wiki only says that Kesar gives the achievement and addon 2
					npcHandler:say("You have done Bounac and the Etzels a service that will not be forgotten. From this day on, you have a permanent place at my council.", npc, creature)
				else
					npcHandler:say("Your place at my council is secure, advisor.", npc, creature)
				end
				return true
			end

			-- NOT CONFIRMED: reminder during the journey
			npcHandler:say("Find Captain Banner on the Isle of Ada, state the purpose of your mission, which is to support them as well as the Stags and bring word of the expedition.", npc, creature)
			return true
		end

		if message:lower() == "yes" and npcHandler:getTopic(playerId) == 10 then
			npcHandler:setTopic(playerId, 0)
			if stagStage == Stage.CERTIFICATE then
				OrderOfTheStag.setStage(player, Stage.TO_ADA)
				npcHandler:say("Then make it so. Find Captain Banner on the Isle of Ada, state the purpose of your mission, which is to support them as well as the Stags and bring word of the expedition.", npc, creature)
			end
			return true
		end
	end

	-- Without The Order of the Lion finished, Kesar does not talk about The Order of the Stag (W: requirement).
	-- Text NOT CONFIRMED (the Wiki has no transcript of the refusal); added so he does not stay silent.
	if not OrderOfTheStag.lionDone(player) and (MsgContains(message, "problem") or MsgContains(message, "help")) then
		npcHandler:say("Talk to me again once you have proven yourself to Bounac.", npc, creature)
		return true
	end

	if MsgContains(message, "siege") then
		local mission = player:getStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarMission)
		local timer = player:getStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarSiegeTimer)
		local now = os.time()

		if mission < 1 then
			player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarMission, 1)
			player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarSiegeTimer, now)
			npcHandler:say({
				"You will have to wait until I have time to take care of your request. In the meantime, take a seat. ...",
				"Usually they're reserved for my council but they never seem to sit down... and somehow I doubt you will, either.",
			}, npc, creature)
			return true
		end

		if mission == 1 then
			if (now - timer) >= TEN_MINUTES then
				npcHandler:say({
					"So, I trust you're not here to join the usurpers besieging our humble enclave. Otherwise my men would've surely put you in your place before you even passed the gate. ...",
					"Sources are telling me that you helped our small community quite a bit. And you seem to know your way around the usurpers. ...",
					"I will trust you, as I trust my men who already put faith in you. What do you say, are you interested in a plan?",
				}, npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("I am still quite occupied, traveller. Please be patient and give me some time.", npc, creature)
			end
			return true
		end

		if mission == 2 then
			local lastSpawn = player:getStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.FugueSpawnTime)
			local fugueSpawned = player:getStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.FugueSpawned)

			if (now - timer) < ONE_TIBIAN_DAY then
				npcHandler:say("I am still preparing. Give it some more time, traveller.", npc, creature)
				return true
			end

			if fugueSpawned == 1 and lastSpawn > 0 and (now - lastSpawn) >= TWENTY_HOURS then
				player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.FugueSpawned, 0)
				npcHandler:say({
					"I expected them to show up last night but nothing happened. Perhaps they are waiting for the right moment. ...",
					"Return to my chambers when night falls and stay alert. They will come.",
				}, npc, creature)
			elseif fugueSpawned == 1 then
				npcHandler:say("I know they appeared last night. You need to deal with them - go back to my chambers when night comes.", npc, creature)
			else
				npcHandler:say("I am still preparing. Give it some more time, traveller.", npc, creature)
			end
			return true
		end

		if mission == 3 then
			local hasFalcon = player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.Access) >= 1
			local hasCobra = player:getStorageValue(Storage.Quest.U12_20.GraveDanger.CobraBastion.Access) >= 1

			if hasFalcon and hasCobra then
				npcHandler:say({
					"Fugue... he attacked right away and had to be punished. You did the right thing. However, this will probably mean all out war if Drume does not come to his senses. ...",
					"I will have to arrange a meeting with him immediately to prevent the worst from happening. There is still another way. ...",
					"Will you escort me to the camp of the usurpers?",
				}, npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say({
					"Last night I had an idea. It came to my mind that we must not stand alone against this onslaught. There are other knights. Other orders who may sympathise with our cause ...",
					"As you might already know, I am a direct descendant of Kesar, leader of the knightly order of the Lion. ...",
					"He was one of three knights who once served King Xenom and left Edron in search of a greater purpose. ...",
					"Travel to the city of Edron and find out what you can about the order of the Falcon. ...",
					"And there is another order, I am not quite sure of its name but they travelled far south of Edron, into the desert.",
				}, npc, creature)
			end
			return true
		end

		if mission == 4 then
			npcHandler:say({
				"What news from the orders of the Falcon and the other successor order? ...",
				"The Order of the Cobra you say? Both destroyed...? The flame of virtue, the power of righteousness - diminished? In all of them? Oh... ...",
				"Far too long have I stayed silent and idle. Drume wants war. We will meet him in battle near the eastern coast of Bounac. ...",
				"Prepare yourself and I will see you on the battlefield. Good luck, my friend.",
			}, npc, creature)
			return true
		end

		if mission >= 5 then
			npcHandler:say({
				"It is done. Drume's forces lie broken on the battlefield. You witnessed the fall of a great enemy of the Order of the Lion. ...",
				"You stood tall against the enemy forces and helped our cause wherever you could. ...",
				"I will therefore announce you the 'Hero of Bounac'. You are an honourable citizen of this town now. ...",
				"Feel free to roam Bounac as you please. This also means certain benefits when trading with our court trader Augustin. ...",
				"Whenever you're here for a visit, the large house to the south of Bounac is now completely at your disposal. ...",
				"And if we can persuade you into a longer stay perhaps, there is a small house further to the south of the island which may pique your interest. ...",
				"Thank you for your service to Bounac, Hero.",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.AugustinDoor, 1)
			if not player:hasAchievement("Lionheart") then
				player:addAchievement("Lionheart")
			end
			return true
		end
	end

	if message:lower() == "yes" then
		local mission = player:getStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarMission)

		if npcHandler:getTopic(playerId) == 1 and mission == 1 then
			player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarMission, 2)
			player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarSiegeTimer, os.time())
			npcHandler:say({
				"Excellent. Here is my plan. Either Fugue, Drume or both will appear here soon. If they try anything funny - defend yourself. ...",
				"If we can get them both at the right moment, they're done for. They will pay for what they have done. ...",
				"However, if only one of them appears and one of them is left... well, we shall not think of that now.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end

		if npcHandler:getTopic(playerId) == 2 and mission == 3 then
			player:setStorageValue(Storage.Quest.U12_40.TheOrderOfTheLion.KesarMission, 4)
			npcHandler:say({
				"Good, however, we have to wait until the recent skirmishes along the coast have settled down. ...",
				"We will venture down to the battlefield as soon as the other fights have died down.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Hail, traveller. What brings you here during these dire times under {siege}? The fair Bounac is suffering greatly.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
