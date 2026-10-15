local internalNpcName = "Eustacios Spy Rat"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 1346,
	lookHead = 114,
	lookBody = 95,
	lookLegs = 114,
	lookFeet = 117,
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

	if MsgContains(message, "loud") then
		npcHandler:say({
			"Been seen with creatures like thee might cause me loosing my head or even my {job}. Wouldn't even do so now if ol' Eustacio hadn't sent word an' cheese. ...",
			"Good for ye', he just recently did. Ye probably made some good progress on his behalf.",
		}, npc, creature)
	elseif MsgContains(message, "job") then
		npcHandler:say("I am a proud pirate. A hungry proud pirat that isn't treated too well and with a liking to {people} who pay with good cheese.", npc, creature)
	elseif MsgContains(message, "people") then
		npcHandler:say("Eustacio pays me good cheese for my invaluable {assistance}.", npc, creature)
	elseif MsgContains(message, "assistance") then
		npcHandler:say({
			"I got ye entrance to the secret laboratory complex and placed the enchanted rat {disguise} at the entrance. ...",
			"So ye can sneak in and sabotage the newest mouldy powder production, which ye should find in some chest in the lab.",
		}, npc, creature)
	elseif MsgContains(message, "disguise") then
		npcHandler:say({
			"It looks {convincing} in the dark or from distance. It won't fool anyone from close up, not to mention that the guards get suspicious if they don't smell a rat. ...",
			"Keep in mind that the magic will run out with time, so don't be too tardy.",
		}, npc, creature)
	elseif MsgContains(message, "convincing") then
		npcHandler:say({
			"Just stay out of lit areas and keep yer distance from the guards. ...",
			"If ye are lucky, the glowing bugs that they use as illumination lose their shining for a few moments and ye can use that to yer {advantage}.",
		}, npc, creature)
	elseif MsgContains(message, "advantage") then
		npcHandler:say("Ye'll have to be sneaky and resourceful. Use the terrain to yer advantage. Ye might even have to do some climbing. If ye are not agile enough, better bring some parcels.", npc, creature)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Psssht! Not that {loud}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Off with ye'.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Off with ye'.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
