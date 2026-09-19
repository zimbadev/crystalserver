local npcType = Game.createNpcType("Anaztassja Moroia Vampires Lair")
local npcConfig = {}

local npcName = "Anaztassja Moroia"
npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 312,
	lookHead = 0,
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	if not player then
		return false
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheVampiresLair) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	npcHandler:setMessage(MESSAGE_GREET, "Here we are. Our progress is astonishing. Yet the next {step} will be crucial!")

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

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheVampiresLair) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	local playerId = creature:getId()

	if MsgContains(message, "step") then
		if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheVampiresLair) == 1 then
			npcHandler:say({
				"I will break the final seals that protect the heads of this despicable, orcish cabal. I need you to protect me while I concentrate on the incantation. ...",
				"They will for sure send their minions to destroy us and have them protected with magic of their own. But I have prepared weaponry and powerful magic to help you protecting me. ...",
				"Get the weapons from the chests and step on the magic symbols I prepared to receive the power of the spells that I prepared. ...",
				"Look out for the leaders amongst their ranks. If you kill them you can use my enchantments to empower my spells even more. Use that power to smite our enemies. ...",
				"Ah, and occasionally I might be able to summon a bat to assist you a little.",
			}, npc, creature, 100)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheVampiresLair, 2)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.TheBloodRitual, 1)
		end
	end

	npcHandler:resetNpc(creature)

	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
