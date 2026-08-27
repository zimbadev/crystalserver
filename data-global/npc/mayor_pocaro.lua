local internalNpcName = "Mayor Pocaro"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 132,
	lookHead = 57,
	lookBody = 63,
	lookLegs = 124,
	lookFeet = 70,
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

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "proving") then
		npcHandler:say("Stand with us. {Help} defend this place when the next wave comes. Show us that you can be relied upon when it matters.", npc, creature)
		return true
	end

	if MsgContains(message, "help") then
		npcHandler:say({
			"Listen well. When the creatures attack, do not hesitate. Fight, hold your ground, and return to me once it is done.",
			"Only when you have proven your worth can we guarantee you a secure haven for any excursion to the {south}.",
		}, npc, creature)
		return true
	end

	-- Official transcript: reporting back after the raid.
	if MsgContains(message, "success") then
		npcHandler:say({
			"You have done your part. That will not be forgotten. Very well. If you still intend to head south, I will not stand in your way.",
			"I can even provide you with some information the other factions here do not have. One of our fishermen was brave, and foolish, enough to scavenge the ruins of Recifar.",
			"He reported seeing suspicious, white-robed figures moving about near the fallen rock. They do not appear to belong to any of the factions here.",
			"If they can somehow fend off the moonspawn, they must be quite dangerous. Perhaps you can acquire some form of disguise and infiltrate their ranks to find out what they are up to.",
		}, npc, creature)
		return true
	end

	return true
end

-- The story chain, in the order the keywords unlock each other (official transcript).
keywordHandler:addKeyword({ "settlement" }, StdModule.say, { npcHandler = npcHandler, text = "Salgadora. Or what remains of it, at least. Most of our people {fled} when the creatures came. Fisherfolk, families... gone. I stayed. Someone had to." })
keywordHandler:addKeyword({ "fled" }, StdModule.say, { npcHandler = npcHandler, text = "What you see now is no longer truly ours. The {newcomers} have taken over much of it. Researchers, mercenaries, opportunists. They build their houses, but they do not belong here." })
keywordHandler:addKeyword({ "newcomers" }, StdModule.say, { npcHandler = npcHandler, text = "They tolerate each other. Barely. Everyone watches everyone else. Alliances are temporary things in times like these. At least the fight against the {creatures} unites us all." })
keywordHandler:addKeyword({ "creatures" }, StdModule.say, { npcHandler = npcHandler, text = "We call them moonspawn. They come in waves. Relentless. Mindless. If we falter even once, this place will be {overrun}." })
keywordHandler:addKeyword({ "overrun" }, StdModule.say, { npcHandler = npcHandler, text = "When the alarm sounds, everyone who can hold a weapon is {expected} to do so. No exceptions." })
keywordHandler:addKeyword({ "expected" }, StdModule.say, { npcHandler = npcHandler, text = "If you intend to involve yourself here, then start by {proving} that you are more than just another scavenger." })
keywordHandler:addKeyword({ "south" }, StdModule.say, { npcHandler = npcHandler, text = "The south is where the {fragment} lies. Where the land itself changed. People who go there unprepared rarely return." })
keywordHandler:addKeyword({ "fragment" }, StdModule.say, { npcHandler = npcHandler, text = "That is the largest fragment said to have fallen from the moon. All of the factions here {covet} it." })
keywordHandler:addKeyword({ "covet" }, StdModule.say, { npcHandler = npcHandler, text = "Yet the moonspawn, and the constant distrust and sabotage among the factions, {prevent} any serious exploration." })
keywordHandler:addKeyword({ "prevent" }, StdModule.say, { npcHandler = npcHandler, text = "Worse still, recent rumors that someone has already begun tampering with the fragment have set everyone at each other's {throats}." })
keywordHandler:addKeyword({ "throats" }, StdModule.say, { npcHandler = npcHandler, text = "They {suspect} one another of secretly mining precious moonsilver and blindsiding the others." })
keywordHandler:addKeyword({ "suspect" }, StdModule.say, { npcHandler = npcHandler, text = {
	"I cannot tell how much of that is true, nor who might be behind it.",
	"But you, as an outsider, have far more {leeway} to head south and investigate.",
} })
keywordHandler:addKeyword({ "leeway" }, StdModule.say, { npcHandler = npcHandler, text = {
	"As I said, doing so without proving your worth would be suicidal. Earn some {trust} here, fight with us, and you will be free to explore.",
	"There are hazards enough along the way without paranoid factions deciding you are part of the problem.",
} })
keywordHandler:addKeyword({ "trust" }, StdModule.say, { npcHandler = npcHandler, text = "If you are serious about heading south, then do so with a secure {base} at your back. Earn your place here first. Then we will talk about further steps." })
keywordHandler:addKeyword({ "base" }, StdModule.say, { npcHandler = npcHandler, text = "First do your part. If you are not willing to help, stay out of the way. We have enough problems without dead heroes cluttering the streets." })

