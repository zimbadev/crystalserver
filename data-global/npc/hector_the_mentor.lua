local internalNpcName = "Hector The Mentor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 3,
	lookLegs = 20,
	lookFeet = 3,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Be careful out there!" },
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

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	-- Pending to add quest here
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Hector, pleased to meet you, traveller!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a philosopher from {Thais}, working both for {King} Tibianus as an advisor as well as mentoring new students of the {Edron} Academy. Which is also part of the reason why I'm here now." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It should be exactly |TIME| by now." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The very soil you are standing on right now." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "King Tibianus is the righteous and wise ruler I have the honour of working as an advisor for." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is the commercial and cultural centre of Tibia. There's a lot to see and do." })
keywordHandler:addKeyword({ "wolf" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Never underestimate the wolf for they are cunning creatures. Let me give you example: when the leader of a wolf pack is attacked, his female will try to get close to him, apparently to seek protection ... The female wolf often appears to hide under the male in a situation like this, actually hiding the pack leader's throat from their assailant, whilst pretending to be scared.",
})
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "I've been teaching and lecturing at Edron's academy for decades. It's an honourable faculty with many bright and talented individuals such as my dear friend and colleague {Spectulus}." })
keywordHandler:addKeyword({ "spectulus" }, StdModule.say, { npcHandler = npcHandler, text = "A dear friend of mine who I have worked with many an hour on countless projects and experiments. He's quite the character, always busy but will grow on you over time." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "A tall tale, some warriors are quite obsessed with it." })
keywordHandler:addKeyword({ "services" }, StdModule.say, { npcHandler = npcHandler, text = "I offer what equipment is left from my fellow students for {trade}. I can also provide {healing}." })
keywordHandler:addKeyword({ "start" }, StdModule.say, { npcHandler = npcHandler, text = "There are also many fellow adventurers in Tibia, don't hesitate to ask them for help or even join forces with others to overcome the many perils of this world!" })

-- Healing
keywordHandler:addKeyword({ "heal" }, StdModule.say, { npcHandler = npcHandler, text = "You are poisoned. I will help you." }, function(player)
	return player:getCondition(CONDITION_POISON) ~= nil
end, function(player)
	local health = player:getHealth()
	if health < 65 then
		player:addHealth(65 - health)
	end
	player:removeCondition(CONDITION_POISON)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
end)
keywordHandler:addKeyword({ "heal" }, StdModule.say, { npcHandler = npcHandler, text = "You are looking really bad. Let me heal your wounds." }, function(player)
	return player:getHealth() < 65
end, function(player)
	local health = player:getHealth()
	if health < 65 then
		player:addHealth(65 - health)
	end
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
end)
keywordHandler:addKeyword({ "heal" }, StdModule.say, { npcHandler = npcHandler, text = "You aren't looking really bad. Eat some food to regain strength." })

npcHandler:setMessage(MESSAGE_GREET, "Hail, traveller and welcome! I can help you getting {started}, offer various {services}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, traveller and take care!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Be careful out there!")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Certainly, surely you can make some use of this for a small obolus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "axe", clientId = 3274, sell = 7 },
	{ itemName = "bone club", clientId = 3337, sell = 5 },
	{ itemName = "bow", clientId = 3350, sell = 100 },
	{ itemName = "brass armor", clientId = 3359, sell = 150 },
	{ itemName = "brass legs", clientId = 3372, sell = 49 },
	{ itemName = "bunch of troll hair", clientId = 9689, sell = 30 },
	{ itemName = "chain helmet", clientId = 3352, sell = 17 },
	{ itemName = "cheese", clientId = 3607, buy = 5, sell = 2 },
	{ itemName = "cookie", clientId = 3598, buy = 2, sell = 1 },
	{ itemName = "crossbow", clientId = 3349, sell = 100 },
	{ itemName = "doublet", clientId = 3379, sell = 3 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150, sell = 30 },
	{ itemName = "ham", clientId = 3582, buy = 8, sell = 3 },
	{ itemName = "hand axe", clientId = 3268, sell = 4 },
	{ itemName = "hatchet", clientId = 3276, sell = 25 },
	{ itemName = "jagged sword", clientId = 7774, sell = 100 },
	{ itemName = "leather armor", clientId = 3361, sell = 12 },
	{ itemName = "leather boots", clientId = 3552, sell = 2 },
	{ itemName = "leather helmet", clientId = 3355, sell = 4 },
	{ itemName = "brass shield", clientId = 3411, sell = 25 },
	{ itemName = "carlin sword", clientId = 3283, sell = 118 },
	{ itemName = "chain armor", clientId = 3358, sell = 70 },
	{ itemName = "longsword", clientId = 3285, sell = 51 },
	{ itemName = "mace", clientId = 3286, sell = 30 },
	{ itemName = "mage hat", clientId = 7992, sell = 25 },
	{ itemName = "magician's robe", clientId = 7991, sell = 150 },
	{ itemName = "meat", clientId = 3577, sell = 2 },
	{ itemName = "pick", clientId = 3456, buy = 50, sell = 15 },
	{ itemName = "protection amulet", clientId = 3084, sell = 100 },
	{ itemName = "quiver", clientId = 35562, buy = 400, sell = 100 },
	{ itemName = "ranger legs", clientId = 8095, sell = 36 },
	{ itemName = "ranger's cloak", clientId = 3571, sell = 150 },
	{ itemName = "rapier", clientId = 3272, sell = 5 },
	{ itemName = "short sword", clientId = 3294, sell = 10 },
	{ itemName = "shovel", clientId = 3457, sell = 8 },
	{ itemName = "snakebite rod", clientId = 3066, sell = 100 },
	{ itemName = "soldier helmet", clientId = 3375, sell = 16 },
	{ itemName = "spear", clientId = 3277, sell = 3 },
	{ itemName = "spellbook", clientId = 3059, sell = 30 },
	{ itemName = "spellbook of the novice", clientId = 21400, sell = 15 },
	{ itemName = "steel shield", clientId = 3409, sell = 80 },
	{ itemName = "studded armor", clientId = 3378, sell = 25 },
	{ itemName = "studded club", clientId = 3336, sell = 10 },
	{ itemName = "studded helmet", clientId = 3376, sell = 20 },
	{ itemName = "studded legs", clientId = 3362, sell = 15 },
	{ itemName = "studded shield", clientId = 3426, sell = 16 },
	{ itemName = "wand of vortex", clientId = 3074, sell = 100 },
	{ itemName = "wolf paw", clientId = 5897, sell = 70 },
	{ itemName = "wolf tooth chain", clientId = 3012, sell = 100 },
	{ itemName = "wooden shield", clientId = 3412, sell = 5 },
	{ itemName = "worm", clientId = 3492, sell = 1 },
	{ itemName = "antidote potion", clientId = 7644, buy = 7 },
	{ itemName = "health potion", clientId = 266, buy = 50 },
	{ itemName = "small health potion", clientId = 7876, buy = 20 },
	{ itemName = "mana potion", clientId = 268, buy = 56 },
	{ itemName = "arrow", clientId = 3447, buy = 3 },
	{ itemName = "bolt", clientId = 3446, buy = 4 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "shovel", clientId = 3457, buy = 50 },
	{ itemName = "torch", clientId = 2920, buy = 2 },
	{ itemName = "worm", clientId = 3492, buy = 1 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
