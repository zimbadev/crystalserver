local internalNpcName = "Wayland Smythers"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 133,
	lookHead = 37,
	lookBody = 0,
	lookLegs = 76,
	lookFeet = 105,
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

	if MsgContains(message, "further") then
		npcHandler:say({
			"I ask much of you, I know. But this is no ordinary danger. If this is not stopped, all of Tibia may suffer.",
			"I cannot tell you more. Will you help? {yes} or {no}?",
		}, npc, creature)
		return true
	end

	-- Second chain: the details of the infiltration.
	if MsgContains(message, "infiltration") then
		npcHandler:say({
			"I will grant you access to the storehouse where the supply ships for Thalassara are loaded. You will have to disguise yourself as a cargo crate.",
			"Then you have to avoid the guards and reach the loading area to get stowed away on the next supply ship. Once in Thalassara you can drop the pretense and confront them with the fact that their secrecy has been compromised.",
			"Most likely they won't outright kill you as you are a hero of renown. So some diplomacy and signs of good will might be required.",
			"From there, travel to the moonstone formation in the south and find a way to infiltrate the cultists' stronghold and rendezvous with the good doctor.",
			"Are you ready to sneak through the storehouse? {Yes} or {no}?",
		}, npc, creature)
		return true
	end

	return true
end

-- The story chain, in the order the keywords unlock each other.
keywordHandler:addKeyword({ "danger" }, StdModule.say, { npcHandler = npcHandler, text = "I am but a humble messenger, sent by a scientist in desperate need. Please, {hear} me out. I have no intention to deceive you." })
keywordHandler:addKeyword({ "hear" }, StdModule.say, { npcHandler = npcHandler, text = "The one who sent me is none other than Doctor {Marrow}. I know his name carries a certain weight, so to speak. Yet what he faces now threatens far more than his reputation." })
keywordHandler:addKeyword({ "marrow" }, StdModule.say, { npcHandler = npcHandler, text = "You may have noticed the unrest of the spheres. Their harmony has been disturbed for some time, and a recent {spherequake} has even shaken the moon itself." })
keywordHandler:addKeyword({ "spherequake" }, StdModule.say, { npcHandler = npcHandler, text = "Fragments of the moon have fallen upon Tibia. Not mere stone, but something far more peculiar. Within them lies a substance known as {moonsilver}." })
keywordHandler:addKeyword({ "moonsilver" }, StdModule.say, { npcHandler = npcHandler, text = "A metal of strange and unsettling properties. It hums with power not meant for this world. Naturally, many factions seek to claim it. A particularly large fragment lies on the island of {Thalassara}." })
keywordHandler:addKeyword({ "thalassara" }, StdModule.say, { npcHandler = npcHandler, text = "They flock there like vultures, blinded by greed. My mentor, however, was less restrained by organisational formalities and secured a modest {headstart}." })
keywordHandler:addKeyword({ "headstart" }, StdModule.say, { npcHandler = npcHandler, text = "And in doing so, he uncovered something dreadful. The moonsilver is not merely a resource to be claimed. Its presence coincides with something that has taken form. Something that should not exist. That is the {threat} we are facing." })
keywordHandler:addKeyword({ "threat" }, StdModule.say, { npcHandler = npcHandler, text = "The others do not see it. They quarrel, scheme and sabotage one another, deaf to warnings. And Doctor Marrow, well, his {reputation} does him no favors." })
keywordHandler:addKeyword({ "reputation" }, StdModule.say, { npcHandler = npcHandler, text = "Call him erratic, call him dangerous, call him what you will. I call him right. This time, your path and his will {align}." })
keywordHandler:addKeyword({ "align" }, StdModule.say, { npcHandler = npcHandler, text = "He has been taken. A cunning and malevolent {entity} holds him captive. It grows stronger with each passing day, feeding on something I dare not name." })
keywordHandler:addKeyword({ "entity" }, StdModule.say, { npcHandler = npcHandler, text = "If left unchecked, it will not stop at the island. You must {find} Doctor Marrow and free him. Only he understands how this horror may be undone." })
keywordHandler:addKeyword({ "find" }, StdModule.say, { npcHandler = npcHandler, text = "I can arrange passage for you. Quietly. As a stowaway bound for Thalassara. Once there, you must earn the trust, or at least the tolerance, of the factions present. Then you can safely {proceed}." })
keywordHandler:addKeyword({ "proceed" }, StdModule.say, { npcHandler = npcHandler, text = "Head south, where the fallen fragment scarred the land. The air itself feels wrong there. You will encounter the servants of the one who keeps the doctor {captive}." })
keywordHandler:addKeyword({ "captive" }, StdModule.say, { npcHandler = npcHandler, text = "They will not welcome you. You must take from them what you need to breach their {stronghold}. Subtlety is optional. Effectiveness is not." })
keywordHandler:addKeyword({ "stronghold" }, StdModule.say, { npcHandler = npcHandler, text = "Within, you will find the doctor. Free him, and he will guide you {further}. He has seen things. Learned things." })

-- Side keywords
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Wayland Smythers, in service of science." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am an assistant. A messenger. A man who carries other men's brilliance from one place to another without dropping it." })
keywordHandler:addKeyword({ "cult", "cultists" }, StdModule.say, { npcHandler = npcHandler, text = "White robes, empty eyes and absolute conviction. A dreadful combination in any century." })
keywordHandler:addKeyword({ "moon" }, StdModule.say, { npcHandler = npcHandler, text = "It used to be a comfort in the night sky. Now a piece of it sits on Thalassara, humming." })

keywordHandler:addKeyword({ "forge" }, StdModule.say, { npcHandler = npcHandler, text = "A remarkable apparatus. The moonsilver here does not merely endure changing intent, it responds to directed intent. Doctor Marrow understood that long before anyone else did." })

keywordHandler:addKeyword({ "craft" }, StdModule.say, { npcHandler = npcHandler, text = {
	"If you have the ingredients, I can channel the power of this place into swords, axes, clubs, bows, crossbows, wands, rods and katars.",
	"But please know that this is only possible for unfused equipment that has not been treated at the Exaltation Forge.",
} })

keywordHandler:addKeyword({ "outfit" }, StdModule.say, { npcHandler = npcHandler, text = {
	"If you have collected enough radiant attire scraps, I can arrange the creation of an Illuminated Warrior for you.",
	"The full outfit requires 2500 scraps. Each addon requires 1250 more. Are you interested in the {basic} outfit, the {insignia}, or the {halo} helmet?",
} })

npcHandler:setMessage(MESSAGE_GREET, "Ah, a visitor. Allow me to introduce myself. Wayland Smythers, in service of science. I am here in search of esteemed heroes, such as yourself, to avert a grave {danger}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, and do be careful.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, and do be careful.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
