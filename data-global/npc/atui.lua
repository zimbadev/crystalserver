local internalNpcName = "Atui"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 533,
	lookHead = 0,
	lookBody = 95,
	lookLegs = 119,
	lookFeet = 0,
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

local LINES = {
	{ "forsaken", "It's yet another place that has been tainted by the vile touch of Doctor {Marrow}!" },
	{ "marrow", "He somehow fused animals and humans into abominations like me! But I endured. I escaped! And I swore {revenge}!" },
	{ "revenge", "I managed to follow Marrow and his new Quara allies to this {thing} here." },
	{ "thing", "It's a gigantic walking plant that Marrow somehow stumbled upon. While in hiding, I could even hear his nefarious {plans}!" },
	{ "plans", "You see, Marrow and his henchmen are here to {harvest} a precious resin from the plant. Only the gods know what he might need it for." },
	{ "harvest", "Yes, they harvest the resin, which brought them in conflict with some native plant people. Yet while harvesting the resin, Marrow found out a horrible {detail}." },
	{ "detail", "When they hurt certain plant veins, the giant plant reacts. Now he is misusing this fact, to make it walk towards the {mainland}." },
	{ "mainland", "Marrow figured he'd not only harvest the plant for its resin, he would also use the monster to pay back the {society} that shunned him and his amoral ideas." },
	{ "society", "He will use the plant monster as a weapon of mass destruction and to {devastate} whole cities!" },
	{
		"devastate",
		{
			"I have no clue what could stop the plant monster from the outside, BUT we can kill Marrow here and now. ...",
			"As soon as they stop harming the plant-thing it will probably get dormant again. So all we have to do, is to fight our way down to Marrow's lair {deep} down in the plant's stalk.",
		},
	},
	{ "deep", "We better go separate ways. I have my own, stealthy methods. You will somehow have to handle Marrow's minions and the {inhabitants} of the plant." },
	{
		"inhabitants",
		{
			"There are some native species here. Some sentient plants and the usual giant insects, you know. ...",
			"The plant people are a strange lot, however. They revere the plant as their ancestor and its amber as sacred. I know because I {talked} to them!",
		},
	},
	{
		"talked",
		{
			"Well they don't talk like we'd do! They somehow communicate directly from mind to mind. This only works for plantlife though, as far as I can tell. ...",
			"By chance, however, I found a way to {communicate} with them, so to speak.",
		},
	},
	{
		"communicate",
		{
			"Stranded here I was kind of desperate for food. I ate anything I could get. It gave me a bad stomach several times, I tell you. ...",
			"But the worst was the demon {root}, as I called it!",
		},
	},
	{ "root", "As soon as you digest it, or rather try to, the thing will burrow its roots into your system! It will give you the {headache} of a lifetime!" },
	{
		"headache",
		{
			"Turned out, that's actually a good thing! That thing seems to be rather symbiotic. As the plant people told me, it will do me no harm. ...",
			"And after death I'd become the fertiliser for a neat little tree it seems! Not that I'd care when I'm dead. However the thing has a side {effect}.",
		},
	},
	{ "effect", "Remember those roots, that burrow into your brain? Well they allow the {priests} of the plant people to communicate with you. If they like to, that is." },
	{ "priests", "Some of them are the only ones willing to interact with us! Without their help you probably won't make it to Marrow's lair." },
}

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	for _, line in ipairs(LINES) do
		if MsgContains(message, line[1]) then
			npcHandler:say(line[2], npc, creature)
			return true
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Be greeted at this {forsaken} place!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Take care.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Take care.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
