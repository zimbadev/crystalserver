local internalNpcName = "An Orchish Ancestor Spirit"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = "an orchish ancestor spirit"

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1268,
	lookHead = 82,
	lookBody = 82,
	lookLegs = 82,
	lookFeet = 82,
	lookAddons = 0,
	lookMount = 0,
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	if not player then
		return false
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.TheWrathOfTheAncestorst) < 1 then
		npcHandler:removeInteraction(npc, player)
		return false
	end

	npcHandler:setMessage(MESSAGE_GREET, "You will have to {appease} us, to gain our support!")

	return true
end

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local player = Player(creature)
	if not player then
		return false
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.TheWrathOfTheAncestorst) < 1 then
		npcHandler:removeInteraction(npc, player)
		return false
	end

	if MsgContains(message, "appease") then
		npcHandler:say({
			"Long have our bones rested beneath crimson soil, our spirits watching as bloodlines thinned, purpose faded, our legacy defiled and our bloodline corrupted. ....",
			"But now, the red full moon shall rises once more. and with it, the call of the old ways. If you seek our favor, outsiders, you must honor the rites of our kin. ....",
			"Dance for us! Not with feet alone, but with fire in your blood and rhythm in your soul. Step into the circle, feel the pulse of the earth, and sway with the echo of ages past. ...",
			"Only through the Ritual Dance of the Red Moon shall you earn our blessing. Gain our approval! Dance for us!",
		}, npc, creature, 100)
		player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.TheWrathOfTheAncestorst, 2)
		player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.DanceOfDeath, 1)
	end

	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
