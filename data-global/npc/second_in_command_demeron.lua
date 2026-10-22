local internalNpcName = "Second in Command Demeron"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- TibiaWiki has no image of Demeron (NOT CONFIRMED): same outfit as Lieutenant Harlan
-- (both belong to the expedition). Outfit 1900 = the model of the Order's knights.
npcConfig.outfit = {
	lookType = 1900,
	lookHead = 57,
	lookBody = 22,
	lookLegs = 114,
	lookFeet = 21,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: confirm whether it has voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Strategy wins wars, not just brute force." }, -- TODO: confirm text
	{ text = "Every detail matters in battle." }, -- TODO: confirm text
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

-- The Order of the Stag. Dialogue: TibiaWiki, transcript "Finding Heir of Eldoran".
-- Optional 2 (Emmanuelle's Boat Repair): the Wiki only lists the parts and the reward; the dialogue of
-- this part is NOT CONFIRMED.
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local Stage = OrderOfTheStag.Stage
	local stagStage = OrderOfTheStag.getStage(player)
	local topic = npcHandler:getTopic(playerId)

	if MsgContains(message, "spares") then
		if stagStage < Stage.DEMERON then
			npcHandler:say("I will get back to this later. Now either you're just a confused bystander or you're on a {mission} to get on my nerves. What will it be?", npc, creature)
			return true
		end

		local parts = OrderOfTheStag.PARTS_NEEDED
		local items = OrderOfTheStag.Items
		if OrderOfTheStag.getCount(player, "Demeron") >= 2 then
			npcHandler:say("The Emmanuelle will never be what she was, but thanks to you she might float again one day.", npc, creature)
			return true
		end

		if player:getItemCount(items.IRON) >= parts.iron and player:getItemCount(items.BRONZE) >= parts.bronze and player:getItemCount(items.SILVER) >= parts.silver then
			npcHandler:say("Are those salvaged parts for the Emmanuelle? 30 iron, 20 bronze and 10 silver parts, that is just what we need. Will you hand them over?", npc, creature)
			npcHandler:setTopic(playerId, 20)
			return true
		end

		OrderOfTheStag.setCount(player, "Demeron", 1)
		npcHandler:say({
			"The Emmanuelle is wrecked, but not beyond repair. If you come across any salvaged parts on this isle, bring them to me. ...",
			"I need 30 salvaged iron parts, 20 salvaged bronze parts and 10 salvaged silver parts. The knights that hold the castle might carry some.",
		}, npc, creature)
		return true
	end

	if MsgContains(message, "mission") and stagStage < Stage.DEMERON then
		npcHandler:say("If you can't {tell} me why you're here, stop distracting me and at least try helping some of my men knocking this measly camp into shape!", npc, creature)
		return true
	end

	if MsgContains(message, "tell") and stagStage < Stage.DEMERON then
		npcHandler:say("How did you even manage to get here with that sorry excuse of a sailing boat? So you say Kesar himself sent you, giving you details he did not disclose, even to us? And do you have any proof for that outrageous claim?", npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if message:lower() == "yes" then
		if topic == 1 then
			npcHandler:say("Royal Bounacean advisor? Why should Kesar constitute someone like you, this is saying nothing without proof. Has he really told you what this is all about?", npc, creature)
			npcHandler:setTopic(playerId, 2)
			return true
		end

		if topic == 2 then
			npcHandler:say("A bastard?! Lower your voice, stranger, that's no trifling matter. At all... you say you have solid evidence of this?", npc, creature)
			npcHandler:setTopic(playerId, 3)
			return true
		end

		if topic == 3 then
			npcHandler:setTopic(playerId, 0)
			-- the proof is the certificate from the frozen chest, brought here through Kesar
			if stagStage < Stage.TO_ADA or player:getItemCount(OrderOfTheStag.Items.CERTIFICATE) < 1 then
				npcHandler:say("Evidence? I see nothing of the sort. Come back when you can prove what you say.", npc, creature)
				return true
			end

			OrderOfTheStag.setStage(player, Stage.DEMERON)
			npcHandler:say({
				"A certificate of... oh my. That should have stirred something up in the ivory tower, heh. ...",
				"Alright... well, excuse my temper, it's all hands on deck for us since we barely set foot on this accursed rock. Let's take a break and start this conversation properly. ...",
				"We need to find the heir of this Eldoran then. His knights must be on this island somewhere, but we did not encounter any of them so far. If the threat you mentioned is real, they may be in grave danger, as are we. ...",
				"Fight your way through the mines and further into the isle. We need to get to the bottom of this and we also need to find a way to survive: there is no escaping for us in our current state.",
			}, npc, creature)
			return true
		end

		if topic == 20 then
			npcHandler:setTopic(playerId, 0)
			local parts = OrderOfTheStag.PARTS_NEEDED
			local items = OrderOfTheStag.Items
			if player:getItemCount(items.IRON) < parts.iron or player:getItemCount(items.BRONZE) < parts.bronze or player:getItemCount(items.SILVER) < parts.silver then
				npcHandler:say("You don't have all the parts with you.", npc, creature)
				return true
			end

			player:removeItem(items.IRON, parts.iron)
			player:removeItem(items.BRONZE, parts.bronze)
			player:removeItem(items.SILVER, parts.silver)
			player:addItem(items.COMPASS, 1)
			OrderOfTheStag.setCount(player, "Demeron", 2)
			npcHandler:say("Excellent! Take this compass, it was salvaged from the Antoinette. May it guide you better than it guided her.", npc, creature)
			return true
		end
	end

	if message:lower() == "no" and topic ~= 0 then
		npcHandler:setTopic(playerId, 0)
		npcHandler:say("Then move along.", npc, creature)
		return true
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "If you don't carry any spares, state your business quickly or move along.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Move along.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
