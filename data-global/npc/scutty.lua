local internalNpcName = "Scutty"
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
	lookHead = 76,
	lookBody = 0,
	lookLegs = 19,
	lookFeet = 114,
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

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar
-- The Isle of Evil Quest KVS (mission04)
local TheIsleOfEvil = Storage.Quest.U8_5.TheIsleOfEvil
local WORM_COUNT_KV = "mission04-wormcount"
local MUST_PAY_KV = "mission04-mustpay"

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local shadowsKv = player:kv():scoped("shadows-of-yalahar")
	local isleKv = player:kv():scoped("the-isle-of-evil")
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "research notes") and player:getStorageValue(ShadowsOfYalahar.Mission01) == 1 then
		if shadowsKv:get("research-scutty") then
			npcHandler:say("We've already talked about this.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say({
				"Ok, ok. Considering how much knowledge Telas was willing to share and keeping in mind that he promised to send me the results of his research I'll make an exception. I will send him the information he wants .. even a bit more. ...",
				"He'd better live up to his promises, a dwarf does not forget or forgive easily.",
			}, npc, creature)
			shadowsKv:set("research-scutty", 1)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	elseif MsgContains(message, "machine") and player:getStorageValue(TheIsleOfEvil.Mission04) == 1 then
		npcHandler:say({
			"So Rapanaio thinks I'd just hand out one of my greatest creations for a few coins of gold? Wrong! It works like this: you help me, then I'll help you. ...",
			"At the moment I'm tied up with an ongoing experiment and I could do with some help in a more mundane task. Are you in?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	elseif MsgContains(message, "mission") and player:getStorageValue(TheIsleOfEvil.Mission04) == 2 then
		if isleKv:get(MUST_PAY_KV) then
			npcHandler:say("You let one of my precious drilling worms get hurt! I'll need 500 gold to cover the damages before you can go back out there. Will you pay?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("Come back after finish your task.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	elseif MsgContains(message, "mission") and player:getStorageValue(TheIsleOfEvil.Mission04) == 3 then
		npcHandler:say("Finally! I could have shaved off and grown a new beard in the time it has taken you to complate that task. However, here is your machine. Now leave me alone, I have experiments to carry out.", npc, creature)
		player:setStorageValue(TheIsleOfEvil.Mission04, 4)
		player:addItem(9390, 1) -- machine crate
		return true
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				"Fine. As for the problem: you might know that we dwarfs sometimes use tamed rotworms to help dig our tunnels. Actually the worms we use are specially bred for that purpose. ...",
				"Though they are tame and docile they are still rotworms of course with their natural instincts. Recently some carrion worms dug their way into our drilling worm kennel. ...",
				"Though they pose no actual danger they cause our tame rotworms to panic and become agitated. ...",
				"If we leave this unchecked some of our worms might go feral and escape into the depths forever. Long story short, it's up to you to get rid of the carrion worms. Sadly, they are too cowardly to stay for a good fight. ...",
				"Instead I will lend you this hammer - the legendary'worm punisher'. Now hitting them with that hammer might teach them a lesson but it won't keep them away for long. ...",
				"Therefore you'll have to heat up the hammer on one of the ovens over there and hit a carrion worm while the hammer is still hot. That will make the silly beasts think they have hit a pocket of lava and they will retreat for good. ...",
				"I think if you scare off six of those beasts the rest will follow them. But DON'T hit any of the ordinary worms! ...",
				"If you scare them even more you will have to pay me 500 gold in compensation before I'll allow you to continue. ...",
				"As soon as you have scared away six of the carrion worms talk to me about the worms and I'll give you that machine. Do we have a deal?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Good. Here is the 'Worm punisher'. Remember DO NOT hurt the drilling worms! If you do it will cost you 500 gold!", npc, creature)
			player:setStorageValue(TheIsleOfEvil.Mission04, 2)
			player:setStorageValue(TheIsleOfEvil.Door_04, 1)
			player:addItem(9234, 1) -- worm punisher
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:removeMoney(500) then
				isleKv:set(MUST_PAY_KV, false)
				isleKv:set(WORM_COUNT_KV, 0)
				npcHandler:say("There we go. Now get back out there and be more careful with my drilling worms this time!", npc, creature)
			else
				npcHandler:say("You don't even have 500 gold on you...", npc, creature)
			end
		end
		return true
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Well, come back when you ahve the money then.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end
		return true
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello there.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
