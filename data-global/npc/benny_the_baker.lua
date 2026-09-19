-- A Piece of Cake - Benny The Baker (Carlin)

local CITY_NAME = "Carlin"

local internalNpcName = "Benny The Baker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 39,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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
	local player = Player(creature)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mass") then
		local delivered = CakeQuest.get(CakeQuest.Keys.SubstancesDelivered, 0)
		npcHandler:say(("So far, %d of the %d Sweet and Sugary Substances have been delivered here in %s."):format(delivered, CakeQuest.Config.SUBSTANCE_GOAL, CITY_NAME), npc, creature)
	elseif MsgContains(message, "base") then
		local lured = CakeQuest.get(CakeQuest.Keys.GolemsLured, 0)
		npcHandler:say(("So far, %d of the %d Cake Golems have been lured to the machines."):format(lured, CakeQuest.Config.GOLEM_LURE_GOAL), npc, creature)
	elseif MsgContains(message, "substance") or MsgContains(message, "deliver") then
		if CakeQuest.getStage() ~= 1 then
			npcHandler:say("I'm not collecting anything right now, but thanks for asking!", npc, creature)
			return true
		end
		if CakeQuest.Items.SweetAndSugarySubstance == 0 then
			npcHandler:say("Hmm, I don't quite know what to do with that yet.", npc, creature)
			return true
		end

		local count = player:getItemCount(CakeQuest.Items.SweetAndSugarySubstance)
		if count <= 0 then
			npcHandler:say("You don't have any Sweet and Sugary Substances on you. Go defeat some Cake Golems!", npc, creature)
			return true
		end

		local goal = CakeQuest.Config.SUBSTANCE_GOAL
		local delivered = CakeQuest.get(CakeQuest.Keys.SubstancesDelivered, 0)
		if delivered >= goal then
			npcHandler:say("We already have all the substances we need, thank you though!", npc, creature)
			return true
		end

		local accepted = math.min(count, goal - delivered)
		player:removeItem(CakeQuest.Items.SweetAndSugarySubstance, accepted)
		delivered = delivered + accepted
		CakeQuest.set(CakeQuest.Keys.SubstancesDelivered, delivered)

		npcHandler:say(("Wonderful, thank you! You delivered %d substance(s). (%d/%d total delivered)"):format(accepted, delivered, goal), npc, creature)
		CakeQuest.checkStage1Complete()
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "I wonder if we will make it this year! Say {substance} if you want to deliver Sweet and Sugary Substances, or ask me about the {mass} of substances delivered or the {base} material lured, if you want to know how the World Quest is going.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good luck out there!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
