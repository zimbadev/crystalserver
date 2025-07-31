local internalNpcName = "Enpa-Deia Pema"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1817,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 81,
	lookAddons = 1,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Peace is the true path." },
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

local MONK_QUEST = "the_way_of_the_monk_quest"

local function hasAllShrines(player)
	local kv = player:questKV(MONK_QUEST):scoped("mainShrines")
	return kv:get("guidance") and kv:get("tranquility") and kv:get("respect") and kv:get("legacy") and kv:get("empathy") and kv:get("harmony") and kv:get("power") and kv:get("knowledge") and kv:get("serenity") and kv:get("eternity")
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if MsgContains(message, "pilgrimage") then
		local kv = player:questKV(MONK_QUEST)
		if (kv:get("questline") or 0) < 3 then
			npcHandler:say("Every warrior monk takes the three-fold path at least once. It is difficult but necessary. You may now visit the shrines to honor the Merudri legacy.", npc, creature)
			kv:set("questline", 3)
			kv:set("questlog", 3)
			player:setStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.Questline, 3)
			player:setStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.Questlog, 3)
		elseif hasAllShrines(player) then
			if (kv:get("questline") or 0) == 3 then
				npcHandler:say("You have honored our legacy! On behalf of all Merudri, I thank you, venerable traveler.", npc, creature)
				kv:set("questline", 4)
				kv:set("questlog", 4)
				player:setStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.Questline, 4)
				player:setStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.Questlog, 4)
				local title = Game.getTitleByName("Pensive Wanderer")
				if title and title.id ~= 0 then
					player:addTitle(title.id)
				end
				player:addAchievement("Hope of the Merudri")
			else
				npcHandler:say("You have already completed the pilgrimage and honored our legacy.", npc, creature)
			end
		else
			npcHandler:say("Your pilgrimage is incomplete. You must visit all sacred shrines across Tibia to prove your dedication.", npc, creature)
		end
		return true
	end

	if MsgContains(message, "healing") then
		if player:getHealth() < player:getMaxHealth() then
			player:addHealth(player:getMaxHealth())
			player:removeCondition(CONDITION_POISON)
			player:removeCondition(CONDITION_FIRE)
			player:removeCondition(CONDITION_ENERGY)
			player:removeCondition(CONDITION_BLEEDING)
			player:removeCondition(CONDITION_DRUNK)
			player:removeCondition(CONDITION_DROWN)
			player:removeCondition(CONDITION_CURSED)
			player:removeCondition(CONDITION_FREEZING)
			player:removeCondition(CONDITION_DAZZLED)
			player:removeCondition(CONDITION_PARALYZE)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:say("May the Three-Fold Path restore your strength.", npc, creature)
		else
			npcHandler:say("You aren't looking really bad, |PLAYERNAME|. I can only help in cases of real emergencies. Raise your health simply by eating food.", npc, creature)
		end
		return true
	end

	return true
end

npcConfig.shop = {
	{ itemName = "boots of enlightenment", clientId = 50267, buy = 8000, sell = 80 },
	{ itemName = "coned hat of enlightenment", clientId = 50274, buy = 70000, sell = 700 },
	{ itemName = "fists of enlightenment", clientId = 50271, buy = 20000, sell = 200 },
	{ itemName = "legs of enlightenment", clientId = 50269, buy = 40000, sell = 400 },
	{ itemName = "nunchaku of enlightenment", clientId = 50273, buy = 50000, sell = 500 },
	{ itemName = "robe of enlightenment", clientId = 50268, buy = 150000, sell = 150 },
	{ itemName = "sai of enlightenment", clientId = 50272, buy = 100000, sell = 100 },
	{ itemName = "harmony amulet", clientId = 50195, buy = 1000 },
	{ itemName = "jo staff", clientId = 50171, buy = 500 },
	{ itemName = "plain monk robe", clientId = 50257, buy = 450 },
}

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, "Harmony, friend. Allow me to welcome you in the {Blue Valley}. I offer guidance for the {pilgrimage} and can provide {healing}. Or can I help you otherwise?")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, friend. Allow me to show you my wares.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May your path remain clear.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
