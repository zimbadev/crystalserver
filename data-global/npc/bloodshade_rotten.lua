local npcType = Game.createNpcType("Bloodshade Rotten")
local npcConfig = {}

local npcName = "A Bloodshade"
npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1414,
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

local function getPlayerTaintLevel(player)
	local kv = player:kv():scoped("rotten-blood-quest")
	local currentTaintKV = kv:get("taints") or 0
	local currentTaintCondition = 0
	local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
	end
	return math.max(currentTaintKV, currentTaintCondition)
end

local function setPlayerTaintLevel(player, newTaintLevel)
	local kv = player:kv():scoped("rotten-blood-quest")
	kv:set("taints", newTaintLevel)

	for i = 0, 10 do
		player:removeCondition(CONDITION_BAKRAGORE, i)
	end

	if newTaintLevel > 0 then
		local condition = Condition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT, 0, true)
		condition:setParameter(CONDITION_PARAM_SUBID, newTaintLevel)
		condition:setParameter(CONDITION_PARAM_TICKS, -1)
		player:addCondition(condition)
	end
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	message = message:lower()

	if MsgContains(message, "taints") or MsgContains(message, "cleanse") or MsgContains(message, "purify") then
		local currentTaint = getPlayerTaintLevel(player)

		if currentTaint == 0 then
			npcHandler:say("Your soul is already pure, mortal. You carry no taint of the rotten blood.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end

		local newTaintLevel = currentTaint - 1
		npcHandler:say("I can sense " .. currentTaint .. " levels of rotten taint in your soul. I can reduce it to " .. newTaintLevel .. " level" .. (newTaintLevel == 1 and "" or "s") .. ". Do you wish me to proceed with the purification? Say {yes} to confirm or {no} to cancel.", npc, creature)
		npcHandler:setTopic(playerId, 1)
		return true
	end

	if MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
		local currentTaint = getPlayerTaintLevel(player)

		if currentTaint > 0 then
			player:removeIcon("rotten-area")
			player:removeIconBakragore()
			local newTaintLevel = currentTaint - 1

			setPlayerTaintLevel(player, newTaintLevel)

			if newTaintLevel == 0 then
				player:removeIcon("rotten-area")
				player:removeIconBakragore()
				npcHandler:say("Your soul has been completely purified! All rotten taint has been cleansed from your being. You are now free from this burden.", npc, creature)
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
				player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
			else
				npcHandler:say("I have reduced your taint from " .. currentTaint .. " to " .. newTaintLevel .. " level" .. (newTaintLevel == 1 and "" or "s") .. ". The taint icon has been updated. Return to me if you wish to purify further.", npc, creature)
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			end
		else
			npcHandler:say("Your soul is already pure. There is nothing more I can do for you.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
		return true
	end

	if MsgContains(message, "no") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Very well. Return to me if you change your mind about purifying your soul.", npc, creature)
		npcHandler:setTopic(playerId, 0)
		return true
	end

	local access = player:kv():scoped("rotten-blood-quest"):get("access") or 0
	if access == 5 then
		npcHandler:say("You already have started this quest. If you wish to cleanse your soul from rotten {taints}, I can help you with that.", npc, creature)
		npcHandler:setTopic(playerId, 0)
		return true
	end

	if MsgContains(message, "quest") then
		npcHandler:say({
			"First you must fight the two pairs of evil twins that lurk in the realm beyond here. ...",
			"Only when you are victorious over all four of them, your path to the source of vileness, the path to Bakragore will be opened. ...",
			"And even this victory will only be the beginning.",
		}, npc, creature)
		player:kv():scoped("rotten-blood-quest"):set("access", 5)
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Mortal! If you are on a {quest} to serve the blood god, my master - be greeted! I can also cleanse you from rotten {taints} that burden your soul.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
