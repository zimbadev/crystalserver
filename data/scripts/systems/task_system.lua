local taskSystemProgress = CreatureEvent("taskSystemProgress")

function taskSystemProgress.onKosTaskProgress(player)
    local task = player:getKosTask()
    local taskPoints = player:getKosTaskPoints()
    local taskStage = player:getKosTaskStage()
    local taskKills = player:getKosTaskKills()
    local taskName = task:getName()
    local requiredKills  = task:getRequiredKillsByStage(taskStage);


    player:sendTextMessage(MESSAGE_LOOK, "You killed " .. taskKills .. "/" .. requiredKills .. " of " .. taskName .. " task")
end

taskSystemProgress:register()

local taskSystemComplete = CreatureEvent("taskSystemComplete")

function taskSystemComplete.onKosTaskComplete(player)
    local task = player:getKosTask()
    local taskPoints = player:getKosTaskPoints()
    local taskStage = player:getKosTaskStage()
    local taskKills = player:getKosTaskKills()
    local taskName = task:getName()
    local requiredKills  = task:getRequiredKills(taskStage);


    player:sendTextMessage(MESSAGE_LOOK, "You have completed the " .. taskName .. " task. You can go back to Billy the tasker to get reward")
end

taskSystemComplete:register()

local taskSystemCompleted = CreatureEvent("taskSystemCompleted")

function taskSystemCompleted.onKosTaskCompleted(player,task,xpAmount,moneyAmount,taskPointsAmount,rewards)
    local taskName = task:getName()

    local text = "You have completed the " .. taskName .. " task. You received: \n\n"
    text = text .. "XP : " .. xpAmount .. "\n"
    text = text .. "Money : " .. moneyAmount .. "\n"
    for i, reward in ipairs(rewards) do
        text = text .. reward.name .. " x " .. reward.amount .. "  \n"
    end
    text = text .. "Task Points : " .. taskPointsAmount .. "\n"

    player:sendTextMessage(MESSAGE_LOOK, text)
end

taskSystemCompleted:register()