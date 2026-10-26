local internalNpcName = "Golem Servant"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 304,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Failure is not an option!" },
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

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local REQUIRED_REPAIRS = 8
local REPAIR_TIME_LIMIT = 10 * 60

local STATE_NONE = 0
local STATE_START = 1
local STATE_HASITEM = 2
local STATE_CONTINUE = 3

local progressMessages = {
	"Task fulfilled!",
	"Initializing repairs!",
	"Excellent performance!",
	"Critical failure avoided!",
	"Total destruction averted!",
	"Repairs progressing satisfactorily.",
	"Total destruction averted!",
	"Flesh unit is functioning in acceptable parameters!",
}

local function golemServantResetRepair(player)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairActive, 0)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairProgress, 0)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairItem, -1)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairHasItem, 0)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairDeadline, -1)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairState, STATE_NONE)
end

local function golemServantRequestNextItem(npc, creature, player)
	local itemIndex = math.random(1, #GolemServantItemKeys)
	local itemKey = GolemServantItemKeys[itemIndex]
	local itemData = GolemServantItems[itemKey]

	player:setStorageValue(ShadowsOfYalahar.Mission12RepairItem, itemIndex)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairHasItem, 0)
	player:setStorageValue(ShadowsOfYalahar.Mission12RepairState, STATE_HASITEM)

	npcHandler:say(itemData.requestMessage, npc, creature)
end

local function golemServantCheckDeadline(npc, creature, player)
	if player:getStorageValue(ShadowsOfYalahar.Mission12RepairActive) ~= 1 then
		return false
	end

	local deadline = player:getStorageValue(ShadowsOfYalahar.Mission12RepairDeadline)
	if deadline > 0 and deadline < os.time() then
		npcHandler:say("Time limit exceeded! Repair procedure aborted. You must start over, flesh unit.", npc, creature)
		golemServantResetRepair(player)
		return true
	end

	return false
end

local function greetCallback(npc, creature)
	local player = Player(creature)

	if player:getStorageValue(ShadowsOfYalahar.Mission12) ~= 1 then
		npcHandler:say("Greetings!", npc, creature)
		return false
	end

	if golemServantCheckDeadline(npc, creature, player) then
		return false
	end

	if player:getStorageValue(ShadowsOfYalahar.Mission12LiftUnlocked) == 1 then
		npcHandler:say("Hello there!", npc, creature)
		return false
	end

	if player:getStorageValue(ShadowsOfYalahar.Mission12RepairActive) == 1 and player:getStorageValue(ShadowsOfYalahar.Mission12RepairState) == STATE_HASITEM then
		npcHandler:say("Do you have the required item, flesh unit?", npc, creature)
		return false
	end

	npcHandler:say("Greetings! What brings you {here}?", npc, creature)
	return false
end

keywordHandler:addKeyword({ "here" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I am a servant and maintenance golem. I also operate the {lift}.",
})

keywordHandler:addKeyword({ "name" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I require no name.",
})

keywordHandler:addKeyword({ "job" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I am a servant and maintenance golem. I also operate the lift.",
})

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if player:getStorageValue(ShadowsOfYalahar.Mission12) ~= 1 then
		return true
	end

	if golemServantCheckDeadline(npc, creature, player) then
		return true
	end

	if MsgContains(message, "lift") then
		if player:getStorageValue(ShadowsOfYalahar.Mission12LiftUnlocked) == 1 then
			npcHandler:say("The lift is fully operational, flesh unit.", npc, creature)
		else
			npcHandler:say("The lift is damaged, sir or madame flesh unit! I could initiate the repair process but I need the correct tools and parts for the repairs. If you wish to initiate the repair process ask me for {repairs}, male or female unit.", npc, creature)
		end
		return true
	end

	if MsgContains(message, "repairs") then
		if player:getStorageValue(ShadowsOfYalahar.Mission12LiftUnlocked) == 1 then
			npcHandler:say("The lift is already fully operational, flesh unit.", npc, creature)
			return true
		end

		if player:getStorageValue(ShadowsOfYalahar.Mission12RepairActive) == 1 then
			local state = player:getStorageValue(ShadowsOfYalahar.Mission12RepairState)

			if state == STATE_HASITEM then
				npcHandler:say("Do you have the required item, flesh unit?", npc, creature)
			elseif state == STATE_CONTINUE then
				npcHandler:say("Can we continue?", npc, creature)
			elseif state == STATE_START then
				npcHandler:say("Are you ready, flesh unit?", npc, creature)
			end
			return true
		end

		npcHandler:say("You must bring me the correct components or tools. The items deteriorate when they leave their conservation fields so you must be quick. Are you ready, flesh unit?", npc, creature)
		player:setStorageValue(ShadowsOfYalahar.Mission12RepairState, STATE_START)
		return true
	end

	if MsgContains(message, "yes") then
		local state = player:getStorageValue(ShadowsOfYalahar.Mission12RepairState)

		if state == STATE_START then
			player:setStorageValue(ShadowsOfYalahar.Mission12RepairActive, 1)
			player:setStorageValue(ShadowsOfYalahar.Mission12RepairProgress, 0)
			player:setStorageValue(ShadowsOfYalahar.Mission12RepairDeadline, os.time() + REPAIR_TIME_LIMIT)
			golemServantRequestNextItem(npc, creature, player)
			return true
		end

		if state == STATE_HASITEM then
			local hasItem = player:getStorageValue(ShadowsOfYalahar.Mission12RepairHasItem)

			if hasItem ~= 1 then
				npcHandler:say("Negative! You do not have the correct item yet, flesh unit!", npc, creature)
				return true
			end

			local itemIndex = player:getStorageValue(ShadowsOfYalahar.Mission12RepairItem)
			local itemKey = GolemServantItemKeys[itemIndex]
			local itemData = GolemServantItems[itemKey]
			player:removeItem(itemData.itemId, 1)

			local progress = player:getStorageValue(ShadowsOfYalahar.Mission12RepairProgress) + 1
			player:setStorageValue(ShadowsOfYalahar.Mission12RepairProgress, progress)

			if progress >= REQUIRED_REPAIRS then
				npcHandler:say("Repair procedure complete! Elevator fully operational. Ending communication. Have a nice day. Good bye.", npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Mission12LiftUnlocked, 1)
				golemServantResetRepair(player)
			else
				npcHandler:say(progressMessages[progress] .. " Repair progress " .. progress .. " / " .. REQUIRED_REPAIRS .. " ! Can we continue?", npc, creature)
				player:setStorageValue(ShadowsOfYalahar.Mission12RepairState, STATE_CONTINUE)
			end
			return true
		end

		if state == STATE_CONTINUE then
			golemServantRequestNextItem(npc, creature, player)
			return true
		end

		return true
	end

	if MsgContains(message, "no") then
		local state = player:getStorageValue(ShadowsOfYalahar.Mission12RepairState)

		if state == STATE_START then
			npcHandler:say("Understood! No repair procedure initiated.", npc, creature)
			player:setStorageValue(ShadowsOfYalahar.Mission12RepairState, STATE_NONE)
		elseif state == STATE_HASITEM then
			npcHandler:say("Then hurry up and bring it, flesh unit!", npc, creature)
		elseif state == STATE_CONTINUE then
			npcHandler:say("Understood! Repair procedure aborted. You must start over, flesh unit.", npc, creature)
			golemServantResetRepair(player)
		end
		return true
	end

	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Good .. bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good .. bye.")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
