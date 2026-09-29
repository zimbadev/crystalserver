local internalNpcName = "Sharai"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- TODO(outfit): placeholder until the official appearance is read from the client staticdata.
npcConfig.outfit = {
	lookType = 1961,
	lookHead = 19,
	lookBody = 0,
	lookLegs = 76,
	lookFeet = 8,
	lookAddons = 3,
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

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if not (MsgContains(message, "moon") or MsgContains(message, "machines")) then
		return true
	end

	-- Second conversation: what to do about the machines.
	if MsgContains(message, "machines") then
		npcHandler:say({
			"The machines you found are not simple constructs. They are fusing moonsilver and magic. Breaking them blindly would release the power they contain in an uncontrolled way.",
			"Instead, you should try to interrupt the flow of energy between the moon shard and the devices. To do this, you would probably need to contain or seal the power of the moonsilver in some way.",
			"When it comes to understanding and controlling the powers of the moon, particularly her destructive and dangerous aspects, you should turn to the inhabitants of Oskayaat.",
			"They have brought the were sickness under control. They may well be able to offer advice on this matter too.",
		}, npc, creature)
		return true
	end

	-- First conversation: only once the crater has been found.
	npcHandler:say({
		"I see, you are searching for the scar left upon Tibia's skin by the falling light. I saw how it happened.",
		"A few nights ago, a fragment broke away from the moon and fell into the sea, like a piece of silent light. It came down right here. But you are not the only one who has heard this stone's call.",
		"Something is stirring down there, something dangerous. Deep beneath this place lies an ancient complex. Once its halls towered above the waves, but the sea is patient.",
		"Century after century, it rose higher until the walls were submerged. If you wish to descend and take a closer look, you won't find a way here, near the crater.",
		"Look further south, near the coast. There lies a pile of large stones. Hidden beneath them is an ancient tunnel leading into the complex.",
		"You will easily recognise the stones: Those who now claim the place have painted them with silver moon runes.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Sharai." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I watch this stretch of coast. Lately it has been giving me plenty to watch." })
keywordHandler:addKeyword({ "complex", "citadel" }, StdModule.say, { npcHandler = npcHandler, text = "An asura complex, drowned centuries ago. The sea took it slowly, wall by wall." })
keywordHandler:addKeyword({ "asura", "asuri" }, StdModule.say, { npcHandler = npcHandler, text = "They claim the place now. Not all of them agree on what to do with it, which is the only good news." })
keywordHandler:addKeyword({ "oskayaat" }, StdModule.say, { npcHandler = npcHandler, text = "They learned to live with the moon's darker face. If anyone can seal that shard, it is them." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, two-leg.")
npcHandler:setMessage(MESSAGE_FAREWELL, "The sea remembers everything, two-leg.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "The sea remembers everything, two-leg.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
