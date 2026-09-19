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
	if not (MsgContains(message, "hi") or MsgContains(message, "hello")) then
		npcHandler:say("Where .. am I??", npc, creature)
	end
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local SOY_KV_SCOPE = "shadows-of-yalahar"
local ACTIVE_KEY = "golem-servant-active"
local PROGRESS_KEY = "golem-servant-progress"
local CURRENT_ITEM_KEY = "golem-servant-current-item"
local HAS_ITEM_KEY = "golem-servant-has-item"
local DEADLINE_KEY = "golem-servant-deadline"
local STATE_KEY = "golem-servant-state"
local LIFT_UNLOCKED_KEY = "golem-servant-lift-unlocked"

local REQUIRED_REPAIRS = 8
local REPAIR_TIME_LIMIT = 10 * 60 -- 10 min

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

local function golemServantResetRepair(kv)
	kv:remove(ACTIVE_KEY)
	kv:remove(PROGRESS_KEY)
	kv:remove(CURRENT_ITEM_KEY)
	kv:remove(HAS_ITEM_KEY)
	kv:remove(DEADLINE_KEY)
	kv:remove(STATE_KEY)
end

local function golemServantRequestNextItem(npc, creature, kv)
	local itemKey = GolemServantItemKeys[math.random(1, #GolemServantItemKeys)]
	local itemData = GolemServantItems[itemKey]

	kv:set(CURRENT_ITEM_KEY, itemKey)
	kv:set(HAS_ITEM_KEY, false)
	kv:set(STATE_KEY, "hasitem")

	npcHandler:say(itemData.requestMessage, npc, creature)
end

local function golemServantCheckDeadline(npc, creature, kv)
	local active = kv:get(ACTIVE_KEY)
	if active ~= true then
		return false
	end

	local deadlineValue = kv:get(DEADLINE_KEY)
	if deadlineValue < os.time() then
		npcHandler:say("Time limit exceeded! Repair procedure aborted. You must start over, flesh unit.", npc, creature)
		golemServantResetRepair(kv)
		return true
	end

	return false
end

local function greetCallback(npc, creature)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(ShadowsOfYalahar.Mission12) == 1 then
		local kv = player:kv():scoped(SOY_KV_SCOPE)

		if golemServantCheckDeadline(npc, creature, kv) then
			return false
		end

		local liftUnlocked = kv:get(LIFT_UNLOCKED_KEY)
		if liftUnlocked == true then
			npcHandler:say("Hello there!", npc, creature)
			return false
		end

		local active = kv:get(ACTIVE_KEY)
		local state = kv:get(STATE_KEY)

		if active == true and state == "hasitem" then
			npcHandler:say("Do you have the required item, flesh unit?", npc, creature)
			return false
		end

		npcHandler:say("Greetings! What brings you {here}?", npc, creature)
		return false
	else
		npcHandler:say("Greetings!", npc, creature)
		return false
	end
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if player:getStorageValue(ShadowsOfYalahar.Mission12) ~= 1 then
		return true
	end

	local kv = player:kv():scoped(SOY_KV_SCOPE)

	if golemServantCheckDeadline(npc, creature, kv) then
		return true
	end

	if MsgContains(message, "here") then
		npcHandler:say("I am a servant and maintenance golem. I also operate the {lift}.", npc, creature)
	elseif MsgContains(message, "lift") then
		local liftUnlocked = kv:get(LIFT_UNLOCKED_KEY)
		if liftUnlocked == true then
			npcHandler:say("The lift is fully operational, flesh unit.", npc, creature)
		else
			npcHandler:say("The lift is damaged, sir or madame flesh unit! I could initiate the repair process but I need the correct tools and parts for the repairs. If you wish to initiate the repair process ask me for {repairs}, male or female unit.", npc, creature)
		end
	elseif MsgContains(message, "name") then
		npcHandler:say("I require no name.", npc, creature)
	elseif MsgContains(message, "job") then
		npcHandler:say("I am a servant and maintenance golem. I also operate the lift.", npc, creature)
	elseif MsgContains(message, "repairs") then
		local liftUnlocked = kv:get(LIFT_UNLOCKED_KEY)
		if liftUnlocked == true then
			npcHandler:say("The lift is already fully operational, flesh unit.", npc, creature)
			return true
		end

		local active = kv:get(ACTIVE_KEY)
		if active == true then
			local state = kv:get(STATE_KEY)

			if state == "hasitem" then
				npcHandler:say("Do you have the required item, flesh unit?", npc, creature)
			elseif state == "continue" then
				npcHandler:say("Can we continue?", npc, creature)
			elseif state == "start" then
				npcHandler:say("Are you ready, flesh unit?", npc, creature)
			end
			return true
		end

		npcHandler:say("You must bring me the correct components or tools. The items deteriorate when they leave their conservation fields so you must be quick. Are you ready, flesh unit?", npc, creature)
		kv:set(STATE_KEY, "start")
	elseif MsgContains(message, "yes") then
		local state = kv:get(STATE_KEY)
		local stateValue = state or nil

		if stateValue == "start" then
			kv:set(ACTIVE_KEY, true)
			kv:set(PROGRESS_KEY, 0)
			kv:set(DEADLINE_KEY, os.time() + REPAIR_TIME_LIMIT)
			golemServantRequestNextItem(npc, creature, kv)
		elseif stateValue == "hasitem" then
			local currentItemKey = kv:get(CURRENT_ITEM_KEY)
			local hasItem = kv:get(HAS_ITEM_KEY)

			if hasItem ~= true then
				npcHandler:say("Negative! You do not have the correct item yet, flesh unit!", npc, creature)
				return true
			end

			local itemData = GolemServantItems[currentItemKey]
			player:removeItem(itemData.itemId, 1)

			local progress = kv:get(PROGRESS_KEY) + 1
			kv:set(PROGRESS_KEY, progress)

			if progress >= REQUIRED_REPAIRS then
				npcHandler:say("Repair procedure complete! Elevator fully operational. Ending communication. Have a nice day. Good bye.", npc, creature)
				kv:set(LIFT_UNLOCKED_KEY, true)
				golemServantResetRepair(kv)
			else
				npcHandler:say(progressMessages[progress] .. " Repair progress " .. progress .. " / " .. REQUIRED_REPAIRS .. " ! Can we continue?", npc, creature)
				kv:set(STATE_KEY, "continue")
			end
		elseif stateValue == "continue" then
			golemServantRequestNextItem(npc, creature, kv)
		end
	elseif MsgContains(message, "no") then
		local state = kv:get(STATE_KEY)
		local stateValue = state or nil

		if stateValue == "start" then
			npcHandler:say("Understood! No repair procedure initiated.", npc, creature)
			kv:remove(STATE_KEY)
		elseif stateValue == "hasitem" then
			npcHandler:say("Then hurry up and bring it, flesh unit!", npc, creature)
		elseif stateValue == "continue" then
			npcHandler:say("Understood! Repair procedure aborted. You must start over, flesh unit.", npc, creature)
			golemServantResetRepair(kv)
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Good .. bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good .. bye.")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
