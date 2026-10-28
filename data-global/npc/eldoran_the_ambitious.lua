local internalNpcName = "Eldoran the Ambitious"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

-- Outfit 1900 (the same model as the Order's knights/Raubritters), chosen by comparing the silhouette of the
-- TibiaWiki image against every outfit in the client (best overlap: 1900 facing south). Colours estimated from the
-- same image (body: 301 px, reliable; head/legs/feet: few px, approximate). No addons.
npcConfig.outfit = {
	lookType = 1900,
	lookHead = 76,
	lookBody = 20,
	lookLegs = 114,
	lookFeet = 37,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: confirm whether it has voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Power is there for those bold enough to seize it." }, -- TODO: confirm
	{ text = "Ambition drives progress!" }, -- TODO: confirm
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

-- The Order of the Stag. Order (W): hi, word, yes, yes -> corpses; hi, news, yes -> report;
-- mission -> Court Warlock; after the fight hi, news -> sword + achievement Bastard (W, V).
-- Long texts: TibiaWiki (they came with the NPC). The short linking ones are NOT CONFIRMED.
local STAG_TEXT = {
	"Impressive. I must say, your attitude is quite to my liking. Now. There is not much we can do to get out of this stalemate unless we can breach enemy lines and get through to the warlock himself. ...",
	"You say you made it through the outskirts, passt the mines and my men in the valley. How do they fare? I hope they are well. ...",
	"My heralds did not get through to me for days now, supply lines have been cut, the harbour is out of reach and our flagship has already been destroyed in a warlock attack. ...",
	"Besides parts of the bastion being already in ruins, the warlock also attacked the tower bridge and blocked any means of entry with verminous growth of the extremely unpleasant kind. ...",
	"The same goes for the wretched remains of this once-proud bastion. Fire, destruction, plague and famine, the warlock did not spare a single one of us. ...",
	"Most of the walls are crumbling and the piling dead are poisoning us. There is a stench lingering in the catacombs as excrutiating as it is deadly. ...",
	"Now that you can picture the situation, there is the added inconvenience that we are pinned down right here. My men are to exhausted to be sent on another mission, I need you for this one. ...",
	"First we need to burn the corpses that litter the lower dungeons and poison the river. Set fire to this piles of shame and return to me with word on the situation down there. ...",
	"Afterwards I will grant you access to the lowest ward connecting the bastion with the gorge and the only remaining pathway to the warlock's tower.",
}

local CORPSES_TEXT = {
	"Most excellent! That finally gives us enough breathing room to regroup. I will see if I can send a fresh post to change the outer guard. It looks like I am in your debt, outsider. ...",
	"Thanks to you, with a dwindling number of puppets and harpies, fresh supplies for my men and most of the remaining corpses burned, we can finally start pushing back. ...",
	"There is a way down the lower catacombs, connecting the bastion with an ancient cave system, the Bloodfire Gorge. If all goes well and the warlock didn't seal this passage, there should be an entrance to his tower. ...",
	"Neverind the frazzlemaws down there, we tamed them. Besides our regular steeds, they have proven quite an asset in melee combat while gnawing through the thick of any battlefield. ...",
	"I have also granted you full access to our proud silver mines, maybe you can find something of use for your quest down there. ...",
	"Try to find the warlock and challenge him in his tower, you are as strong as the best of us. We are still holding the onslaught at bay and may be able to have your back when you confront him. ...",
	"If you can surprise him in his tower while attack his forces from the courtyard and in the outskirts, he will not amass enough of his minions to overwhelm you. We got this, now go!",
}

local REWARD_TEXT = {
	"...let this sink a moment. Unbelievable. Outstanding! ...",
	"Please, return to Bounac, go forth and tell Kesar we are safe. My navigator sends his regards and an easier route to reach the Adaean harbour safely in the future, once this mess is all cleaned up. Deliver it to him. ...",
	"Maybe that one time we talked about trade connections was only the start of something far greater. And as to you... ...",
	"I want you to take the sword of my forefather Eldoran. As it lies broken, it shall be a reminder of how this order once was in shackles but thanks to you, ultimately prevailed. ...",
	"On behalf of all the knights of the Stag and myself, Eldoran Etzel, I bestow upon you the title of 'Honourable member of the Adaean Order of the Stag': come forth as a knight of the stag. ...",
	"May your honourable life be filled with the spirit of adventure and fueled by the fire of the hunt. You have earned it.",
}

local function corpsesDone(player)
	return OrderOfTheStag.getCount(player, "Corpses") >= 7 -- bits 1 + 2 + 4
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local Stage = OrderOfTheStag.Stage
	local stagStage = OrderOfTheStag.getStage(player)
	local topic = npcHandler:getTopic(playerId)

	if MsgContains(message, "word") then
		npcHandler:say("Wait, you are not one of the Stags, how did you get past the guard - can they still hold the yard?", npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if MsgContains(message, "news") then
		if stagStage == Stage.CORPSES then
			npcHandler:say("Did you burn the corpses in the lower dungeons?", npc, creature)
			npcHandler:setTopic(playerId, 3)
			return true
		end

		if stagStage == Stage.WARLOCK_DEAD then
			local sword = player:addItem(OrderOfTheStag.Items.SWORD, 1)
			if not sword then
				npcHandler:say("You carry too much to take what I have for you. Come back when you have made some room.", npc, creature)
				return true
			end
			OrderOfTheStag.setStage(player, Stage.DONE)
			if not player:hasAchievement("Bastard") then
				player:addAchievement("Bastard")
			end
			npcHandler:say(REWARD_TEXT, npc, creature)
			return true
		end

		npcHandler:say("No news from the outskirts, I fear.", npc, creature)
		return true
	end

	if MsgContains(message, "mission") then
		if stagStage == Stage.LOWER_WARD then
			OrderOfTheStag.setStage(player, Stage.WARLOCK)
			npcHandler:say({
				"There is only one task left: the warlock himself. Go down to the frazzlemaws, through the Bloodfire Gorge and into the west tower. ...",
				"Captain Banner was last seen there. If anyone knows a way into his tower, it is her.",
			}, npc, creature)
			return true
		end

		if stagStage >= Stage.WARLOCK and stagStage < Stage.WARLOCK_DEAD then
			npcHandler:say("The Court Warlock still lives. Find a way into his tower through the west tower.", npc, creature)
			return true
		end
	end

	if message:lower() == "yes" then
		if topic == 1 then
			npcHandler:setTopic(playerId, 0)
			if stagStage < Stage.UPPER_HALL then
				npcHandler:say("Then go back and help Guard Captain Hartford hold the yard first.", npc, creature)
				return true
			end
			npcHandler:say("Good to hear. And you came all the way here to help the {Stags}?", npc, creature)
			npcHandler:setTopic(playerId, 2)
			return true
		end

		if topic == 2 then
			npcHandler:setTopic(playerId, 0)
			if stagStage < Stage.UPPER_HALL then
				return true
			end
			OrderOfTheStag.setStage(player, Stage.CORPSES)
			npcHandler:say(STAG_TEXT, npc, creature)
			return true
		end

		if topic == 3 then
			npcHandler:setTopic(playerId, 0)
			if not corpsesDone(player) then
				npcHandler:say("Not all of them. Three corpses are still lying down there next to the burning piles.", npc, creature)
				return true
			end
			OrderOfTheStag.setStage(player, Stage.LOWER_WARD)
			npcHandler:say(CORPSES_TEXT, npc, creature)
			return true
		end
	end

	if message:lower() == "no" and topic ~= 0 then
		npcHandler:setTopic(playerId, 0)
		npcHandler:say("Then don't waste my time.", npc, creature)
		return true
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Someone made it! Do you bring word from my men in the outskirts?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Until we meet again.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
