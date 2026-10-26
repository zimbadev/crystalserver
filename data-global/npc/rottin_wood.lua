local internalNpcName = "Rottin Wood"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 114,
	lookBody = 118,
	lookLegs = 116,
	lookFeet = 97,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

local function getWallCount(player)
	local ok, value = pcall(function()
		return player:kv():get("rottinwood-wallcount")
	end)
	return ok and (tonumber(value) or 0) or 0
end

local function getCorpseCount(player)
	local ok, value = pcall(function()
		return player:kv():get("rottinwood-corpsecount")
	end)
	return ok and (tonumber(value) or 0) or 0
end

local function formatRemainingTime(seconds)
	if seconds <= 0 then
		return "a moment"
	end
	if seconds < 60 then
		return "less than a minute"
	end

	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)

	if hours > 0 and minutes > 0 then
		return ("%d hour%s and %d minute%s"):format(hours, hours ~= 1 and "s" or "", minutes, minutes ~= 1 and "s" or "")
	elseif hours > 0 then
		return ("%d hour%s"):format(hours, hours ~= 1 and "s" or "")
	else
		return ("%d minute%s"):format(minutes, minutes ~= 1 and "s" or "")
	end
end

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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	local S = Storage.Quest.U8_7.RottinWoodAndTheMarriedMen

	if MsgContains(message, "mission") then
		-- Mission 01
		if player:getStorageValue(S.Questline) < 1 then
			npcHandler:say("Oh, you want some work? You can help us, alright. Did you know that the people of the city think those rabbit feet are actually lucky charms?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(S.Questline) == 1 then
			npcHandler:say("Good to see you back. Now, did you bring us the lucky charms?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		-- Mission 02
		elseif player:getStorageValue(S.Questline) == 2 then
			npcHandler:say({
				"Of course, of course, there is indeed something you can help us with. Remember that we also have some tasks for you. So, are you ready for another quest to help the men of the forest?",
				"There is a problem with one of our deer stands. Right. Well, there are two problems, our deer stands - and some of the walls of the buildings in the camp are broken. ...",
				"You know, the guys built all of that themselves. Sure, at first it didn't quite work out as we planned and in the end we had to tear down half the forest - but - it was worth it. ...",
				"Still, most of the camp is kind of... broken now. And someone with a good hammer and a steady hand needs to fix that. Or I am afraid we will have to freeze... during the cold evenings... well you know, hard times. ...",
				"So what do you say, in for this one?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif player:getStorageValue(S.Questline) == 3 then
			npcHandler:say("Ah there you are. So, did you repair all the broken structures?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		-- Mission 03
		elseif player:getStorageValue(S.Questline) == 4 then
			npcHandler:say({
				"Oh |PLAYERNAME| my good friend, good to see you! Today you will help us with a very important task. Very important indeed. ...",
				"You know, a large group of merchants is travelling from Thais to Venore and they are crossing the forest to shorten their way - can you believe it? ...",
				"They will enter the forest near our camp which is where you come in - uhm I mean you do want to help us with this, right?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 6)
		elseif player:getStorageValue(S.Questline) == 5 then
			if getCorpseCount(player) >= 5 then
				npcHandler:say("You did it!! And I assume you took only what you needed? Heh. No, I know it. Because my men took the rest. Thanks for helping us, you did a very good job. In fact I have a little 'extra' for you here, thanks again.", npc, creature)
				player:addMoney(500) -- 500 gp
				player:addExperience(1000, true) -- 1000 exp
				if not player:hasAchievement("Merry Adventures") then
					player:addAchievement("Merry Adventures")
				end
				player:setStorageValue(S.Questline, 6)
				player:setStorageValue(S.Mission03, 2) -- Quest Log: Complete Mission 03
				npcHandler:setTopic(playerId, 0)
			else
				-- if fail, check cooldown to get more nets
				if (player:kv():get("nest-timer") or 0) < os.time() then
					npcHandler:say("It looks like you need more traps to finish the job. Here. Go now, and happy hunting.", npc, creature)
					player:addItem(12186, 5) -- 5 nets
					player:kv():set("rottinwood-trap-count", 0)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("I can only get you more traps in half an hour.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		else
			npcHandler:say("Thanks again for everything you did for us. I don't have any more missions for you, but I could always use a hand with a {task} or two.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end

	-- YES --
	elseif MsgContains(message, "yes") then
		-- Mission 01
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Good, because that is exactly what you will help us with - getting more 'lucky charms'. If we won't get our hands on new charms in time, we will surely have to starve... during the autumn. That would be a hard time for all of us. So... you in?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({
				"Fine, now hurry into the woods and find some rabbits. Find them and kill them that is. Use a sharp, thin knife to get the rabbit foot and be careful not to destroy it - no one would buy it in a bad condition after all. ...",
				"Once you gathered some rabbit feet, put one of our - handcrafted by the guys - ribbons on each of them. That will make two lucky charms per rabbit. ...",
				"We will need at least seven. And seven is a lucky number, don't you think? Heh. ...",
				"If you need some more ribbons just come back to me and ask.",
			}, npc, creature)
			player:setStorageValue(S.Mission01, 1) -- Quest Log: Start Mission 01
			player:setStorageValue(S.Questline, 1)
			player:addItem(12171, 7) -- Handcrafted Ribbons
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 and player:getItemCount(12173) >= 7 then
			npcHandler:say("Good hunt. That will be enough to help us uhm... get through the winter yes. Now if you want to help us getting even more lucky charms, you can always ask.", npc, creature)
			player:removeItem(12173, 7)
			player:setStorageValue(S.Questline, 2)
			player:setStorageValue(S.Mission01, 2) -- Quest Log: Complete Mission 01
			player:addMoney(500) -- 500 gp
			player:addExperience(100, true) -- 100 exp
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 and player:getItemCount(12173) <= 6 then
			npcHandler:say("You do not have sufficient rabbit's foot.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			-- Mission 02
			npcHandler:say("Good, good. Do you remember the old saying? If it ain't broken, it was not made by us. Now, off you go!", npc, creature)
			player:setStorageValue(S.Questline, 3)
			player:setStorageValue(S.Mission02, 1) -- Quest Log: Start Mission 02
			player:kv():set("rottinwood-wallcount", 0)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			if getWallCount(player) >= 6 then
				npcHandler:say({
					"Mmmmh, I have to say - good workmanship. No doubt. Yes, the person who made that tool you used to fix all this was a pure professional. Something I can't say about your work, though. ...",
					"The walls look as if they will come off in a matter of hours. Oh well, you can always come back and repair this mess, ask me for a task if you want to. Yeah, yeah and here's your reward for today.",
				}, npc, creature)
				player:setStorageValue(S.Questline, 4)
				player:setStorageValue(S.Mission02, 2) -- Quest Log: Complete Mission 02
				player:addItem(3035, 5) -- 500 gp
				player:addExperience(500, true) -- 500 exp
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Mmmmh. It seems that some walls haven't been repaired yet. Come back when you finish your mission.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
			-- Mission 03
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say({
				"Right, now before the merchants enter the woods, you will install several traps - nothing too dangerous, just nets and ropes. ...",
				"When they enter said area which is located close to our hidden camp, they will be trapped and you can... lighten their heavy burden of valuable goods. ...",
				"There is but a tiny little catch - we cannot help you laying these traps. You know, some of the guys became sick recently, we talk about several broken legs here, one almost lost his arm ...",
				"So... it's entirely up to you, will you do this or not?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 7)
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say({
				"Alright very good. Now the only thing you need to do is taking these traps and moving out to the area I have marked on your map where you need to place them. ...",
				"Once you did that go to the large high seat near the camp and watch for the travelling merchants. ...",
				"Once all of them are trapped in the nets, you can go down and gather anything of value you can find. But only take what we... you really need - around 100 gold should be enough for any man to take. ...",
				"We have manners after all, haven't we. ...",
				"My men will take their share of course and... help you relieve the merchants of any valuables. ...",
				"You're done if you get at least... let's say 5 of these fools. Return to me and you will be rewarded. ...",
				"Off you go and - good hunt, heh.",
			}, npc, creature)
			player:addItem(12186, 5) -- 5 nets
			player:setStorageValue(S.Questline, 5)
			player:setStorageValue(S.Mission03, 1) -- Quest Log: Start Mission 03
			player:kv():set("rottinwood-corpsecount", 0)
			player:kv():set("rottinwood-trap-count", 0)
			player:kv():set("nest-timer", os.time() + 30 * 60) -- 30 minutes cooldown to give 5 more nets if the player fails to get 5 merchants
			npcHandler:setTopic(playerId, 0)
		-- Lucky Loop Task
		elseif npcHandler:getTopic(playerId) == 9 then
			local luckyLoopCooldown = player:kv():get("lucky-loop-task") or 0
			if luckyLoopCooldown < os.time() then
				npcHandler:say({
					"Fine, now hurry into the woods and find some rabbits. Find them and kill them that is. Use a sharp, thin knife to get the rabbit foot and be careful not to destroy it - no one would buy it in a bad condition after all. ...",
					"Once you gathered some rabbit feet, put one of our - handcrafted by the guys - ribbons on each of them. That will make two lucky charms per rabbit. ...",
					"We will need at least seven. And seven is a lucky number, don't you think? Heh. ...",
					"If you need some more ribbons just come back to me and I will see what I can do.",
				}, npc, creature)
				player:addItem(12171, 7) -- Handcrafted Ribbons
				player:setStorageValue(S.Task01, 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say(("We appreciate the help, but you need to wait %s to repeat the task."):format(formatRemainingTime(luckyLoopCooldown - os.time())), npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 10 and player:getItemCount(12173) >= 7 then
			npcHandler:say("Good hunt. That will be enough to help us uhm... get through the winter yes. Here is your reward for today.", npc, creature)
			player:removeItem(12173, 7)
			local chance = math.random(100)
			if chance <= 90 then
				player:addMoney(500) -- 500 gp
			elseif chance <= 99 then
				player:addMoney(300) -- 300 gp
				player:addItem(3053, 1) -- time ring
			else
				player:addItem(12260, 1) -- hunting horn
			end
			player:addExperience(100, true) -- 100 experience, always granted regardless of the extra prize
			if not player:hasAchievement("Bunny Slipped") then
				player:addAchievement("Bunny Slipped")
			end
			player:setStorageValue(S.Task01, 2)
			player:kv():set("lucky-loop-task", os.time() + 20 * 60 * 60) -- 20 hours
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 10 and player:getItemCount(12173) <= 6 then
			npcHandler:say("You do not have sufficient rabbit's foot.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		-- Handyman Task
		elseif npcHandler:getTopic(playerId) == 11 then
			local handymanCooldown = player:kv():get("handyman-task") or 0
			if handymanCooldown < os.time() then
				npcHandler:say({
					"There is a problem with one of our deer stands. Right. Well, there are two problems, our deer stands - and some of the walls of the buildings in the camp are broken. ...",
					"You know, the guys built all of that themselves. Sure, at first it didn't quite work out as we planned and in the end we had to tear down half the forest - but - it was worth it. ...",
					"Still, most of the camp is kind of... broken now. And someone with a good hammer and a steady hand needs to fix that. Or I am afraid we will have to freeze... during the cold evenings... well, you know, hard times. ...",
					"So what do you say, in for this one?",
				}, npc, creature)
				player:setStorageValue(S.Task02, 1)
				player:kv():set("rottinwood-wallcount", 0)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say(("We appreciate the help, but you need to wait %s to repeat the task."):format(formatRemainingTime(handymanCooldown - os.time())), npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 12 then
			if getWallCount(player) >= 6 then
				npcHandler:say({
					"Mmmmh, I have to say - good workmanship. No doubt. Yes, the person who made that tool you used to fix all this was a pure professional. Something I can't say about your work, though. ...",
					"The walls look as if they will come off in a matter of hours. Oh well, you can always come back and repair this mess, ask me for a task if you want to. Yeah, yeah and here's your reward for today.",
				}, npc, creature)
				player:setStorageValue(S.Task02, 2)
				player:kv():set("handyman-task", os.time() + 20 * 60 * 60) -- 20 hours
				player:addExperience(500, true) -- 500 exp
				player:addMoney(500) -- 500 gp
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Mmmmh. It seems that some walls haven't been repaired yet. Come back when you finish the task.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end

	-- NO --
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				"People like to think that their personal luck will rise if they buy, wear or give away one of these rabbit feet. ...",
				"Of course you and me know that this is complete nonsense but our valued customers want to be supplied with the finest rabbit feet the forest has to offer. ...",
				"And that's exactly where you come in - helping us getting more 'lucky charms'. And if we do not get our hands on them in time, we will surely starve... during the dry period, real hard times. You in?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Mmmmh. Come back when you have all seven lucky charms.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			npcHandler:say("Thats okay. Let me know if you change your mind.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("Looks like a few walls are still broken. Come back when you finish it.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say("Mmmmh. Come back if you decide to help us again.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("Mmmmh. Come back if you decide to help us again.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 9 then
			npcHandler:say("Mmmmh. Come back if you decide to help us again.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 11 then
			npcHandler:say("Mmmmh. Come back if you decide to help us again.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end

	-- TASK --
	elseif MsgContains(message, "task") then
		local taskAccess = player:getStorageValue(S.Questline)
		if taskAccess >= 4 then
			npcHandler:say("Alright of course. You can help us getting even more {lucky charms}. There are also some {repairs} to be made around the camp. For now these are the only tasks we can offer.", npc, creature)
			npcHandler:setTopic(playerId, 8)
		elseif taskAccess >= 2 then
			npcHandler:say("Alright of course. You can help us getting even more {lucky charms}. For now that's the only task we can offer.", npc, creature)
			npcHandler:setTopic(playerId, 8)
		else
			npcHandler:say("I don't have any tasks for you yet. Come back once you have helped us a bit more.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "lucky charms") and npcHandler:getTopic(playerId) == 8 then
		local luckyLoopCooldown = player:kv():get("lucky-loop-task") or 0
		if luckyLoopCooldown > os.time() then
			npcHandler:say(("You've already helped us recently. Come back in %s if you want to help again."):format(formatRemainingTime(luckyLoopCooldown - os.time())), npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(S.Task01) == 1 then
			npcHandler:say("Good to see you back. Now, did you bring us the lucky charms?", npc, creature)
			npcHandler:setTopic(playerId, 10)
		else
			npcHandler:say("Are you ready to get more 'lucky charms'? You know, if we won't get our hands on new charms in time, we will surely have to starve... during the autumn. That would be a hard time for all of us. So... you in once again?", npc, creature)
			npcHandler:setTopic(playerId, 9)
		end
	elseif MsgContains(message, "repairs") and npcHandler:getTopic(playerId) == 8 then
		local handymanCooldown = player:kv():get("handyman-task") or 0
		if handymanCooldown > os.time() then
			npcHandler:say(("You've already helped us recently. Come back in %s if you want to help again."):format(formatRemainingTime(handymanCooldown - os.time())), npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(S.Task02) == 1 then
			npcHandler:say("Welcome back, did you repair all the broken structures?", npc, creature)
			npcHandler:setTopic(playerId, 12)
		else
			npcHandler:say("Ah yes, the sorry state of the camp... after your last repair. There is indeed a lot to do, some of the makeshift walls came down already. So, you know, would you...?", npc, creature)
			npcHandler:setTopic(playerId, 11)
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Hunter's greeting! I assume you want something from me since you came all the way out here on your own. This is a dangerous place to be, I doubt that all my men will accept strangers like I do. You don't seem to have any problems with that, though.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
