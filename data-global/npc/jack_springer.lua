local internalNpcName = "Jack Springer"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 289,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 113,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Always be on guard." },
	{ text = "Hmm." },
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

local GraveDanger = Storage.Quest.U12_20.GraveDanger
local function greetCallback(npc, creature)
	local player = Player(creature)

	if player:getStorageValue(GraveDanger.QuestLine) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome, |PLAYERNAME|! There is much we have to {discuss}.")
	elseif player:getStorageValue(GraveDanger.QuestLine) >= 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome, |PLAYERNAME|! Is there anything to {report}?")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	local questline = player:getStorageValue(GraveDanger.QuestLine)

	-- TibiaWiki dialogue: after the 12 graves (questline 2) the player comes back and says
	-- report -> ultimate -> threat; then King Zelos' door opens (KingZelosDoor) and the mission goes to 3.
	if MsgContains(message, "report") then
		if questline == 4 then
			-- Zelos dead: the reward is given here (TibiaWiki dialogue)
			npcHandler:say("Incredible! You averted a crisis that would have utterly crippeled our defenses against any other threat that is arising. Let me grant you the honor to be one of the hands of the inquisition alongside with the according outfit as a reward.", npc, creature)
			player:setStorageValue(GraveDanger.QuestLine, 5)
			if player:getStorageValue(GraveDanger.Bosses.InquisitionOutfitReceived) < 1 then
				player:addOutfit(1244, 0)
				player:addOutfit(1243, 0)
				player:setStorageValue(GraveDanger.Bosses.InquisitionOutfitReceived, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You received the Hand of the Inquisition Outfit.")
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			end
			player:addAchievement("Inquisition's Hand")
		elseif questline == 2 then
			npcHandler:say("By now the cultists of the Shiron'Fal seem to have abandoned their search. But this is sadly no good news. It seems they gathered enough lich-knights to proceed with their {ultimate} plan.", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif questline >= 3 then
			npcHandler:say("All I can do right now is to wish you good luck and may the gods bless you.", npc, creature)
		elseif questline == 1 then
			-- NOT CONFIRMED (text written for this server): graves still missing
			npcHandler:say("There are still graves left to be secured. Return to me once all twelve of them are safe.", npc, creature)
		end
		return true
	elseif MsgContains(message, "ultimate") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say({
			"It became obvious that their goal is to raise an ancient and fallen king, to lead their lich-knights and raise even more of them. ...",
			"With each lich-knight being able to raise and control lesser undead, this would lead to a chain-reaction. If they succeed, we might face an undead {threat} not seen since the corpse wars.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 2)
		return true
	elseif MsgContains(message, "threat") and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say({
			"You have to travel to the isle of the kings. There, hidden beneath the isle of the kings is the shamefully hidden grave of king Zelos. It is him, they are trying to raise. ...",
			"With some luck you will arrive before the ritual's completion. But be warned. At least four risen lich-knights will be present, to raise 'their king'. ...",
			"Hopefully the ritual will bind some of their powers but they will still be formidable foes. You will have to act quick because with each moment you take to defeat the knights ...",
			"The ritual will progress and the king will become stronger up to a point where you might be unable to defeat him. Due to the efforts and sacrifices of the death cultists, the king will be active at some capacity and you will have to confront him. ...",
			"Remember, the further the ritual progresses when you face him, he will become considerably more powerful. So time is of the essence. ...",
			"All I can do right now is to wish you good luck and may the gods bless you.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
		if player:getStorageValue(GraveDanger.QuestLine) == 2 then
			player:setStorageValue(GraveDanger.QuestLine, 3)
			player:setStorageValue(GraveDanger.Bosses.KingZelosDoor, 1)
		end
		return true
	end

	if MsgContains(message, "late") then
		if player:getStorageValue(GraveDanger.QuestLine) < 1 then
			npcHandler:say({
				"While you travel and fight the threat where it arises, we will put all our resources into researching the ultimate plans of the legion. Perhaps I can tell you more when you {report} back. ...",
				"Don't forget that you'll need very potent holy water for your task. If you need some, just ask me for a {trade}.",
			}, npc, creature)
			player:setStorageValue(GraveDanger.QuestLine, 1)
			player:setStorageValue(GraveDanger.Graves.Edron, 1)
			player:setStorageValue(GraveDanger.Graves.DarkCathedral, 1)
			player:setStorageValue(GraveDanger.Graves.Ghostlands, 1)
			player:setStorageValue(GraveDanger.Graves.Cormaya, 1)
			player:setStorageValue(GraveDanger.Graves.FemorHills, 1)
			player:setStorageValue(GraveDanger.Graves.Ankrahmun, 1)
			player:setStorageValue(GraveDanger.Graves.Kilmaresh, 1)
			player:setStorageValue(GraveDanger.Graves.Vengoth, 1)
			player:setStorageValue(GraveDanger.Graves.Darashia, 1)
			player:setStorageValue(GraveDanger.Graves.Thais, 1)
			player:setStorageValue(GraveDanger.Graves.Orclands, 1)
			player:setStorageValue(GraveDanger.Graves.IceIslands, 1)
		end
	end
	return true
end
--Basic

npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, my friend.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- Global dialogue that was missing (keywords from opentibiabr/canary)
keywordHandler:addKeyword({ "discuss" }, StdModule.say, { npcHandler = npcHandler, text = "I need your help in a matter of utmost {urgency}." })
keywordHandler:addKeyword({ "urgency" }, StdModule.say, { npcHandler = npcHandler, text = "The situation is complicated and it's even hard to say where to {start} best, just to describe it to you." })
keywordHandler:addKeyword({ "start" }, StdModule.say, { npcHandler = npcHandler, text = "You see, several incidents in history can be traced back to a single {source}." })
keywordHandler:addKeyword({ "source" }, StdModule.say, { npcHandler = npcHandler, text = "Things get murkier the further you go down in history, but that's not even necessary. Even today we can discern a certain pattern in recent {events}." })
keywordHandler:addKeyword({ "events" }, StdModule.say, { npcHandler = npcHandler, text = {
	"Well, in Rathleton there was an individual at work, looking for some ancient artefact of power. ...",
	"To cover its escape the creature left another creature, known as the ravager to cover his tracks. But there is {more}.",
} })
keywordHandler:addKeyword({ "more" }, StdModule.say, { npcHandler = npcHandler, text = {
	"Only recently someone was trying to manipulate the elven dream courts into releasing a monstrosity of nightmares, probably planning to control or recruit this creature. ....",
	"But those incidents were just some of {many}.",
} })
keywordHandler:addKeyword({ "many" }, StdModule.say, { npcHandler = npcHandler, text = "The recent rise of lycanthropy, the robbery of certain forbidden arcane texts and the vanishing of at least three dangerous individuals, targeted by the inquisition are just the tip of the {iceberg}." })
keywordHandler:addKeyword(
	{ "iceberg" },
	StdModule.say,
	{ npcHandler = npcHandler, text = {
		"There is a scheming going on behind the scenes. Powerful good people were corrupted. Evil-doers got backup and resources from a hidden ally. ...",
		"Powerful malignant creatures, gathering their kind under their banner and so much more. These things are not happening by chance. There is a pattern, a guiding {hand}.",
	} }
)
keywordHandler:addKeyword({ "hand" }, StdModule.say, { npcHandler = npcHandler, text = "This outside force is moving behind the scenes since ages. Our research suggests that this force probably even {predates} the rise of humanity." })
keywordHandler:addKeyword({ "predates" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we are sure that the puppeteer behind all these events is an organisation. So old that even its name, the Shiron'Fal, has lost its meaning, because the {language} it originates from is long dead." })
keywordHandler:addKeyword(
	{ "language" },
	StdModule.say,
	{ npcHandler = npcHandler, text = {
		"It has a rather complex meaning and as far as we can tell it translates to 'army of those who are many, dedicated to the ultimate time of mayhem and despair'. ...",
		"Other, more handy names are army of the last battlefield, army of the last days, legion of mayhem, dread legion or simply the {legion}.",
	} }
)
keywordHandler:addKeyword(
	{ "legion" },
	StdModule.say,
	{ npcHandler = npcHandler, text = {
		"We know little for sure. You can look into our books to see some of our sources. But most are vague and some even contradictory. ...",
		"To summarise what we know, let me tell you this: The Shiron'Fal is an extremely old organisation. It seeks to accumulate power for some unknown but certainly sinister {goal}.",
	} }
)
keywordHandler:addKeyword({ "goal" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"For this purpose, the members gather knowledge, artefacts and powerful individuals. The members are formidable at certain fields of expertise. They are cunning and powerful and act with no regard for others, with no remorse or mercy. ...",
		"As they are doing this since ages, they must have acquired tremendous powers and knowledge. Their members often operate alone but are usually well funded with the necessary resources. ...",
		"Whatever their endgame might be, each of their operations pose a grave danger to the whole world and have to be {stopped}.",
	},
})
keywordHandler:addKeyword({ "stopped" }, StdModule.say, { npcHandler = npcHandler, text = "Here is where you come into play. We could identify the most recent plot of the Shiron'Fal and already had some {clashes}." })
keywordHandler:addKeyword({ "clashes" }, StdModule.say, { npcHandler = npcHandler, text = "In our efforts to hinder their plot, we achieved mixed results at best. But now things are escalating fast and we have to {hurry}." })
keywordHandler:addKeyword({ "hurry" }, StdModule.say, { npcHandler = npcHandler, text = "Our resources are already stretched thin, so we need your help with the most recent {problem}." })
keywordHandler:addKeyword({ "problem" }, StdModule.say, { npcHandler = npcHandler, text = "The legion tries to use a new form of twisted rituals to raise the bodies of well-known {knights}." })
keywordHandler:addKeyword({ "knights" }, StdModule.say, { npcHandler = npcHandler, text = {
	"The knights they aim at were tainted in life by their actions or happenstance. ...",
	"This leaves their bodies vulnerable to their special breed of necromancy that would raise them as powerful {lich}-knights.",
} })
keywordHandler:addKeyword({ "lich" }, StdModule.say, { npcHandler = npcHandler, text = "These powerful undead were a terrible threat on their own but it seems even they are just part of some larger {scheme} that we cannot make out yet." })
keywordHandler:addKeyword({ "scheme" }, StdModule.say, { npcHandler = npcHandler, text = "We are still working feverishly to uncover their goals but for now more imminent {threats} are at hand." })
keywordHandler:addKeyword({ "threats" }, StdModule.say, { npcHandler = npcHandler, text = "Death cultists of the Shiron'Fal are trying to locate the bodies of fallen knights and raise them in blasphemous {rituals}." })
keywordHandler:addKeyword({ "rituals" }, StdModule.say, { npcHandler = npcHandler, text = "The churches of the gods worked hand in hand to supply us with the means to {purge} the graves of those knights." })
keywordHandler:addKeyword({ "purge" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"Reaching the graves will not be without danger and if you encounter the death cultists you will have to fight them. Even worse, they might have even succeeded in some cases. ...",
		"As a newly risen lich-knight is not able to leave the site of its resurrection for some time, you might have to fight some of them. ...",
		"Let us pray that you never come too {late} or else some of the fiends might be able to leave their crypts.",
	},
})
keywordHandler:addKeyword({ "locations" }, StdModule.say, {
	npcHandler = npcHandler,
	text = {
		"We have located twelve graves that have to be secured: In the old northern Edron graveyard, in the dark cathedral of the plains of havoc, in the ghostlands, on Cormaya, Somewhere in the Femor Hills, on Vengoth, ...",
		"in the graveyard of Darashia, in the old temple north of Thais, at the entrance to the orcland, one is on the southern ice islands, in a mountain on Kilmaresh, one on an island north-east of Ankrahmun.",
	},
})
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Jack Springer." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am an Inquisitor." })

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "vial of potent holy water", clientId = 31612, buy = 100 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)
