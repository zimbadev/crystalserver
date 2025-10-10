local taskDeath = CreatureEvent("TaskSystem")

function taskDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    if killer:isPlayer() then
        local task = killer:getActiveTask()
        if task ~= nil and task:taskContainsMonster(creature:getName()) then
            local taskStep = killer:getStorageValue(Storage.KosOts.TaskSystem.CURRENT_TASK_STAGE)
            local progres = killer:getCurrentTaskProgress()
            local needMonsters = task.amount * taskStep

            if progres < needMonsters then
                progres = progres+1
                if progres < needMonsters then
                    killer:sendTextMessage(MESSAGE_LOOK, "Task progress: " .. progres .. "/" .. needMonsters)
                else
                    killer:sendTextMessage(MESSAGE_LOOK, "You have completed a " .. task.name .. " task")
                end
                killer:setStorageValue(Storage.KosOts.TaskSystem.CURRENT_TASK_PROGRESS,progres)
            end



        end
    end
end

taskDeath:register()