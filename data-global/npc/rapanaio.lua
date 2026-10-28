local internalNpcName = "Rapanaio"
local npcType = Game.createNpcType(internalNpcName)
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

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me humble name is Rapanaio. Good old goblin name meaning honest, generous and nice person, I swear!" })

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	local S = Storage.Quest.U8_5.TheIsleOfEvil

	if MsgContains(message, "mission") then
		if player:getStorageValue(S.Questline) < 1 then
			npcHandler:say("Mission you say? Well MY mission is to fight evil with every power at my disposal! Hm, perhaps you have it in you to join the {fight}.", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(S.Questline) == 1 then
			npcHandler:say({
				"They say there's a positive side to everything! And in this case it is perfectly true! In order for you to reach the Isle of Evil and slay its unspeakable horrors we will first finish my latest invention! ...",
				"As you might have guessed I am a highly talented inventor. Still, even inventors sometimes need some kind of .. inspiration. I can't tell you too much about your next mission since our enemies might capture and torture you for information. ...",
				"I optimized my invention by studying fish. Suffice it to say, I need one further specimen to study to put the finishing touches on my machine. ...",
				"I am afraid I need a specific fish, of course, as an ordinary fish just won't do the trick. Actually it is not a real fish but a kind of machine with the likeness of a fish! ...",
				"Imagine what I could learn from such a fish! And imagine what harm could be done if this fish were to fall into the wrong hands! We must retrieve that fish! ...",
				"Apparently, the people in the city of Yalahar had a mechanical fish, fish which are essential for my research. ...",
				"Now those Yalahari are quite elusive and even if we could get in contact with one of them, buying a fish from them would surely cost a fortune which we don't posses. ...",
				"But my sources have informed me that some of these fish might have escaped into the local sewers! Based on my knowledge of the fish I have designed a mechanical fishing rod which you can use. ...",
				"You won't catch any other fish with it but without it you haven't a chance of catching a mechanical fish. You will need to use nails as bait. ...",
				"Well perhaps I should mention a minor, insignificant problem that might occur. ...",
				"Due to the metallic nature of the fishing rod there is the very remote possibility that you might get into contact with one of the electric eels thatalso live in the sewers. ...",
				"In which case you might feel a little tingle from a teency tiny electric shock. I can't tell what effect that might have on your health but you should probably be careful that you are not badly wounded while fishing. ...",
				"Hm, thinking about it, perhaps those eels are part of the evil plan to thwart our efforts, who knows? So are you ready for that mission?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 8)
		elseif player:getStorageValue(S.Questline) == 2 then
			npcHandler:say("Have you caught the mechanical fish?", npc, creature)
			npcHandler:setTopic(playerId, 9)
		elseif player:getStorageValue(S.Questline) == 3 then
			npcHandler:say({
				"The machines of the .. uhm my inventions need a potent fuel. I have run hundreds of tests and found that only the most potent rum makes the most powerful fuel ...",
				"I did have enough rum to make the trip but .. well, you know .. the lads came over to celebrate my birthday and we ended up .. uhm testing the fuel.. Damn that tasty rum! Well its a risk of the job when the fuel tastes that good ...",
				"However, we will need some new fuel. 10 vials of rum exactly. ...",
				"Remember it has to be vials because after we got drunk one of the lads wandered of with my funnel thinking it was hat. Only vials will fit into my machine.",
			}, npc, creature)
			player:setStorageValue(S.Questline, 4)
			player:setStorageValue(S.Mission02, 1) -- Start Mission 02
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(S.Questline) == 4 then
			npcHandler:say("Do you have the rum .. erm the fuel with you?", npc, creature)
			npcHandler:setTopic(playerId, 10)
		elseif player:getStorageValue(S.Questline) == 5 then
			npcHandler:say("Now that we have the rum, I still desperately need a vial of fruit juice to keep things going. Just get me one so we can proceed.", npc, creature)
			player:setStorageValue(S.Questline, 6)
			player:setStorageValue(S.Mission03, 1) -- Start Mission 03
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(S.Questline) == 6 then
			npcHandler:say("So you have brought me a vial of fruit juice?", npc, creature)
			npcHandler:setTopic(playerId, 11)
		elseif player:getStorageValue(S.Questline) == 7 then
			npcHandler:say({
				"My invention is only as good as the engine that powers it. I need a high quality steam machine from the technomancers guild. You should ask my old mate Scutty about one. ...",
				"I have already sent him a request and some gold but chances are you will need to convince him somehow to lend us his precious machine.",
			}, npc, creature)
			player:setStorageValue(S.Questline, 8)
			player:setStorageValue(S.Mission04, 1) -- Start Mission 04
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(S.Questline) == 8 then
			npcHandler:say("Did you get the requested machine from Scutty?", npc, creature)
			npcHandler:setTopic(playerId, 12)
		elseif player:getStorageValue(S.Questline) == 9 then
			npcHandler:say({
				"The evil we are fighting has not chosen the Isle of Evil on a mere whim. Quite the contrary, it has shown strategic genius by selecting an isle surrounded by hidden reefs and treacherous waters. ...",
				"This serves not only to conceal it from prying eyes, but it also poses a serious threat to anyone who wants to travel there. ...",
				"The sea around that isle is as dangerous as the isle and its inhabitants themselves. ...",
				"Without a proper map we are doomed! Doomed, I tell you! ...",
				"I have found out that a ship from the Explorers' Society charted the sea around the isle some years ago, so they should have some decent maps of that area ...",
				"According to my sources, the map is now being kept at one of their northern outposts. It is somewhere north east of Carlin, in a hamlet on the coast. Get that map and we'll soon be on our way to vanquish evil! ...",
				"And be warned: if the servants of evil have learned about the map it means not only the map and the Explorers' Society are in grave danger but also you and your mission could be in peril. Trust no one. ...",
				"Don't accept gifts from strangers and don't hitchhike in strangers' wagons. Don't sit with your back to the door in a tavern and what the heck would you be doing in a tavern while on an urgent mission anyway? ...",
				"Rest assured in the unfortunate case of your death, you will be avenged. Well, only in the unlikely case that you die while on this mission, of course.",
			}, npc, creature)
			player:setStorageValue(S.Questline, 10)
			player:setStorageValue(S.Mission05, 1) -- Start Mission 05
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(S.Questline) == 10 then
			npcHandler:say("So did you get that nautical map?", npc, creature)
			npcHandler:setTopic(playerId, 13)
		elseif player:getStorageValue(S.Questline) == 11 then
			npcHandler:say({
				"While you were getting the map I put the finishing touches on our vessel. The machine works fine and with the improvements I have made, it should enable us to brave the seas to reach our destination. ...",
				"Meet me downstairs where you will learn more about our secret weapon.",
			}, npc, creature)
			player:setStorageValue(S.Questline, 12)
			player:setStorageValue(S.Mission06, 1) -- Start Mission 06
			player:setStorageValue(S.Door_06, 1) -- Door to Isle of Evil
			npcHandler:setTopic(playerId, 0)
			return true
		end
	end
	if MsgContains(message, "fight") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say({
			"It is my calling to root out evil in all its forms and uphold the vigilant fight. It is a lonely fight, an unending fight, but someone has to do it! ...",
			"I scour ancient texts and collect rumours in taverns in order to track the machinations of evil. ...",
			"Often odd occurrences are overlooked by the public as strange coincidences or fate, but those who know what to look for see the foot prints of {evil} in history.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "evil") and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say({
			"Evil lurks everywhere. It only takes some ignorant or cowardly people to turn their heads away once too often for it to spread its ugly seeds. I, however, am constantly vigilant and always prepared. ...",
			"I {hunt} out the signs of evil everywhere. Even in the face of scorn and ridicule, I will not hide my head in the sand and I will be ready to fight!",
		}, npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif MsgContains(message, "hunt") and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say({
			"It is my calling to root out evil in all its forms and uphold the vigilant fight. It is a lonely fight, an unending fight, but someone has to do it! ...",
			"I scour ancient texts and collect rumours in taverns in order to track the machinations of evil. ...",
			"Often odd occurrences are overlooked by the public as strange coincidences or fate, but those who know what to look for see the footprints of evil in history.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif MsgContains(message, "ridicule") and npcHandler:getTopic(playerId) == 4 then
		npcHandler:say("Ignorance is evil's most potent ally. The servants of evil are plotting to keep us ignorant and poke ridicule at those who come too close to the {truth}.", npc, creature)
		npcHandler:setTopic(playerId, 5)
	elseif MsgContains(message, "truth") and npcHandler:getTopic(playerId) == 5 then
		npcHandler:say({
			"When I found that ancient text, warning of the {Isle of Evil}, I tried to tell the world about it. But the forces of evil discovered my plans! They made people assume it was just another tale for children. ...",
			"THEY distributed a book of children's bedtime stories with a copy of the text in it to undermine my message! Their despicable ruse worked and they made a laughing stock of me! Of course I knew it was a plot to discredit me. ...",
			"On the other hand, it was obvious that THEY now knew about me and the text I possessed. I went into hiding in fear of my life! THEY have tried to assassinate me! I must be constantly vigilant!",
		}, npc, creature)
		npcHandler:setTopic(playerId, 6)
	elseif MsgContains(message, "isle of evil") and npcHandler:getTopic(playerId) == 6 then
		npcHandler:say({
			"I KNOW it's out there! And I have proof! You see, I have constructed an evil-o-meter! It is an invention that locates places of great evil, such as the Ghostlands, the Plains of Havoc and the Edron Ruins. ...",
			"But then it registered another impulse. I tried my best to locate this impulse, believing it would probably point to another well known source of evil like the Hellgate. ...",
			"I was alarmed to realise that it was pointing to a remote isle that had been previously assumed to be uninhabited. I know that some horrendous evil lurks there. Some unspeakable horror, waiting to kill and devour unsuspecting travellers. ...",
			"I could not let that happen! So I did some research. Just as I was on the brink of giving up in desperation, I stumbled upon an ancient text that told of the Isle of Evil! ...",
			"Immediately, the nature of the threat I had discovered became alarmingly clear! All I needed was a hero and some transport. But would they listen?! NO! They laughed at me. Ignorance is Evil's helper! ...",
			"I still lack transport and a hero. Hmm .. seeing as I have no hero, you will have to do. What do you think? Are you willing to risk life and limb to save mankind? And womankind, of course?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 7)
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 7 then
			npcHandler:say({
				"Although my instincts tell me to be wary of you, stranger, turning up so conveniently, I have no choice but to accept your help. ...",
				"Have a care! I have eyes like a hawk and am ever vigilant! If you even think about betraying me, I'll know! Well, I guess we had better talk about your first mission.",
			}, npc, creature)
			player:setStorageValue(S.Questline, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 8 then
			npcHandler:say("Great. Here is your fishing rod. Happy fishing. Don't return without the mechanical fish. Make sure you are not followed!.", npc, creature)
			player:addItem(9306, 1) -- Mechanical Fishing Rod
			player:setStorageValue(S.Questline, 2)
			player:setStorageValue(S.Mission01, 1) -- Start Mission 01
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 9 then
			if player:getItemCount(9307) >= 1 then
				npcHandler:say("Interesting, a most interesting construction. A marvel of science. While I try to figure out how it works you might as well continue with your next mission.", npc, creature)
				player:removeItem(9307, 1)
				player:setStorageValue(S.Questline, 3)
				player:setStorageValue(S.Mission01, 2) -- Finish Mission 01
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finishing your mission.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 10 then
			if player:getItemCount(2874, 13) >= 10 then
				npcHandler:say({
					"You did it! Ye Gods, what a temptation! But I will not give in! I will put it into the machine as soon as possible. Oh and if you happen to see a dwarf wearing a funnel, please ask him to return it to me. ...",
					"But now let's talk about your next mission.",
				}, npc, creature)
				player:removeItem(2874, 10, 13)
				player:setStorageValue(S.Questline, 5)
				player:setStorageValue(S.Mission02, 2) -- Finish Mission 02
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You dont have what I ask for.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 11 then
			if player:getItemCount(2874, 14) >= 1 then
				npcHandler:say({
					"Ahhhh that juice was just what I needed. I haven't had any fruit juice for ages! You can't fight evil the whole day without allowing yourself a small treat! ...",
					"Though I bet it would have tasted better in a glass with one of those amusing umbrellas on top! But I don't blame you. ...",
					"I fear we hunters of evil must be content with the small pleasures life grants us. Now where were we? Oh, yes you are probably eager to learn about your next mission as part of our big plan!",
				}, npc, creature)
				player:removeItem(2874, 1, 14)
				player:setStorageValue(S.Questline, 7)
				player:setStorageValue(S.Mission03, 2) -- Finish Mission 03
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You dont have what I ask for.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 12 then
			if player:getItemCount(9390) >= 1 then
				npcHandler:say("Ah, marvellous. That's the little beauty I was looking for. It will fit perfectly into my invention. Not much longer and we can start on our journey. However, I have another mission for you.", npc, creature)
				player:removeItem(9390, 1)
				player:setStorageValue(S.Questline, 9)
				player:setStorageValue(S.Mission04, 5) -- Finish Mission 04
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You dont have what I ask for.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 13 then
			if player:getItemCount(9308) >= 1 then
				npcHandler:say({
					"Hmm, what fine maps those explorers draw. Wouldn't it be a cunning idea to tattoo it on your back where evil would least expect to find it! I guess with a nail from my workshop and a bucket of old ship paint I could improvise that. ...",
					"On the other hand the forces of evil probably know all too well that I am cunning, so I have to surprise them with the unexpected! I'll just hide it in my beard! There we go. Now lets talk about our final mission.",
				}, npc, creature)
				player:removeItem(9308, 1)
				player:setStorageValue(S.Questline, 11)
				player:setStorageValue(S.Mission05, 3) -- Finish Mission 05
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You dont have what I ask for.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Psht! Not that loud! Evil lurks everywhere.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
