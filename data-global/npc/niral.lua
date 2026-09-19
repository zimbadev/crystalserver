local internalNpcName = "Niral"
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
	lookType = 1648,
	lookHead = 57,
	lookBody = 95,
	lookLegs = 114,
	lookFeet = 104,
	lookAddons = 2,
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

	if not (MsgContains(message, "moon") or MsgContains(message, "seal") or MsgContains(message, "consecrate")) then
		return true
	end

	-- Third conversation: consecrating the lava.
	if MsgContains(message, "consecrate") then
		npcHandler:say({
			"You really collected some blue lava. Well done! I will consecrate it, so that you can draw the runes. Wait a moment ... *Niral murmurs some prayers to Amati*",
			"There! The blue lava is now blessed by the moon goddess herself. Pour it out carefully to draw the runes. Draw them on the floor near the larger crystal constructs.",
			"The four runes are the sigil of the silent moon, the silverflow rune, the mark of the veiled night and the fallen star glyph.",
		}, npc, creature)

		return true
	end

	-- Second conversation: Rakesh is dead, here is how to seal the shard.
	if MsgContains(message, "seal") then
		npcHandler:say({
			"You have done what had to be done, I can feel it. Rakesh's suffering has ended as has the danger he posed. If you wish to stop the asuri, the solution is not to destroy.",
			"The nagas would certainly not approve of any part of Amati herself being damaged. Nor would I.",
			"You must seal the moon shard beneath Marapur so that the asuri can no longer extract moonsilver from it. There are magical runes that can bring this about.",
			"You are already familiar with them, as we used them to save Oskayaat from the curse of uncontrolled were sickness. But this time they must be drawn using a very specific substance:",
			"blue lava, consecrated by a priest or priestess of Amati. I can consecrate the lava, but you have to procure it.",
		}, npc, creature)
		return true
	end

	-- First conversation.
	npcHandler:say({
		"You carry the scent of moonsilver with you. Yes, I know about it. The disturbances have reached even Oskayaat. So the asuri draw power from a moon fragment that fell from the sky.",
		"You wish to stop them and that is wise. But the asuri are not the only ones who have felt the moonsilver's call. Some among my own kind believe the moonsilver is a gift.",
		"A way to strengthen the beast within. They are wrong. Power taken without balance always demands a price. One of our own has already crossed that line.",
		"A werepanther by the name of Rakesh Moonfang has infused his body with moonsilver. What remains of him is no longer guided by instinct or spirit. He is out of control and dangerous.",
		"If you seek my help, I ask you to deal with him first. Return to me if you have done so. I will show you how to silence the moonsilver without unleashing destruction.",
		"Now go, friend. You find the entrance to Rakesh's lair one floor up, in the southern part of the temple's moon wing. And remember: The beast can be controlled, the moon cannot.",
	}, npc, creature)
	return true
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Niral." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I keep the balance between the beast and the person here in Oskayaat." })
keywordHandler:addKeyword({ "rakesh" }, StdModule.say, { npcHandler = npcHandler, text = "He was one of us. Then he filled himself with moonsilver and stopped being anyone at all." })
keywordHandler:addKeyword({ "amati" }, StdModule.say, { npcHandler = npcHandler, text = "The moon goddess. We do not worship her the way the nagas do, but we respect what she can do." })
keywordHandler:addKeyword({ "runes" }, StdModule.say, { npcHandler = npcHandler, text = "The same runes that ended our uncontrolled were sickness. Drawn in blessed blue lava, they will silence the shard." })
keywordHandler:addKeyword({ "blue lava" }, StdModule.say, { npcHandler = npcHandler, text = "It runs in the old volcano on the eastern coast. Take a crystal flask and wear your moon mirror, or the heat will have you." })
keywordHandler:addKeyword({ "were sickness", "curse" }, StdModule.say, { npcHandler = npcHandler, text = "The beast can be controlled. The moon cannot. Never confuse the two." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, traveller!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Walk in balance, traveller.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Walk in balance, traveller.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
