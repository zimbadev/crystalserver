local internalNpcName = "Lieutenant Harlan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Outfit 1900 (the same model as the Order's knights/Raubritters), chosen by comparing the silhouette of the
-- TibiaWiki image against every outfit in the client (best overlap: 1900 facing south). Colours estimated from the
-- same image (body: 301 px, reliable; head/legs/feet: few px, approximate). No addons.
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
	{ text = "The Raubritter will pay for their crimes!" }, -- TODO: confirm
	{ text = "Stay focused, soldiers!" }, -- TODO: confirm
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

-- The Order of the Stag, optional 1 "Supplies for the Steadfast" (W): "Speak to NPC Lieutenant Harlan
-- hi, yes, yes, no, and he will open a path to the north east. Offer to help and he will ask you to
-- provide his camp with 20x Tender Venisons, and reward you with 10,000 experience points."
-- The Wiki has no transcript of his dialogue: ALL dialogue below is NOT CONFIRMED.
-- The "path to the north east" has no blocker on the map; only the progress is stored.
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local state = OrderOfTheStag.getCount(player, "Harlan")
	local topic = npcHandler:getTopic(playerId)
	local msg = message:lower()

	if msg == "yes" and topic <= 1 and state == 0 then
		if topic == 0 then
			npcHandler:say("Demeron sent you through the mines? Then you know how bad things are. Will you hear me out?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Good. My men are exhausted, but we can still hold this camp. Do you need to rest here before you move on?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
		return true
	end

	if msg == "no" and topic == 2 then
		npcHandler:setTopic(playerId, 0)
		OrderOfTheStag.setCount(player, "Harlan", 1)
		npcHandler:say("Then don't let me keep you. I will tell my men to let you pass to the north east. If you want to {help} us, come back to me.", npc, creature)
		return true
	end

	if MsgContains(message, "help") then
		if state == 0 then
			npcHandler:say("First things first. Are you with Demeron?", npc, creature)
			npcHandler:setTopic(playerId, 1)
			return true
		end

		if state >= 3 then
			npcHandler:say("Thanks to you, my men will not go hungry for a while.", npc, creature)
			return true
		end

		if player:getItemCount(OrderOfTheStag.Items.VENISON) >= OrderOfTheStag.VENISON_NEEDED then
			npcHandler:say("Is that tender venison? Will you give us 20 of them?", npc, creature)
			npcHandler:setTopic(playerId, 3)
			return true
		end

		OrderOfTheStag.setCount(player, "Harlan", 2)
		npcHandler:say("Our supplies are running out. Bring me 20 tender venisons from the stags of this isle and you will not regret it.", npc, creature)
		return true
	end

	if msg == "yes" and topic == 3 then
		npcHandler:setTopic(playerId, 0)
		if not player:removeItem(OrderOfTheStag.Items.VENISON, OrderOfTheStag.VENISON_NEEDED) then
			npcHandler:say("You don't have enough tender venison with you.", npc, creature)
			return true
		end
		OrderOfTheStag.setCount(player, "Harlan", 3)
		player:addExperience(10000, true)
		npcHandler:say("This will keep my men on their feet. Thank you, adventurer.", npc, creature)
		return true
	end

	if msg == "no" and topic ~= 0 then
		npcHandler:setTopic(playerId, 0)
		npcHandler:say("As you wish.", npc, creature)
		return true
	end

	return true
end

-- NOT CONFIRMED: greeting (answering "yes" continues the talk, as in the Wiki's hi, yes, yes, no)
npcHandler:setMessage(MESSAGE_GREET, "Hold it! Are you one of Demeron's men?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Stay alert out there.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Stay alert.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
