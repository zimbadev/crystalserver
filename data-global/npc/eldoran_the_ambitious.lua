local internalNpcName = "Eldoran the Ambitious"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- TODO: Confirmar outfit na wiki (lookType, cores, addons)
npcConfig.outfit = {
	lookType = 133, -- TODO: Confirmar lookType (Summoner Male?)
	lookHead = 95, -- TODO: Confirmar cor
	lookBody = 19, -- TODO: Confirmar cor
	lookLegs = 19, -- TODO: Confirmar cor
	lookFeet = 95, -- TODO: Confirmar cor
	lookAddons = 2, -- TODO: Confirmar addons
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Power is there for those bold enough to seize it." }, -- TODO: Confirmar
	{ text = "Ambition drives progress!" }, -- TODO: Confirmar
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

-- Transcription from TibiaWiki
keywordHandler:addKeyword({ "word" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "Wait, you are not one of the Stags, how did you get past the guard - can they still hold the yard?",
})

-- TODO: Implementar quest dialogue completo com callbacks para "yes" responses
keywordHandler:addKeyword({ "stag" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"Impressive. I must say, your attitude is quite to my liking. Now. There is not much we can do to get out of this stalemate unless we can breach enemy lines and get through to the warlock himself. ...",
		"You say you made it through the outskirts, passt the mines and my men in the valley. How do they fare? I hope they are well. ...",
		"My heralds did not get through to me for days now, supply lines have been cut, the harbour is out of reach and our flagship has already been destroyed in a warlock attack. ...",
		"Besides parts of the bastion being already in ruins, the warlock also attacked the tower bridge and blocked any means of entry with verminous growth of the extremely unpleasant kind. ...",
		"The same goes for the wretched remains of this once-proud bastion. Fire, destruction, plague and famine, the warlock did not spare a single one of us. ...",
		"Most of the walls are crumbling and the piling dead are poisoning us. There is a stench lingering in the catacombs as excrutiating as it is deadly. ...",
		"Now that you can picture the situation, there is the added inconvenience that we are pinned down right here. My men are to exhausted to be sent on another mission, I need you for this one. ...",
		"First we need to burn the corpses that litter the lower dungeons and poison the river. Set fire to this piles of shame and return to me with word on the situation down there. ...",
		"Afterwards I will grant you access to the lowest ward connecting the bastion with the gorge and the only remaining pathway to the warlock's tower.",
	},
})

keywordHandler:addKeyword({ "corpses" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"Most excellent! That finally gives us enough breathing room to regroup. I will see if I can send a fresh post to change the outer guard. It looks like I am in your debt, outsider. ...",
		"Thanks to you, with a dwindling number of puppets and harpies, fresh supplies for my men and most of the remaining corpses burned, we can finally start pushing back. ...",
		"There is a way down the lower catacombs, connecting the bastion with an ancient cave system, the Bloodfire Gorge. If all goes well and the warlock didn't seal this passage, there should be an entrance to his tower. ...",
		"Neverind the frazzlemaws down there, we tamed them. Besides our regular steeds, they have proven quite an asset in melee combat while gnawing through the thick of any battlefield. ...",
		"I have also granted you full access to our proud silver mines, maybe you can find something of use for your quest down there. ...",
		"Try to find the warlock and challenge him in his tower, you are as strong as the best of us. We are still holding the onslaught at bay and may be able to have your back when you confront him. ...",
		"If you can surprise him in his tower while attack his forces from the courtyard and in the outskirts, he will not amass enough of his minions to overwhelm you. We got this, now go!",
	},
})

keywordHandler:addKeyword({ "warlock" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"...let this sink a moment. Unbelievable. Outstanding! ...",
		"Please, return to Bounac, go forth and tell Kesar we are safe. My navigator sends his regards and an easier route to reach the Adaean harbour safely in the future, once this mess is all cleaned up. Deliver it to him. ...",
		"Maybe that one time we talked about trade connections was only the start of something far greater. And as to you... ...",
		"I want you to take the sword of my forefather Eldoran. As it lies broken, it shall be a reminder of how this order once was in shackles but thanks to you, ultimately prevailed. ...",
		"On behalf of all the knights of the Stag and myself, Eldoran Etzel, I bestow upon you the title of 'Honourable member of the Adaean Order of the Stag': come forth as a knight of the stag. ...",
		"May your honourable life be filled with the spirit of adventure and fueled by the fire of the hunt. You have earned it.",
	},
})

npcHandler:setMessage(MESSAGE_GREET, "Someone made it! Do you bring word from my men in the outskirts?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Until we meet again.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
