local internalNpcName = "Anaztassja Moroia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

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

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	npcHandler:setMessage(MESSAGE_GREET, "There you are. Your obvious choice how to infiltrate the fortress is telling! However, there is {business} at hand?")

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

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	local playerId = creature:getId()

	if MsgContains(message, "business") then
		if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) == 1 then
			npcHandler:say({
				"The fortress is protected by several powerful wards, some are even dating back to a time where the Norcferatu were common orcs. ...",
				"And that's our inroad to break them. The ancestor spirits of the Norcferatu will not be happy of what has become of their tribe. By gaining their support, we will be able to breach the protective magic. ...",
				"Find the ancestral cave and find a way to communicate the ancestor spirits! I will put a spell on you that will enable you to see them and interact with them. ...",
				"Then convince them to assist us in stopping Vladrukh.",
			}, npc, creature, 100)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist, 2)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.TheWrathOfTheAncestorst, 1)
		elseif player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.TheNextStep) == 1 then
			npcHandler:say({
				"You have indeed appeased the spirits of the orcish ancestors. ...",
				"The deeper dungeons of blood tusk keep are warded against unwanted intruders. Only those marked as Vladrukhs kin are allowed to enter. To fool the wards you will have to undergo the baptism of blood. ...",
				"Find Vladruks bloodbath and endure the gruesome bath for long enough, to receive the mark of the vampire. ...",
				"Be warned though, a blind monstrosity will guard the bath. You will either have to be extremely quick or better trick the monster somehow, to enter the chamber.",
			}, npc, creature, 100)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.TheNextStep, 2)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Bloodbath, 1)
		end
	end

	npcHandler:resetNpc(creature)

	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
