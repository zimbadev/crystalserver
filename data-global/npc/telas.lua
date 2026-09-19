local internalNpcName = "Telas"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 39,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 76,
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
local SOY_KV_SCOPE = "shadows-of-yalahar"
local MISSION10_ORDER_KEY = "mission10-order"
local MISSION10_INDEX_KEY = "mission10-index"
local MISSION10_STATE_KEY = "mission10-state"
local mission10Items = {
	deepcrystal = {
		itemId = 9240,
		assign = "According to dwarven miners you might find the deep crystal somewhere in the depths under Ab'Dendriel. I have no idea where though, or even how to get there.",
		deliver = "I truly hope this is a deep crystal. I have to admit, all those crystals look the same to me.",
	},
	darkessence = {
		itemId = 9238,
		assign = "One of the more unpleasant components that I need is some dark essence. Some of my colleagues believe that it sometimes condenses in the depths beneath the cursed town of Drefia in the desert of the Daramian continent.",
		deliver = "By the Gods! Handle that dark essence with care! Didn't I mention it might explode? Ooops, I probably forgot to tell you! Well, whatever, I'll put it in a safe place for now. Thank you for your efforts my friend.",
	},
	shadoworb = {
		itemId = 9237,
		assign = "One of the components is a shadow orb. So far, I have had no luck acquiring one. I even tried one of my more dubious contacts but he refused, saying that he would only mess with the guys in the dark cathedral if he had a death wish'. I think if you find this dark cathedral you might find a shadow orb.",
		deliver = "Ah, a perfect shadow orb! This is exactly what we need.",
	},
	bloodkiss = {
		itemId = 9241,
		assign = "Some of the elves of Shadowthorn cultivate a plant known as bloodkiss. I need one sample for the ritual.",
		deliver = "What a beautiful flower. A shame that we have to destroy it in the ritual.",
	},
	wormqueentooth = {
		itemId = 9239,
		assign = "I am convinced that the tooth from a long dead rotworm queen will make an apt replacement for one of the more exotic ingredients in the Yalahari ritual. The books in the Edron academy suggest that the most likely place to find one might be deeper Fibula.",
		deliver = "My, this rotworm tooth looks old. But the older the better. It will certainly be sufficient for our ritual.",
	},
	animalfetish = {
		itemId = 9236,
		assign = "One of the components could easily be substituted by an animal fetish. I have heard that the orcs in the Orcland use them to tame their war wolves. That's where you should start looking.",
		deliver = "Phew. That fetish stinks. I'd better put it into some sort of container.",
	},
}
local mission10ItemKeys = { "wormqueentooth", "shadoworb", "bloodkiss", "animalfetish", "darkessence", "deepcrystal" }
local function mission10RandomItem()
	local pool = {}
	for i, key in ipairs(mission10ItemKeys) do
		pool[i] = key
	end

	for i = #pool, 2, -1 do
		local j = math.random(i)
		pool[i], pool[j] = pool[j], pool[i]
	end

	return { pool[1], pool[2], pool[3] }
end

