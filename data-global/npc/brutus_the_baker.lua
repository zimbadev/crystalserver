-- A Piece of Cake - Brutus The Baker

local internalNpcName = "Brutus The Baker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 39,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local errand = CakeQuest.getBrutusErrand(player)
	local completed = #errand.visitedCities >= 5

	if MsgContains(message, "help") then
		if completed then
			npcHandler:say("You've already visited all five extraction machines - well done! Say {reward} to hear about your prize.", npc, creature)
			return true
		end

		if errand.started then
			npcHandler:say(("You're already helping! You've visited %d of the 5 extraction machines so far. Remember: step on the Cake Base between each visit!"):format(#errand.visitedCities), npc, creature)
			return true
		end

		errand.started = true
		CakeQuest.setBrutusErrand(player, errand)
		npcHandler:say(
			"Yes, yes! Just step somewhere on the cake base on the isle. Then travel to one of our ingredient extractors at Thais, Carlin, Darashia, Liberty Bay and Edron. They will extract the cake mass that is stuck on you. So if you want to feed another extractor, you'll have to visit the isle again of course. If you manage to feed all five extractors before the time runs out, I will give you a special reward.",
			npc,
			creature
		)
	elseif MsgContains(message, "reward") or MsgContains(message, "yes") then
		npcHandler:say("Well, not all our experiments with Kullu's recipes went well. But even the failures are good for something. We used them to create some beautiful as well as practical pieces of furniture, storage and decoration. If you are interested - and have fed all five extractors with cake mass that is stuck on you -, I can hand you one.", npc, creature)
	elseif MsgContains(message, "one") then
		npcHandler:say("You have a choice of three rewards. If you didn't already claim your reward, you can tell me which one you want: a cake cabinet, a cake backpack or a cake tapestry. I will also give you a very sweet and tasty cupcake, if you want one. What are you interested in?", npc, creature)
	elseif MsgContains(message, "cabinet") or MsgContains(message, "backpack") or MsgContains(message, "tapestry") then
		if not completed then
			npcHandler:say("I am sorry, but you did not earn your reward yet.", npc, creature)
			return true
		end
		if errand.itemRewardGiven then
			npcHandler:say("Sorry, but you already got a reward this year.", npc, creature)
			return true
		end

		if MsgContains(message, "cabinet") then
			player:addItem(CakeQuest.Items.CakeCabinetKit, 1)
		elseif MsgContains(message, "backpack") then
			player:addItem(CakeQuest.Items.CakeBackpack, 1)
		else
			player:addItem(CakeQuest.Items.CakeTapestry, 1)
		end

		errand.itemRewardGiven = true
		CakeQuest.setBrutusErrand(player, errand)
		npcHandler:say("Here it is. Handle it with care.", npc, creature)
	elseif MsgContains(message, "cupcake") then
		if not completed then
			npcHandler:say("I am sorry, but you did not earn your reward yet.", npc, creature)
			return true
		end
		if errand.cupcakeRewardGiven then
			npcHandler:say("Sorry, but you already got a cupcake this year.", npc, creature)
			return true
		end

		npcHandler:say("You can have a blueberry cupcake, a strawberry cupcake or a lemon cupcake. Blueberries will regenerate your mana, strawberries are able to heal your wounds and lemons can steady your hand and sharpen your eyes. So, which one do you want?", npc, creature)
	elseif MsgContains(message, "blueberry") or MsgContains(message, "strawberry") or MsgContains(message, "lemon") then
		if not completed then
			npcHandler:say("I am sorry, but you did not earn your reward yet.", npc, creature)
			return true
		end
		if errand.cupcakeRewardGiven then
			npcHandler:say("Sorry, but you already got a cupcake this year.", npc, creature)
			return true
		end

		if MsgContains(message, "blueberry") then
			player:addItem(CakeQuest.Items.CupcakeBlueberry, 1)
		elseif MsgContains(message, "strawberry") then
			player:addItem(CakeQuest.Items.CupcakeStrawberry, 1)
		else
			player:addItem(CakeQuest.Items.CupcakeLemon, 1)
		end

		errand.cupcakeRewardGiven = true
		CakeQuest.setBrutusErrand(player, errand)
		npcHandler:say("Here it is. Enjoy your meal!", npc, creature)
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! Say {help} if you want to help me clean up after the big cake event.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Thanks for stopping by!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
