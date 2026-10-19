local internalNpcName = "Guard Captain Hartford"
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
	{ text = "Stay alert, guards!" }, -- TODO: confirm
	{ text = "No enemy shall pass our defenses!" }, -- TODO: confirm
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

-- The Order of the Stag. Dialogue: TibiaWiki, transcript "Fightning Night Harpies".
-- The delivery (hi, news, yes) is in the Spoiler without a transcript: that dialogue is NOT CONFIRMED.
-- Beaks count by what the character skinned personally (W), not by what they carry; nothing is taken.
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local Stage = OrderOfTheStag.Stage
	local stagStage = OrderOfTheStag.getStage(player)
	local topic = npcHandler:getTopic(playerId)

	if MsgContains(message, "business") then
		npcHandler:say({
			"So you tell me you took a stroll all the way up the mountain, right through the middle of the enemy lines, past the bulk of the cursed hordes in the outskirts and in here. ...",
			"All this with a healthy disregard of our bastion's massive walls, the defense perimeter of my guards down in the dell and the influence of the warlock. {Explain} yourself.",
		}, npc, creature)
		return true
	end

	if MsgContains(message, "explain") then
		npcHandler:say({
			"I see. If Kesar himself got wind of this and decided to send help, then his court wizards must have come to the same conclusion as Eldoran. We're screwed. ...",
			"Royally so, if I might add. There is no way through the outer perimeter right now. We need to defend the castle yard and I have no men to spare. ...",
			"That's the situation. If the others are pinned down and the mines are still lost, then we cannot get outside help or supplies. ...",
			"You have been very lucky - and very bold to make an attempt like this on your own. Alas, a few warriors would indeed have a greater chance than a battallion under these circumstances. ...",
			"I say we continue to stick to that plan. Say, are you in for another round?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if MsgContains(message, "winged") then
		npcHandler:say({
			"We first encountered these winged terrors on a routine patrol through the outskirts. They must have started nesting here only recently. We never had any harpies on the isle before the warlock took service with Eldoran the Ambitious. ...",
			"So maybe there's a connection. In any case, they attack viciously but only at night. They have a roost far to the south of the island, somewhere in the mountains. But none of us is strong enough to muster a raid party.",
		}, npc, creature)
		return true
	end

	if MsgContains(message, "news") then
		if stagStage ~= Stage.BEAKS then
			npcHandler:say("Nothing new. Keep your eyes on the sky when night falls.", npc, creature)
			return true
		end
		npcHandler:say("Do you bring proof of the night harpies you have slain?", npc, creature)
		npcHandler:setTopic(playerId, 2)
		return true
	end

	if message:lower() == "yes" then
		if topic == 1 then
			npcHandler:setTopic(playerId, 0)
			if stagStage < Stage.MINES then
				npcHandler:say("First make sure the way through the mines is safe. Then we talk.", npc, creature)
				return true
			end
			OrderOfTheStag.setStage(player, Stage.BEAKS)
			npcHandler:say({
				"I counted on you. We have two main issues here: the {cursed} onslaught and the {death} from above. ...",
				"While we can still hold a considerable number of the {cursed puppets} in check, they keep coming and the warlock manages to recruit a steady amount of new material day by day. ...",
				"The numbers of order knights to succumb to the warlock's power is dwindling, for whatever reason. Yet they are increasingly difficult to defeat, the more men we lose. ...",
				"The {winged} horrors that haunt us during the night are another story entirely. We do not yet know how many of them exist or where their roost is located, but they want to occupy the bastion. ...",
				"If you can help us with those {night harpies}, we would be grateful and far in your debt. Just bring me a few of their beaks. ...",
				"To do so, gently pull the beak of a killed harpy, then press it downward and pull it slightly to the left or right in a single, firm move. It takes some skill and might not always work but I need proof of at least a few more of them dead. ...",
				"If you show your goodwill, I will give you access to the upper hall, you will be able to contact Eldoran himself, if you can get through.",
			}, npc, creature)
			return true
		end

		if topic == 2 then
			npcHandler:setTopic(playerId, 0)
			local skinned = OrderOfTheStag.getCount(player, "Beaks")
			if skinned < OrderOfTheStag.BEAKS_NEEDED then
				npcHandler:say(string.format("You have pulled %d of %d beaks so far. Bought beaks prove nothing, I need beaks you pulled yourself.", skinned, OrderOfTheStag.BEAKS_NEEDED), npc, creature)
				return true
			end
			OrderOfTheStag.setStage(player, Stage.UPPER_HALL)
			npcHandler:say("Well done. Keep the beaks, your word is enough for me now. You have access to the upper hall. Go and find Eldoran.", npc, creature)
			return true
		end
	end

	if message:lower() == "no" and topic ~= 0 then
		npcHandler:setTopic(playerId, 0)
		npcHandler:say("Then stay out of my way.", npc, creature)
		return true
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "HALT! Outsider, state your business!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Stay vigilant.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
