local internalNpcName = "Death"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 33,
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

-- Between the Lines roleplay npc (32570, 32574, 11): he only talks, he keeps no progress.
local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local player = Player(creature)
	if not player then
		return false
	end

	if MsgContains(message, "death") then
		npcHandler:say("Indeed. But do not fear me. I am not the enemy you expect. I am a companion, a {guide}, a {transition}.", npc, creature)
	elseif MsgContains(message, "guide") then
		npcHandler:say({
			"I am here to give you perspective. In your journey through Tibia, you have been confronted with darkness and {loss}. ...",
			"It is natural to fear death, the end of everything you know. But I am not the end. I am a {transition}.",
		}, npc, creature)
	elseif MsgContains(message, "transition") then
		npcHandler:say({
			"To something new. Life is a dance, and death is the turn that leads us in a new direction. Every ending is a new beginning, a blank slate, a chance for change. ...",
			"If you ask me the right questions, I can give you the insight you need to successfully complete your journey.",
		}, npc, creature)
	elseif MsgContains(message, "loss") then
		npcHandler:say("That is true, I take. But I also give something back: peace. Freedom from suffering and pain. And the memory of shared love will remain in your hearts forever.", npc, creature)
	elseif MsgContains(message, "acceptance") then
		npcHandler:say({
			"You can accept me by embracing life. By cherishing every moment, every encounter, every experience. By knowing that everything is fleeting, and that is precisely what makes it so precious. ...",
			"So hear my {advice}.",
		}, npc, creature)
	elseif MsgContains(message, "advice") then
		npcHandler:say({
			"Live! Love! Laugh! Cry! Feel! Experience everything life has to offer with all your heart. And when your time comes, go with dignity and without fear. For I will be there to welcome you. ...",
			"Now go on. Your journey is not over. And remember: death is not the end of the story. It is only a chapter. ...",
			"*He turns away, but the conversation leaves you with new thoughts and a deeper understanding*",
		}, npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, "Greetings, mortal! I am {Death} and I have waited here for you.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, |PLAYERNAME|. We will meet again.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "We will meet again.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