-- Side keywords
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Pocaro. Mayor of Salgadora, for whatever that is still worth." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the mayor of Salgadora. Still in service of our {kingdom}, I guess, and for what that is worth." })

keywordHandler:addKeyword({ "kingdom" }, StdModule.say, { npcHandler = npcHandler, text = {
	"This land was not always as you see it now. Long before your kind set foot here, it was known as the Coral Kingdom of Thalassara.",
	"The capital, Coralmar, stood behind {reefs} that made it unreachable from the sea. A kingdom shaped by the tides, and protected by them.",
	"That is until that rock broke off, supposedly from the moon.",
} })
keywordHandler:addKeyword({ "reefs" }, StdModule.say, { npcHandler = npcHandler, text = {
	"Even before all this, Coralmar could not be reached from the sea. The reefs would tear apart any ship that dared approach.",
	"Now? If anything still lives there, it is beyond our reach.",
} })
keywordHandler:addKeyword({ "war" }, StdModule.say, { npcHandler = npcHandler, text = {
	"Their numbers grew, while ours dwindled. The cost of holding the land became too great.",
	"So a {wall} was raised. Everything beyond it was abandoned.",
} })
keywordHandler:addKeyword({ "wall" }, StdModule.say, { npcHandler = npcHandler, text = "All who were willing were evacuated on the {king}'s decree. Those who refused, well, they stayed here. Like me." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = {
	"King {Marinho} remained in Coralmar. Or so we are told. Since the wall was sealed, no word has reached us.",
	"For all we know, the capital still stands. Though it might have long since fallen.",
} })
keywordHandler:addKeyword({ "marinho" }, StdModule.say, { npcHandler = npcHandler, text = "He is a good man. The people love him. But he listened to the wrong voices. Too many advisors, too many promises. When it mattered, he hesitated." })
keywordHandler:addKeyword({ "salgadora" }, StdModule.say, { npcHandler = npcHandler, text = "Six generations of fishermen, and now we are a mining camp with a moon problem." })
keywordHandler:addKeyword({ "thalassara" }, StdModule.say, { npcHandler = npcHandler, text = "The island was quiet before the sky broke. Now everyone with a ship and a shovel calls it theirs." })
keywordHandler:addKeyword({ "moonsilver" }, StdModule.say, { npcHandler = npcHandler, text = "It pays better than fish and it kills faster than the sea. That is all I need to know about it." })
keywordHandler:addKeyword({ "moonspawn", "moonspawns" }, StdModule.say, { npcHandler = npcHandler, text = {
	"Then came the fall. A fragment of the moon struck the south. And with it, the first of the moonspawn appeared.",
	"At first, they thought they could master them. Control them. There were even some successes.",
} })
keywordHandler:addKeyword({ "recifar" }, StdModule.say, { npcHandler = npcHandler, text = {
	"When that rock fell from the sky, it disrupted the flow of the Rionda River. The town of Recifar, once settled along its banks, suffered severely and the surrounding land sank into swamp.",
	"At first they tried irrigation and pumps, but then the moonspawn made their first appearance. In the end, the town was abandoned and lost.",
} })
keywordHandler:addKeyword({ "marrow" }, StdModule.say, { npcHandler = npcHandler, text = "The doctor? He came, he took, he vanished. If the cult has him, he earned it." })

npcHandler:setMessage(MESSAGE_GREET, "Ah, another one drawn here by the promise of moonsilver, I presume. I am the mayor of what remains of this {settlement}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Keep your head down out there.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Keep your head down out there.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
