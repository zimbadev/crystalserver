local npcType = Game.createNpcType("Anaztassja Moroia Init")
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

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheGrave) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	npcHandler:setMessage(MESSAGE_GREET, "Ah, so at last you decided to answer my {call}.")

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

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheGrave) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	local playerId = creature:getId()

	if MsgContains(message, "call") then
		npcHandler:say("The world is facing a new threat of .. rather peculiar origin. The vile orc Vladrukh and his brethren managed to obtain some preserved blood of an ancient {entity}.", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "entity") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say({
			"They used the blood to turn themselves into vampires. From the initial five, only two survived the process. ...",
			"The tribe's shaman, Gloutorok, was turned into an abominable creature, cursed with eternal hunger. ...",
			"The chieftain, Vladrukh, however, did indeed usurp vampiric powers. ...",
			"Yet, due to the method of his turning, or his orcish biology, he retained his ... virility. ...",
			"He has fathered a new generation of orcs, not fully orcs, not fully vampires either. ...",
			"They are strong, resilient, full of orcish rage, yet free from the usual vampiric weaknesses. Especially, they can withstand that accursed sunlight. ...",
			"Over time, he raised an entire army of these half-breeds, turning his whole clan into such abominations. ...",
			"Now, he even invites other despicable orcs to join him, to become vampires themselves and sire more warriors for the empire he dreams to build. ...",
			"My ... master is not pleased by this prospect and cannot allow it to happen. Of course, it's beneath him to deal with orcish rabble personally. ...",
			"But as luck would have it, there are always aspiring heroes and world-savers like you to do the dirty work. ...",
			"So be good little puppies and get rid of that despicable orc. ...",
			"He hides in his lair on Vengoth ... ah, that insolence alone should earn him a painful death. He believes himself safe behind primitive wards, powered by orcish magic. ...",
			"The fool is mistaken! Orcish magic is no match for someone who has studied the arcane arts for centuries ... like me. ...",
			"And lucky for you, as your temporary ally, I will grant you my magic to pierce his protection and enter his vile lair. ...",
			"There, I shall meet you again with further instructions. Now be gone and do as your better commands you, puppy. ...",
			"Do what you're best at ... some slaughtering, some looting, and all that brutish nonsense you mortals are so fond of. ...",
			"And hurry, for you mortals, the clock is always ticking. I'd hate for my puppy to die of old age before the job is done.",
		}, npc, creature, 100)
		player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.IntoTheGrave, 2)
		player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist, 1)
	end

	npcHandler:resetNpc(creature)

	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
