local internalNpcName = "Mark"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 19,
	lookBody = 57,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

-- Non store outfits
local outfitList = {
	128,
	129,
	130,
	131,
	132,
	133,
	134,
	143,
	144,
	145,
	146,
	151,
	152,
	153,
	154,
	251,
	268,
	273,
	278,
	289,
	325,
	328,
	335,
	367,
	430,
	432,
	463,
	465,
	512,
	516,
	541,
	574,
	577,
	610,
	619,
	746,
	846,
	931,
	1042,
	1069,
	1094,
	1146,
	1161,
	1210,
	1243,
	1251,
	1270,
	1282,
	1288,
	1322,
	1371,
	1386,
	1436,
	1568,
	1597,
	1662,
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
	local playerId = player:getId()

	if MsgContains(message, "first") or MsgContains(message, "first addon") then
		if player:isPremium() then
			if player:getMoney() >= 10000 then
				npcHandler:say("Did you buy first addons for 10k?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("Come back when you have 10k.", npc, creature)
			end
		else
			npcHandler:say("Sorry, you need a premium account to get addons.", npc, creature)
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) then
		if doPlayerRemoveMoney(creature, 10000) then
			npcHandler:say("Congratulations! Here is your brand-new accessory, I hope you like it. Please visit us again! ", npc, creature)
			for _, addon in ipairs(outfitList) do
				player:addOutfitAddon(addon, 1) -- Add all first addon (not store)
			end
		else
			npcHandler:say("Sorry, you don't have the items I requested.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "second") or MsgContains(message, "second addon") then
		if player:isPremium() then
			if player:getMoney() >= 20000 then
				npcHandler:say("Did you bring me the 20k?", npc, creature)
				npcHandler:setTopic(playerId, 4)
			else
				npcHandler:say("Come back when you have the 20k.", npc, creature)
			end
		else
			npcHandler:say("Sorry, you need a premium account to get addons.", npc, creature)
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) then
		if doPlayerRemoveMoney(creature, 20000) then
			npcHandler:say("Congratulations! Here is your brand-new accessory, I hope you like it. Please visit us again! ", npc, creature)
			for _, addon in ipairs(outfitList) do
				player:addOutfitAddon(addon, 2) -- Add all second addon (not store)
			end
		else
			npcHandler:say("Sorry, you don't have the items I requested.", npc, creature)
		end

		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") then
		npcHandler:setTopic(playerId, 0)
		npcHandler:say("Ok then.", npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, I sell {first addon} and {second addon}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and come again, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye and come again.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