local function mission10GetOrder(kv)
	local orderValue = kv:get(MISSION10_ORDER_KEY)
	if not orderValue then
		return nil
	end

	local order = {}
	for itemKey in orderValue:gmatch("[^,]+") do
		order[#order + 1] = itemKey
	end
	return order
end

-- Shadows of Yalahar
local SOY_KV_SCOPE = "shadows-of-yalahar"
local MISSION10_ORDER_KEY = "mission10-order"
local MISSION10_INDEX_KEY = "mission10-index"
local MISSION10_STATE_KEY = "mission10-state"

local mission10Items = {
	deepcrystal = {
		itemId = 9240,
		assign = "According to dwarven miners you might find the deep crystal somewhere in the depths under Ab'Dendriel. I have no idea where though, or even how to get there.",
		deliver = "I truly hope this is a deep crystal. I have to admit, all those crystals look the same to me.",
	},
	darkessence = {
		itemId = 9238,
		assign = "One of the more unpleasant components that I need is some dark essence. Some of my colleagues believe that it sometimes condenses in the depths beneath the cursed town of Drefia in the desert of the Daramian continent.",
		deliver = "By the Gods! Handle that dark essence with care! Didn't I mention it might explode? Ooops, I probably forgot to tell you! Well, whatever, I'll put it in a safe place for now. Thank you for your efforts my friend.",
	},
	shadoworb = {
		itemId = 9237,
		assign = "One of the components is a shadow orb. So far, I have had no luck acquiring one. I even tried one of my more dubious contacts but he refused, saying that he would only mess with the guys in the dark cathedral if he had a death wish'. I think if you find this dark cathedral you might find a shadow orb.",
		deliver = "Ah, a perfect shadow orb! This is exactly what we need.",
	},
	bloodkiss = {
		itemId = 9241,
		assign = "Some of the elves of Shadowthorn cultivate a plant known as bloodkiss. I need one sample for the ritual.",
		deliver = "What a beautiful flower. A shame that we have to destroy it in the ritual.",
	},
	wormqueentooth = {
		itemId = 9239,
		assign = "I am convinced that the tooth from a long dead rotworm queen will make an apt replacement for one of the more exotic ingredients in the Yalahari ritual. The books in the Edron academy suggest that the most likely place to find one might be deeper Fibula.",
		deliver = "My, this rotworm tooth looks old. But the older the better. It will certainly be sufficient for our ritual.",
	},
	animalfetish = {
		itemId = 9236,
		assign = "One of the components could easily be substituted by an animal fetish. I have heard that the orcs in the Orcland use them to tame their war wolves. That's where you should start looking.",
		deliver = "Phew. That fetish stinks. I'd better put it into some sort of container.",
	},
}
local mission10ItemKeys = { "wormqueentooth", "shadoworb", "bloodkiss", "animalfetish", "darkessence", "deepcrystal" }

local function mission10RandomItem()
	local pool = {}
	for i, key in ipairs(mission10ItemKeys) do
		pool[i] = key
	end

	for i = #pool, 2, -1 do
		local j = math.random(i)
		pool[i], pool[j] = pool[j], pool[i]
	end

	return { pool[1], pool[2], pool[3] }
end

local function mission10GetOrder(kv)
	local orderValue = kv:get(MISSION10_ORDER_KEY)
	if not orderValue then
		return nil
	end

	local order = {}
	for itemKey in orderValue:gmatch("[^,]+") do
		order[#order + 1] = itemKey
	end
	return order
end

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- Shadows of Yalahar
	if MsgContains(message, "mission") then
		-- Mission 01
		if player:getStorageValue(ShadowsOfYalahar.Questline) < 1 then
			npcHandler:say({
				"My research on the creation of golems has progressed well so far. However, it is good to acknowledge the accomplishments of others in this science. ...",
				"I am in contact with certain gifted individuals who have themselves gained significant insights into this subject. ...",
				"I want you to contact them and ask them for their research notes. They should have the means to send them to me so you don't have to worry about picking up the papers and possibly losing them. ...",
				"From our previous correspondence I'd say all of them are supportive but reaching some of them might prove troublesome. ...",
				"I need the research notes from the technomancer Scutty of Kazordoon, the theoretical mago-scientist Milos of the Edron Academy. ...",
				"The field scientist Boveas, who can be found in Mintwalin, the druid Cerdras of Carlin and Dreadeye, a bonelord of the Braindeath Streak, who lives somewhere in the necropolis deep below Ab'Dendriel.",
			}, npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 1) -- Start Quest
			player:setStorageValue(ShadowsOfYalahar.Mission01, 1) -- Start Mission 01
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 1 then
			local kv = player:kv():scoped(SOY_KV_SCOPE)

			if kv:get("research-boveas") and kv:get("research-cerdras") and kv:get("research-dreadeye") and kv:get("research-milos") and kv:get("research-scutty") then
				npcHandler:say({
					"Ah, yes. I have received all the reports I need and have already been able to glance through them. ...",
					"It will take some time to evaluate all those different approaches to the topic. Meanwhile, we can get on with the other tasks to advance our project. ...",
					"when you are ready, just ask me for your next mission.",
				}, npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Questline, 2)
				player:setStorageValue(ShadowsOfYalahar.Mission01, 2) -- Finish Mission 01
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 2 then
			npcHandler:say({
				"I hate to admit it, but I am still unable to create some of the necessary parts. Unfortunately, modern day technology just doesn't have the complexity to recreate the Yalaharian mago-mechanic cores. ...",
				"However, I do need to find out whether my other components function properly, so for my first attempt, an existing core will have to do. Unfortunately, we can't just go to Yalahar and ask for one. ...",
				"The Yalahari are not known for sharing their knowledge willingly. On the other hand, much of their machinery is not even used these days. ...",
				"Can you search in their factory quarter for some of the cores? But, pay attention now! The cores are not that easy to get ...",
				"According to my research, while the cores are being used, they are incredibly hot so you can't just remove one. Also, the Yalahari have added additional security and maintenance-friendly mechanisms. ...",
				"In each machine that uses cores, they have installed what I would call cooler cannons. ...",
				"The cannons can be used to cool overheated cores or cool down a normal core so it can be removed for maintenance. There are two drawbacks though. ...",
				"First you need to hit the core with the cooler cannon when it reaches the correct temperature. ...",
				"If you shoot too early it will be frozen in place and the system won't be able to remove it. ...",
				"The second drawback is that the cannon uses enormous amounts of energy, so you can only fire it every few seconds and will have to wait until it is fully recharged. ...",
				"If you hit the core while it is red hot it will cool down to room temperature and can be removed from the machine, but the system will replace it with another immediately. You should be able to get the cooled and inactive core from a nearby dispenser. ...",
				"As far as I can tell the core should remain inactive and do nothing funny like spontaneously overheat and fry you or something equally unpleasant.",
			}, npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 3)
			player:setStorageValue(ShadowsOfYalahar.Mission02, 1) -- Start Mission 02
			player:setStorageValue(ShadowsOfYalahar.Door_02, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 3 then
			if player:getItemCount(9249) >= 1 then
				npcHandler:say({
					"Ah, a mago mechanic core. A true marvel of Yalahari science. One day, my friend, we will be able to build our own. ...",
					"My understanding is growing daily. For now we will incorporate this core into our construction. ...",
					"You have proven yourself to be incredibly helpful. More missions await you.",
				}, npc, creature)
				player:removeItem(9249, 1)
				player:setStorageValue(ShadowsOfYalahar.Questline, 4)
				player:setStorageValue(ShadowsOfYalahar.Mission02, 2) -- Finish Mission 02
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 4 then
			npcHandler:say({
				"A golem's major power source is a mix of elemental forces. ..",
				"Most of the elements need only a low concentration of purity but the earth component, which is the overriding element in a Yalaharian golem, requires a huge amount of very pure concentrate. ...",
				"That is why crystals are often fused into the golem's body. ...",
				"Could you get me some elemental crystals? Use an ordinary pick axe on a slain earth elemental. With some luck you will gain an elemental shard. ...",
				"Ten of them should be enough for me to create an elemental crystal.",
			}, npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 5)
			player:setStorageValue(ShadowsOfYalahar.Mission03, 1) -- Start Mission 03
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 5 then
			if player:getItemCount(9251) >= 10 then
				npcHandler:say({
					"So you have brought me all 10 shards for the core! That is one step further towards the construction of our very own golem! Without your help I would never have made it this far. ...",
					"I wish your next mission were less dangerous but sadly it isn't. But more about that when we talk about your next mission.",
				}, npc, creature)
				player:removeItem(9251, 10)
				player:setStorageValue(ShadowsOfYalahar.Questline, 6)
				player:setStorageValue(ShadowsOfYalahar.Mission03, 2) -- Finish Mission 03
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 6 then
			npcHandler:say({
				"I always find new things in the Yalaharian metallurgy to amaze me. In order to construct parts that are even remotely similar I had to spend a fortune and wait years for a dwarven smith to finish them. ...",
				"Luckily, there is a much cheaper source for even better material: existing golems. There are quite a few running aimlessly through Yalahar and posing a threat to unwary travellers. ...",
				"So by disabling those golems not only do we further our research but we also do something to clean up the city's golem problem! I'll lend you this golem-disassembler. ...",
				"When you have killed a golem wait a moment until all of his systems shut down. Then use the disassembler on his corpse. ...",
				"But, be careful! If you wait too long the parts will lose their charges and be worthless. ...",
				"Chances are that the disassembler will only produce scrap metal but now and then you'll get a golem part. I need six of them to make any progress in my work.",
			}, npc, creature)
			player:addItem(9235, 1) -- golem disassembler
			player:setStorageValue(ShadowsOfYalahar.Questline, 7)
			player:setStorageValue(ShadowsOfYalahar.Mission04, 1) -- Start Mission 04
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 7 then
			if player:getItemCount(9233) >= 6 then
				npcHandler:say("Ah, with your newest acquisition you have brought me 6 golem parts. With that we are done and can continue with your next mission.", npc, creature)
				player:removeItem(9233, 6)
				player:setStorageValue(ShadowsOfYalahar.Questline, 8)
				player:setStorageValue(ShadowsOfYalahar.Mission04, 2) -- Finish Mission 04
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 8 then
			local kv = player:kv():scoped(SOY_KV_SCOPE)
			local started = kv:get("mission05-started")

			if started ~= true then
				npcHandler:say({
					"Well, this one is somewhat hard to explain. The power core of the golem needs some specific charges to make it work. The good news is that I have discovered the perfect carrier for the charge. ...",
					"The bad news is, it's you! Well, let me elaborate: I need three different charges. ...",
					"You can charge yourself by walking though a charge generator. One of these can be found in the alchemists' quarter. ...",
					"Get yourself charged and return to me. I will suck the charge into one of my own inventions and can tell you if you carried one of the three charges we needed. ...",
					"Unfortunately, the machine may charge you in two further ways to the three charges we actually need. The other two charges are of no use to our project. ...",
					"But, on the positive side, each charge that we don't need can be sold to other scientists and I am willing to share some gold with you for your efforts.",
				}, npc, creature)
				kv:set("mission05-started", true)
				player:setStorageValue(ShadowsOfYalahar.Mission05, 1) -- Start Mission 05
				player:setStorageValue(ShadowsOfYalahar.Door_05, 1)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			local charge = kv:get("charge")
			if not charge then
				npcHandler:say("You are not charged yet. Go find the charge generator in the alchemists' quarter and come back to me.", npc, creature)
				return true
			end

			local chargeValue = charge

			if chargeValue == "A" or chargeValue == "B" or chargeValue == "C" then
				local deliveredKey = "delivered-" .. chargeValue:lower()
				local delivered = kv:get(deliveredKey)

				if delivered == true then
					npcHandler:say("Hm, that is another " .. chargeValue .. "-charge. Though it won't advance our project it will bring us a good price from other researchers. I will give you 900 gold for that charge.", npc, creature)
					player:addMoney(900)
				else
					kv:set(deliveredKey, true)

					local mission05Value = player:getStorageValue(ShadowsOfYalahar.Mission05)
					player:updateStorage(ShadowsOfYalahar.Mission05, mission05Value, mission05Value, os.time())

					if chargeValue == "A" then
						npcHandler:say("Excellent. You brought an A-charge. Just what we needed.", npc, creature)
					elseif chargeValue == "B" then
						npcHandler:say("Exemplary! A B-charge! Incredible!", npc, creature)
					elseif chargeValue == "C" then
						npcHandler:say("We have got a major C-charge! Excellent!", npc, creature)
					end

					local deliveredA = kv:get("delivered-a")
					local deliveredB = kv:get("delivered-b")
					local deliveredC = kv:get("delivered-c")

					if deliveredA == true and deliveredB == true and deliveredC == true then
						npcHandler:say("We are finished with collecting charges! Now we can proceed and your next mission awaits you!", npc, creature)
						player:setStorageValue(ShadowsOfYalahar.Questline, 9)
						player:setStorageValue(ShadowsOfYalahar.Mission05, 2) -- Finish Mission 05
					end
				end
			elseif chargeValue == "X" then
				npcHandler:say("Oh, that's an X-charge. Nevermind. Although we don't need it, the academy might use it for their lightning research. Here is your share of the money I'll get from reselling it. That makes 1500 gold.", npc, creature)
				player:addMoney(1500)
			elseif chargeValue == "Y" then
				npcHandler:say("Though this Y-charge is quite rare we don't need it for our research. However, some independent researchers will be willing to part with a fair amount of coin for it. I'll advance you 1200 gold. I'm sure I'll get that much back from my colleague.", npc, creature)
				player:addMoney(1200)
			elseif chargeValue == "Z" then
				npcHandler:say("Ah, a Z-charge. Not what we need, but I'm sure I can sell it. Here's your share: 900 gold.", npc, creature)
				player:addMoney(900)
			end

			kv:remove("charge")
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 9 then
			npcHandler:say("I need a blueprint of a golem to compare with my own plans. I need to figure out where problems might arise. Please search the factory quarter for some blueprints that I can use.", npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 10)
			player:setStorageValue(ShadowsOfYalahar.Mission06, 1) -- Start Mission 06
			player:setStorageValue(ShadowsOfYalahar.Door_06, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 10 then
			if player:getItemCount(9247) >= 1 then
				npcHandler:say("Yes, you've got them! That will aid my understanding of the construction of a golem. But there is still a lot to do and new missions waiting.", npc, creature)
				player:removeItem(9247, 1)
				player:setStorageValue(ShadowsOfYalahar.Questline, 11)
				player:setStorageValue(ShadowsOfYalahar.Mission06, 2) -- Finish Mission 06
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 11 then
			npcHandler:say("In order to understand a Yalaharian power core I have to disassemble one. I think there are still some old and burnt out power cores to be found in the alchemists' quarter of Yalahar. Please get me one, the state of the core is not that important.", npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 12)
			player:setStorageValue(ShadowsOfYalahar.Mission07, 1) -- Start Mission 07
			player:setStorageValue(ShadowsOfYalahar.Door_07, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 12 then
			if player:getItemCount(9252) >= 1 then
				npcHandler:say("Phenomenal! That's precisely what we need. A bit tattered and rusty but it will do perfectly. While I am busy with this, you can get on with some other missions.", npc, creature)
				player:removeItem(9252, 1)
				player:setStorageValue(ShadowsOfYalahar.Questline, 13)
				player:setStorageValue(ShadowsOfYalahar.Mission07, 2) -- Finish Mission 07
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 13 then
			npcHandler:say({
				"I hope to save myself the effort of reinventing a stabilizer small enough to fit into the golem. I will have to get an original Yalahari stabilizer or be forced to create a four legged golem, which clearly won't do. ...",
				"Therefore, I need you to search the sunken quarter for a stabilizer.",
			}, npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 14)
			player:setStorageValue(ShadowsOfYalahar.Mission08, 1) -- Start Mission 08
			player:setStorageValue(ShadowsOfYalahar.Door_08, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 14 then
			if player:getItemCount(9248) >= 1 then
				npcHandler:say("Phenomenal! You must have good eyesight to have spotted this little fellow. However, don't mind my mumbling. New missions await you.", npc, creature)
				player:removeItem(9248, 1)
				player:setStorageValue(ShadowsOfYalahar.Questline, 15)
				player:setStorageValue(ShadowsOfYalahar.Mission08, 2) -- Finish Mission 08
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 15 then
			npcHandler:say({
				"While visiting Yalahar I discovered one of their libraries in the magicians' quarter. I solved the logic puzzle that prevented unwanted intruders and began to study their rituals. ...",
				"I was THAT close to reconstructing the ritual when one of the Yalahari, Azerus, discovered me and had me thrown out of the city. I think all those guardian golems know me now and I can't show my face there any more ...",
				"You, on the other hand, can! I will tell you how to open the puzzle lock so you can enter the library. ...",
				"I fear that the Yalahari may have posted some Golems there as guards so you'll have to fight them to use the library undisturbed. Your mission is to reconstruct the ancient golem ritual from their books. ...",
				"There are hints scattered throughout the books in the library. Be warned! Yalahari literature is not easy reading! You might get a headache, which will make you forget what you just read. ...",
				"The chances of recreating the ritual are greater the more you read. On the other hand the more books you read the more likely it is that you'll get a headache and forget everything you have learned. ...",
				"If you get a headache you will have to wait a minute or two for it to wear off before you can continue. There are rumors about headache pills on the black market, but I have no idea where to find one. ...",
				"When you feel ready to recreate the ritual use the scribe's desk in the center of the room. You'll know when you have been successful.",
			}, npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 16)
			player:setStorageValue(ShadowsOfYalahar.Mission09, 1) -- Start Mission 09
			player:setStorageValue(ShadowsOfYalahar.Door_09, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 16 then
			if player:getStorageValue(ShadowsOfYalahar.Mission09) == 2 then
				npcHandler:say("Impressive! To be honest, I feared a bit for your sanity, but you made it! And you are still healthy and sane! Well, at least I hope so. I fully understand if you want to take a few days off before you continue with your next mission.", npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Questline, 17)
				player:setStorageValue(ShadowsOfYalahar.Mission09, 3) -- Finish Mission 09
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 17 then
			-- Mission 10
			local kv = player:kv():scoped(SOY_KV_SCOPE)
			local order = mission10GetOrder(kv)

			if not order then
				npcHandler:say({
					"Yalahari rituals are quite complicated and need certain reagents that are not readily available nowadays. I think I can come up with some substitutes for most of them though. ...",
					"Specifically, three items need to be replaced. Are you ready for your first mission?",
				}, npc, creature)
				order = mission10RandomItem()
				kv:set(MISSION10_ORDER_KEY, table.concat(order, ","))
				kv:set(MISSION10_INDEX_KEY, 1)
				kv:set(MISSION10_STATE_KEY, "ready")
				player:setStorageValue(ShadowsOfYalahar.Mission10, 1) -- Start Mission
				player:setStorageValue(ShadowsOfYalahar.Door_10, 1)
				return true
			end

			local index = kv:get(MISSION10_INDEX_KEY)
			local state = kv:get(MISSION10_STATE_KEY)

			if state == "ready" then
				local ordinal = index == 1 and "first" or (index == 2 and "second" or "third")
				npcHandler:say("Are you up to your " .. ordinal .. " assignment?", npc, creature)
			elseif state == "collecting" then
				local currentItem = mission10Items[order[index]]

				if player:getItemCount(currentItem.itemId) > 0 then
					player:removeItem(currentItem.itemId, 1)
					npcHandler:say(currentItem.deliver, npc, creature)

					local mission10Value = player:getStorageValue(ShadowsOfYalahar.Mission10)
					player:updateStorage(ShadowsOfYalahar.Mission10, mission10Value, mission10Value, os.time())

					if index >= 3 then
						kv:set(MISSION10_STATE_KEY, "done")
					else
						kv:set(MISSION10_INDEX_KEY, index + 1)
						kv:set(MISSION10_STATE_KEY, "ready")
					end
				else
					npcHandler:say("You still have to bring me the item for this assignment.", npc, creature)
				end
			elseif state == "done" then
				npcHandler:say("Finally! You have brought all the ingredients we need! We can talk about your next mission whenever you like.", npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Questline, 18)
				player:setStorageValue(ShadowsOfYalahar.Mission10, 2) -- Finish Mission 10
				kv:remove(MISSION10_ORDER_KEY)
				kv:remove(MISSION10_INDEX_KEY)
				kv:remove(MISSION10_STATE_KEY)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 18 then
			-- Mission 11
			npcHandler:say({
				"I am disheartened. All my efforts to get this golem to function have been in vain! There is still something missing. Were I not a scientist I'd say it was the soul. ...",
				"I can't get the brain patterns working and without that a golem is just a useless shell. ...",
				"At the moment I would settle for some existing brain patterns but the golems that are still around seem to lack the sophisticated brain patterns needed to meld with my creation. There is one final hope though. ...",
				"While I was doing my research in Yalahar I stumbled upon reports about a remote scientific outpost of the Yalahari. There they were experimenting with something they called MI, short for magical intelligence. ...",
				"That should create some far more intelligent golems. I desperately need one of those golem's heads. The base has to be somewhere beneath the isle, nowadays is known as Fenrock. ...",
				"Unfortunately, I believe that you have to be a Yalahari or a Yalaharian servant to enter the complex. ...",
				"However, on the bright side, in the course of doing these missions you have been charged with Yalahari energy, read their mind twisting books and have come into contact with much of their technology. ...",
				"Additionally, there are electric showers that were often used by Yalaharian scientists. I have found out that one of the few electric showers that are still working is somewhere in the factory quarter. ...",
				"First, you will have to use it on yourself, then report back to me. I will use an ancient Yalahari device on you to amplify all the Yalahari characteristics you have acquired. ...",
				"Our only slim hope is that this might fool the system enough to allow you to enter the complex.",
			}, npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Questline, 19)
			player:setStorageValue(ShadowsOfYalahar.Mission11, 1) -- Start Mission 11
			player:setStorageValue(ShadowsOfYalahar.Door_11, 1)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 19 then
			npcHandler:say("Ah, yes. My instruments tell me you have taken the shower! Are you ready to receive the amplifying charge?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 20 then
			if player:getItemCount(9255) >= 1 then
				npcHandler:say("The head! You've got it! Incredible! Now we have everything we need! Give me a Tibian day to prepare everything for the activation process, then meet me here again.", npc, creature)
				player:removeItem(9255, 1)
				player:setStorageValue(ShadowsOfYalahar.Questline, 21)
				player:setStorageValue(ShadowsOfYalahar.Mission12, 2) -- Compete Mission 12
				player:addMoney(500)
				player:kv():scoped(SOY_KV_SCOPE):set("mission12-timer", os.time() + 2 * 60) -- 1 * 60 * 60
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Come back after finish your task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 21 then
			local kv = player:kv():scoped(SOY_KV_SCOPE)
			local timerValue = kv:get("mission12-timer")

			if timerValue then
				local timer = timerValue

				if timer > os.time() then
					local remaining = timer - os.time()

					local minutes = math.floor(remaining / 60)
					local seconds = remaining % 60

					local timeStr = ""
					if minutes > 0 then
						timeStr = minutes .. " minute" .. (minutes > 1 and "s" or "")
					end
					if seconds > 0 then
						if timeStr ~= "" then
							timeStr = timeStr .. " and "
						end
						timeStr = timeStr .. seconds .. " second" .. (seconds > 1 and "s" or "")
					end
					if timeStr == "" then
						timeStr = "less than a second"
					end
					npcHandler:say("You are eager, aren't you?! You have returned too early. Give me some more time to prepare everything. Come back in " .. timeStr .. "!", npc, creature)
					return true
				end
				npcHandler:say({
					"We have made it, my friend! We have everything we need to reconstruct a Yalaharian golem! This is a great day for science. ...",
					"Without your help none of this would have been possible. We will both take our place in history soon. Meet me downstairs in my laboratory. ...",
					"The honour of activating the golem shall belong to you, my friend.",
				}, npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Questline, 22)
				player:setStorageValue(ShadowsOfYalahar.Mission13, 1) -- Start Mission 13
				player:setStorageValue(ShadowsOfYalahar.DoorLab, 1)
				kv:remove("mission12-timer")
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 22 then
			local kv = player:kv():scoped(SOY_KV_SCOPE)
			local leverPulled = kv:get("mission12-lever")

			if leverPulled == true then
				npcHandler:say({
					"It's alive! Well, not strictly alive, of course, but moving and talking! Hmm, it seems to be behaving strangely, but perhaps it just needs some training or something like that! ...",
					"I am so grateful to you! I grant you the privilege of being allowed to enter my laboratory. My latest experiments involve creatures from the far north. ...",
					"I've upgraded them with some experimental golem technology and those formerly wild creatures can now actually be mounted. ...",
					"For all of your good work, feel free to take one with you. Just use the golem wrench on it that you'll find in a chest nearby. Thanks again!",
				}, npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Questline, 23) -- Finish Quest
				player:setStorageValue(ShadowsOfYalahar.Mission13, 2) -- Finish Mission 13
				kv:set("telas-trade", true) -- Ability to negotiate with Telas
				player:setStorageValue(ShadowsOfYalahar.DoorFinal, 1)
				player:addAchievement("Golem in the Gears")
				player:addExperience(25000, true)
			else
				npcHandler:say("It was a long and perilous road, my friend, but we made it! I assure you, without your help this would never have been possible. Now do it my friend! Pull the lever and give life to our masterpiece!", npc, creature)
			end
		elseif player:getStorageValue(ShadowsOfYalahar.Questline) == 23 then
			npcHandler:say({
				"Admittedly, I am at a bit of loss as to specifying exactly what it is that we have created here. It is a functional golem and it is working. ...",
				"On the other hand, it seems odd and a bit self-preoccupied. It's almost as if it had some kind of sentience. ...",
				"It's even more of a marvel than I had hoped for! Absolutely fascinating! I will run a series of tests and .. and .. there is so much to be done. ...",
				"It seems my work has only just begun!",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") and (player:getStorageValue(ShadowsOfYalahar.Questline) == 17 or npcHandler:getTopic(playerId) == 4) then
		if player:getStorageValue(ShadowsOfYalahar.Questline) == 17 then
			local kv = player:kv():scoped(SOY_KV_SCOPE)
			local state = kv:get(MISSION10_STATE_KEY)

			if state == "ready" then
				local order = mission10GetOrder(kv)
				local index = kv:get(MISSION10_INDEX_KEY)
				local currentItem = mission10Items[order[index]]

				npcHandler:say(currentItem.assign, npc, creature)
				kv:set(MISSION10_STATE_KEY, "collecting")
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getStorageValue(ShadowsOfYalahar.Mission11) == 2 then
				npcHandler:say("It's done! I really hope that will be enough to enter the complex. It is probably somewhere in the underground of Fenrock. I have no idea what you might find there but look for a golem's head and bring it to me.", npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Mission11, 3) -- Finish Mission 11
				player:setStorageValue(ShadowsOfYalahar.Mission12, 1) -- Start Mission 12
				player:setStorageValue(ShadowsOfYalahar.Questline, 20)
			else
				npcHandler:say("Come back after finish your assignment.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	-- The New Frontier
	local persuasionReplies = {
		flatter = "Well, of course my worker golems are quite useful and it might indeed be a good idea to see how they operate on realistic conditions. I will send some to Farmine soon.",
		threaten = "Threatening me will get you nowhere, but I admire the boldness. Very well, let us see how my golems fare in Farmine.",
		bluff = "Faces on stomachs and golden eggs, you say? Preposterous! Still, if there is any truth to it, my golems should be there to study it. I'll send them.",
		impress = "I must admit, the scale of this whole excavation is rather impressive. Very well, I'll send some of my golems to assist.",
		reason = "Well it sounds like a good idea to test my golems in some real environment. I think it is acceptable to send some of them to Farmine.",
		plea = "Well, if the situation is that desperate I think it is possible to send some of the golems to help the poor dwarfs out of their misery.",
	}
	local persuasionKeywords = { "flatter", "threaten", "bluff", "impress", "reason", "plea" }

	if MsgContains(message, "farmine") and player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas) < 3 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 then
			if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas) == 1 then
				npcHandler:say("I have heard only little about this mine. I am a bit absorbed in my studies. But what does this mine have to do with me?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("You are starting this discussion again? Why should I listen to you this time, do you have anything to convince me to let you even try?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getStorageValue(ShadowsOfYalahar.Mission11) == 2 then
				npcHandler:say("It's done! I really hope that will be enough to enter the complex. It is probably somewhere in the underground of Fenrock. I have no idea what you might find there but look for a golem's head and bring it to me.", npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Mission11, 3) -- Finish Mission 11
				player:setStorageValue(ShadowsOfYalahar.Mission12, 1) -- Start Mission 12
				player:setStorageValue(ShadowsOfYalahar.Questline, 20)
			else
				npcHandler:say("Come back after finish your assignment.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
		if player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline) == 14 and player:removeItem(10027, 1) then
			npcHandler:say("Oh how nice of you. I might have misjudged you. So let us return to this matter of worker golems. Do you have any better arguments this time?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 1)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 2)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flatter") or MsgContains(message, "threaten") or MsgContains(message, "bluff") or MsgContains(message, "impress") or MsgContains(message, "reason") or MsgContains(message, "plea") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(10027, 1) then
				for _, keyword in ipairs(persuasionKeywords) do
					if MsgContains(message, keyword) then
						npcHandler:say(persuasionReplies[keyword], npc, creature)
						break
					end
				end
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 3)
			else
				npcHandler:say("I don't think that's a very convincing argument. I have nothing more to say about {farmine}.", npc, creature)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 2)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			for _, keyword in ipairs(persuasionKeywords) do
				if MsgContains(message, keyword) then
					npcHandler:say(persuasionReplies[keyword], npc, creature)
					break
				end
			end
			player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas, 3)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") and (npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2) then
		npcHandler:say("Come back when you find any information.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	return true
end

local function onTradeRequest(npc, creature)
	local player = Player(creature)
	local kv = player:kv():scoped(SOY_KV_SCOPE)

	if not kv:get("telas-trade", true) then
		npcHandler:say("I have nothing to trade with you.", npc, creature)
		return false
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello! Sorry I'm a bit busy.")
npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "ancient stone", clientId = 9632, sell = 200 },
	{ itemName = "battle stone", clientId = 11447, sell = 290 },
	{ itemName = "broken gladiator shield", clientId = 9656, sell = 190 },
	{ itemName = "coal", clientId = 12600, sell = 20 },
	{ itemName = "crystal of balance", clientId = 9028, sell = 1000 },
	{ itemName = "crystal of focus", clientId = 9027, sell = 2000 },
	{ itemName = "crystal of power", clientId = 9067, sell = 3000 },
	{ itemName = "crystal pedestal", clientId = 9063, sell = 500 },
	{ itemName = "crystalline spikes", clientId = 16138, sell = 440 },
	{ itemName = "flintstone", clientId = 12806, sell = 800 },
	{ itemName = "gear crystal", clientId = 9655, sell = 200 },
	{ itemName = "gear wheel", clientId = 8775, sell = 500 },
	{ itemName = "huge chunk of crude iron", clientId = 5892, sell = 15000 },
	{ itemName = "magma clump", clientId = 16130, sell = 570 },
	{ itemName = "metal spike", clientId = 10298, sell = 320 },
	{ itemName = "piece of draconian steel", clientId = 5889, sell = 3000 },
	{ itemName = "piece of hell steel", clientId = 5888, sell = 500 },
	{ itemName = "piece of hellfire armor", clientId = 9664, sell = 550 },
	{ itemName = "piece of royal steel", clientId = 5887, sell = 10000 },
	{ itemName = "pulverized ore", clientId = 16133, sell = 400 },
	{ itemName = "shiny stone", clientId = 10310, sell = 500 },
	{ itemName = "stone nose", clientId = 16137, sell = 590 },
	{ itemName = "sulphurous stone", clientId = 10315, sell = 100 },
	{ itemName = "vein of ore", clientId = 16135, sell = 330 },
	{ itemName = "war crystal", clientId = 9654, sell = 460 },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	if not shadowsOfYalaharCompleted(player) then
		return
	end
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	if not shadowsOfYalaharCompleted(player) then
		return
	end
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)
