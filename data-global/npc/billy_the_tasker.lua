local internalNpcName = "Billy the tasker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}
local choose = {}
local chooseAmount = {}
npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 144,
	lookHead = 116,
	lookBody = 78,
	lookLegs = 94,
	lookFeet = 78,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.currency = 65000
npcConfig.shop = {
	{ itemName = "Rotworm Stew", clientId = 9079, buy = 20 },
	{ itemName = "Hydra tongue salad", clientId = 9080, buy = 20 },
	{ itemName = "Roasted Dragon Wings", clientId = 9081, buy = 20 },
	{ itemName = "Tropical Fried Terrorbird", clientId = 9082, buy = 20 },
	{ itemName = "Banana Chocolate Shake", clientId = 9083, buy = 20 },
	{ itemName = "Veggie Casserole", clientId = 9084, buy = 20 },
	{ itemName = "Filled Jalapeno Peppers", clientId = 9085, buy = 20 },
	{ itemName = "Blessed Steak", clientId = 9086, buy = 20 },
	{ itemName = "Northern Fishburger", clientId = 9088, buy = 20 },
	{ itemName = "Carrot Cake", clientId = 9087, buy = 20 },
	{ itemName = "Coconut Shrimp Bake", clientId = 11584, buy = 20 },
	{ itemName = "Pot of Blackjack", clientId = 11586, buy = 20 },
	{ itemName = "Demonic Candy Ball", clientId = 11587, buy = 20 },
	{ itemName = "Sweet Mangonaise Elixir", clientId = 11588, buy = 20 },
	{ itemName = "Zaoan Sauce", clientId = 50334, buy = 20 },

}
local messageStartTask = {
	["Beginner"] = {

    },
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry) ~= 0 then
		npcHandler:setMessage(MESSAGE_GREET, "Hi there, do you want to to {join} the 'Paw and Fur - Hunting Elite'?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Welcome to the 'Paw and Fur - Hunting Elite' |PLAYERNAME|. Did you want get some {task} or {report}, {cancel}")
	end

	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	message = message:gsub("(%l)(%w*)", function(a, b)
		return string.upper(a) .. b
	end)

	if (MsgContains("join", message) or MsgContains("yes", message)) and npcHandler:getTopic(playerId) == 0 and player:getStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry) ~= 0 then
		player:setStorageValue(JOIN_STOR, 1)
		player:setStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry, 0)
		player:setStorageValue(Storage.KosOts.TaskSystem.QuestLinePoints, 0)
		player:setStorageValue(Storage.KosOts.TaskSystem.POINTSSTORAGE, 0)
		npcHandler:say("Great! A warm welcome to our newest member: |PLAYERNAME|! Ask me for a {task} if you want to go on a hunt.", npc, creature)
	elseif table.contains({ "tasks", "task", "mission" }, message:lower()) then
		if player:getStorageValue(Storage.KosOts.TaskSystem.QuestLogEntry) ~= 0 then
			return npcHandler:say("You'll have to {join}, to get any {tasks}.", npc, creature)
		end

        if player:getActiveTask() then
            return npcHandler:say("You have still active task. You can {report} or {cancel}", npc, creature)
        end


        local msg = "You can pickup following tasks: "
        local tasks = KosOTSTask:getTaskByStage()
        for i = 1, #tasks do
            local task = tasks[i]
            msg = msg .. "{" .. task.name .. "}"
            if i < #tasks then
                msg = msg .. ", "
            end
        end


        npcHandler:say(msg, npc, creature)
    elseif message:lower() == "cancel" then
        local task = player:getActiveTask()

        if task == nil then
            return npcHandler:say("You dont have a active {task}.", npc, creature)
        end

        player:setStorageValue(Storage.KosOts.TaskSystem.CURRENT_TASK, 0)
        player:setStorageValue(Storage.KosOts.TaskSystem.CURRENT_TASK_STAGE, 0)
        player:setStorageValue(Storage.KosOts.TaskSystem.CURRENT_TASK_PROGRESS, 0)
        return npcHandler:say("You have canceled the task", npc, creature)
    elseif message:lower() == "report" then
        local task = player:getActiveTask()

        if task == nil then
            return npcHandler:say("You dont have a active {task}.", npc, creature)
        end
        local stage = player:getStorageValue(Storage.KosOts.TaskSystem.CURRENT_TASK_STAGE)
        if player:isTaskCompleted(task,stage) then
            player:completeTask(task,stage)
        else
            return npcHandler:say("You haven't killed all the monsters yet.", npc, creature)
        end

    elseif message ~= "" and npcHandler:getTopic(playerId) == 0 then
        local msg = ""
        local task = KosOTSTask:getTaskByName(message)
        if task ~= nil then
            choose[playerId] = task
            npcHandler:setTopic(playerId, 1)
            msg = "You want to kill " .. choose[playerId].amount .. " " .. choose[playerId].name .. " monsters right ? How many task u want to pick up ? (1-10)"
        else
            local tasks = KosOTSTask:getTaskByStage()
            for i = 1, #tasks do
                local task = tasks[i]
                msg = msg .. "{" .. task.name .. "}"
                if i < #tasks then
                    msg = msg .. ", "
                end
            end
        end

        npcHandler:say(msg, npc, creature)
    elseif message ~= "" and npcHandler:getTopic(playerId) == 1 then
        local taskAmount  = tonumber(message)
        local msg = ""
        if taskAmount == nil or taskAmount < 1 or taskAmount > 10 then
            msg = "You want to kill " .. choose[playerId].amount .. " " .. choose[playerId].name .. " monsters right ? How many task u want to pick up ? (1-10)"
        else
            local task = choose[playerId]
            chooseAmount[playerId] = taskAmount
            npcHandler:setTopic(playerId, 2)
            msg = "Are you sure you want to kill " .. (taskAmount*task.amount) .. " " .. task.name .. "s ?"
        end
        npcHandler:say(msg, npc, creature)
    elseif table.contains({ "yes", "no" }, message:lower()) and npcHandler:getTopic(playerId) == 2 then
        if message:lower() == "no" then
            local tasks = KosOTSTask:getTaskByStage()
            local msg = ""
            for i = 1, #tasks do
                local task = tasks[i]
                msg = msg .. "{" .. task.name .. "}"
                if i < #tasks then
                    msg = msg .. ", "
                end
            end

            npcHandler:setTopic(playerId, 0)
            npcHandler:say(msg, npc, creature)
        else
            local task = choose[playerId]
            local amount = chooseAmount[playerId]
            player:setPlayerTask(task,amount)
            npcHandler:say("Go and kill " .. (chooseAmount[playerId] * task.amount) .. " " .. task.name .. "s", npc, creature)
        end
	end
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Happy hunting, dear no-life!")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
