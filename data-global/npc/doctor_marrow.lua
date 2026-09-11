local internalNpcName = "Doctor Marrow"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

-- Same appearance as the Doctor Marrow boss (data-global/monster/bosses/doctor_marrow.lua).
npcConfig.outfit = {
	lookType = 1611,
	lookHead = 57,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 95,
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

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "helping") then
		npcHandler:say("Let us not confuse this situation with a plea. You need me just as much as I require your mobility and your talent for savage destructiveness. Our cooperation is simply the most efficient outcome.", npc, creature)
		return true
	end

	return true
end

-- First conversation
keywordHandler:addKeyword({ "capable" }, StdModule.say, { npcHandler = npcHandler, text = "Now that you have arrived: Welcome to my rather opulent {prison}, my reluctant allies. You may wonder what all of this is about." })
keywordHandler:addKeyword({ "prison" }, StdModule.say, { npcHandler = npcHandler, text = "A pity you cannot reach me. I imagine that would be tempting. I suppose I cannot deny that I had a hand in the mess we are currently facing. Unfortunate, really. But let me {explain}." })

-- The explanation chain
keywordHandler:addKeyword({ "explain" }, StdModule.say, { npcHandler = npcHandler, text = "Before that delightful chunk of moonrock graced Thalassara with its presence, smaller fragments had already fallen. I managed to acquire a few {samples} before the less capable minds even took interest." })
keywordHandler:addKeyword({ "samples" }, StdModule.say, { npcHandler = npcHandler, text = "Fascinating material. Truly fascinating. The properties of moonsilver are... extensive. I have only begun to scratch the surface. Yet one aspect stood out above all: its {interaction} with the mind." })
keywordHandler:addKeyword({ "interaction" }, StdModule.say, { npcHandler = npcHandler, text = "Moonsilver does not respond to just anyone. It requires focus. Simplicity. A certain... purity of purpose. Something most people sorely lack. I found it, however, in the minds of devoted {believers}." })
keywordHandler:addKeyword({ "believers" }, StdModule.say, { npcHandler = npcHandler, text = "So I located a most convenient cult. Infiltrated it. Improved it. Elevated it. In time, I became its prophet and guided it toward a more useful {purpose}." })
keywordHandler:addKeyword({ "purpose" }, StdModule.say, { npcHandler = npcHandler, text = "When the larger fragment fell upon Thalassara, I was, naturally, among the first to act. I led my followers there, secured the site, and began to harvest the moonsilver. What followed was {CREATION}!" })
keywordHandler:addKeyword({ "creation" }, StdModule.say, { npcHandler = npcHandler, text = "Marvels. Wonders. This palace of air, moonsilver and belief you see around you was merely the beginning. I was on the verge of something truly extraordinary, until {failure} struck." })
keywordHandler:addKeyword({ "failure" }, StdModule.say, { npcHandler = npcHandler, text = "I miscalculated one variable. The devotion of my followers. Their belief was not merely useful, it was absolute. And in that blind certainty, they achieved something I had not intended. They gave form to their very own {god}." })
keywordHandler:addKeyword({ "god" }, StdModule.say, { npcHandler = npcHandler, text = "Yes. An actual manifestation of a being that was never meant to exist. A construct of belief, now very real, and utterly convinced that all of Tibia belongs to it. Its ambitions can only be described as {unpleasant} at best." })
keywordHandler:addKeyword({ "unpleasant" }, StdModule.say, { npcHandler = npcHandler, text = "It has imprisoned me, deeming me 'useful'. The audacity of that insolent construct. But this is no longer about me. If this entity is not stopped, its influence will spread far beyond this place. It must be {stopped}." })
keywordHandler:addKeyword({ "stopped" }, StdModule.say, { npcHandler = npcHandler, text = "I can guide you. Its defences are not impenetrable. You must confront its most devoted servant, the majordomo. A {traitor} of the highest order towards my cause." })
keywordHandler:addKeyword({ "abomination" }, StdModule.say, { npcHandler = npcHandler, text = "Do not {hesitate}. This is a perversion of will and reality alike. End it, and perhaps we can still salvage what remains of this unfortunate... experiment." })
keywordHandler:addKeyword({ "hesitate" }, StdModule.say, { npcHandler = npcHandler, text = {
	"Fear not, as I blinded his perception towards your intrusion, I will shield you from his supposedly all seeing eye while you venture through his palace. God or not, he is no match for my scientific genius.",
	"As you see, we will be {helping} each other for our mutual benefit.",
} })

-- Side keywords
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Doctor Marrow. The name tends to precede me, usually accompanied by unflattering adjectives." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Science. Unfettered, unapologetic science." })
keywordHandler:addKeyword({ "wayland" }, StdModule.say, { npcHandler = npcHandler, text = "My assistant. A nervous little man with an admirable talent for finding capable people." })
keywordHandler:addKeyword({ "moonsilver" }, StdModule.say, { npcHandler = npcHandler, text = "The most promising material I have ever held, and the single worst decision I have ever made. Both statements are true." })

npcHandler:setMessage(MESSAGE_GREET, "Ah... Visitors. How convenient. I was beginning to wonder how long it would take until someone {capable} found their way here.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do come back once the majordomo is dealt with.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Do come back once the majordomo is dealt with.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
