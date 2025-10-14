local internalNpcName = "Billy the tasker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}
local choose = {}
local choseStage = {}
npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1282,
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
    { itemName = "Rotworm Stew", clientId = 9079, buy = 10 },
	{ itemName = "Hydra tongue salad", clientId = 9080, buy = 10 },
	{ itemName = "Roasted Dragon Wings", clientId = 9081, buy = 10 },
	{ itemName = "Tropical Fried Terrorbird", clientId = 9082, buy = 10 },
	{ itemName = "Banana Chocolate Shake", clientId = 9083, buy = 10 },
	{ itemName = "Veggie Casserole", clientId = 9084, buy = 10 },
	{ itemName = "Filled Jalapeno Peppers", clientId = 9085, buy = 10 },
	{ itemName = "Blessed Steak", clientId = 9086, buy = 10 },
	{ itemName = "Northern Fishburger", clientId = 9088, buy = 10 },
	{ itemName = "Carrot Cake", clientId = 9087, buy = 10 },
	{ itemName = "Coconut Shrimp Bake", clientId = 11584, buy = 10 },
	{ itemName = "Pot of Blackjack", clientId = 11586, buy = 10 },
	{ itemName = "Demonic Candy Ball", clientId = 11587, buy = 10 },
	{ itemName = "Sweet Mangonaise Elixir", clientId = 11588, buy = 10 },
	{ itemName = "Zaoan Sauce", clientId = 50334, buy = 10 },
    { clientId = 36723, itemName = "kooldown-aid", buy = 5 },
    { clientId = 36724, itemName = "strike enhancement", buy = 5 },
    { clientId = 36725, itemName = "stamina extension", buy = 5 },
    { clientId = 36726, itemName = "charm upgrade", buy = 5 },
    { clientId = 36727, itemName = "wealth duplex", buy = 5 },
    { clientId = 36728, itemName = "bestiary betterment", buy = 5 },
    { clientId = 36729, itemName = "fire resilience", buy = 5 },
    { clientId = 36730, itemName = "ice resilience", buy = 5 },
    { clientId = 36731, itemName = "earth resilience", buy = 5 },
    { clientId = 36732, itemName = "energy resilience", buy = 5 },
    { clientId = 36733, itemName = "holy resilience", buy = 5 },
    { clientId = 36734, itemName = "death resilience", buy = 5 },
    { clientId = 36735, itemName = "physical resilience", buy = 5 },
    { clientId = 36736, itemName = "fire amplification", buy = 5 },
    { clientId = 36737, itemName = "ice amplification", buy = 5 },
    { clientId = 36738, itemName = "earth amplification", buy = 5 },
    { clientId = 36739, itemName = "energy amplification", buy = 5 },
    { clientId = 36740, itemName = "holy amplification", buy = 5 },
    { clientId = 36741, itemName = "death amplification", buy = 5 },
    { clientId = 36742, itemName = "physical amplification", buy = 5 },

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

    npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! You can start a {task} with me. If you want to {report} or {cancel} , just ask me!")

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


    if table.contains({ "tasks", "task", "mission" }, message:lower()) then
        local task = player:getKosTask()
        if task then
            return npcHandler:say("You can only take one task at a one time.", npc, creature)
        end

        local tasks = player:getAvailableKosTasks()
        local msg = "Here are the available tasks: "

        for i = 1, #tasks do
            local task = tasks[i]
            msg = msg .. task:getRequiredKills() .. "x {" .. task:getName() .. "}"
            if i < #tasks then
                msg = msg .. ", "
            end
        end
        npcHandler:say(msg, npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif message ~= "" and npcHandler:getTopic(playerId) == 1 then
        local task = player:canPickupTask(message:lower())
        local msg
        if task then
            msg = "You want to kill " .. task:getRequiredKills() .. " " .. task:getName() .. 's ? How many stages you want ? (1-10)'
            choose[playerId] = task
            npcHandler:setTopic(playerId, 2)
        else
            msg = "Invalid {task}"
        end
        npcHandler:say(msg, npc, creature)
    elseif message ~= "" and npcHandler:getTopic(playerId) == 2 then
        local taskStage  = tonumber(message)
        local task = choose[playerId]
        local msg = ""
        if taskStage == nil or taskStage < 1 or taskStage > 10 then
            msg = "You want to kill " .. task:getRequiredKills() .. " " .. task:getName() .. 's ? How many stages you want ? (1-10)'
        else
            choseStage[playerId] = taskStage
            msg = "Are you sure you want to kill " .. task:getRequiredKillsByStage(taskStage) .. " " .. task:getName() .. "s ? {yes}/{no}"
            npcHandler:setTopic(playerId, 3)
        end
        npcHandler:say(msg, npc, creature)
    elseif message:lower() == "yes" and npcHandler:getTopic(playerId) == 3 then
        local task = choose[playerId]
        local taskStage = choseStage[playerId]

        if player:setTask(task, taskStage) then
            local taskMonsters = task:getMonsters()
            local monstersList = ""

            for i = 1, #taskMonsters do
                local taskMonster = taskMonsters[i]
                monstersList = monstersList .. "{" .. taskMonster .. "}"
                if i < #taskMonster then
                    monstersList = monstersList .. ", "
                end
            end


            npcHandler:say("Task with " .. task:getName() .. " has been activated. List of monsters included in the task: " .. monstersList ..". Go and kill " .. task:getRequiredKills(taskStage) .. " of them.", npc, creature)
        else
            npcHandler:say("Something went wrong. Type {task}", npc, creature)
        end
        npcHandler:setTopic(playerId, 0)
    elseif message:lower() == "no" and npcHandler:getTopic(playerId) == 3 then
        local tasks = player:getAvailableKosTasks()
        local msg = "Which task do you want : "


        local msg = "You can pickup following tasks: "

        for i = 1, #tasks do
            local task = tasks[i]
            msg = msg .. "{" .. task:getName() .. "}"
            if i < #tasks then
                msg = msg .. ", "
            end
        end
        npcHandler:say(msg, npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif message:lower() == 'report' then
        local task = player:getKosTask()
        if not task then
            return npcHandler:say("You currently dont have any active {task}.", npc, creature)
        end

        if player:completeKosTask() then
            return npcHandler:say("You have completed a " .. task:getName() .. " {task}.", npc, creature)
        end


    elseif message:lower() == 'cancel' then
        local task = player:getKosTask()
        if not task then
            return npcHandler:say("You currently dont have any active {task}.", npc, creature)
        end

        if player:cancelKosTask() then
            return npcHandler:say("You have successfully cancel {task}.", npc, creature)
        end

    end

end

npcHandler:setMessage(MESSAGE_FAREWELL, "Happy hunting, dear no-life!")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
