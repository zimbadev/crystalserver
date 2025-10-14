local shared = TalkAction("!task")

function shared.onSay(player, words, param)
	if configManager.getBoolean(configKeys.KOS_TASK_SYSTEM) then
        if player then
            local task = player:getKosTask()
            local taskPoints = player:getKosTaskPoints()
            local taskStage = player:getKosTaskStage()
            local taskKills = player:getKosTaskKills()

            local text = "-- Task System -- \n\n"
            text = text .. "Task points : " .. taskPoints .. "  \n\n"
            if task then

                local taskXpReward = task:getXpRewardByStage(taskStage)
                local taskMoneyReward = task:getMoneyRewardByStage(taskStage)
                local taskMonsters = task:getMonsters()
                local taskRewards = task:getItemsRewardByStage(taskStage)
                local taskStatus = "In progress"
                if player:isKosTaskCompleted() then
                    taskStatus = "Completed"
                end

                text = text .. "-- Current Task -- \n\n"
                text = text .. "Name : " .. task:getName() .. "  \n"
                text = text .. "Status : " .. taskStatus .. "  \n"
                text = text .. "Stage : " .. taskStage .. "  \n"
                text = text .. "Required Kills : " .. task:getRequiredKillsByStage(taskStage) .. "  \n"
                text = text .. "Current kills : " .. taskKills .. "  \n\n"

                local party = player:getParty()
                if party then
                    text = text .. "Party Status: \n"
                    for _, member in ipairs(party:getMembers()) do
                        local partyMemberTask = member:getKosTask()

                        local status = nil
                        if partyMemberTask and partyMemberTask:getId() == task:getId() then
                            local partyMemberTaskStage = player:getKosTaskStage()
                            status = member:getKosTaskKills() .. "/" .. task:getRequiredKillsByStage(partyMemberTaskStage)
                        end

                        text = text .. member:getName() .. " - " .. status .. " \n"

                    end
                end

                text = text .. "\nMonsters: \n"
                for i, name in ipairs(taskMonsters) do
                    text = text .. " - " .. name .. " \n"
                end

                text = text .. "\nRewards: \n"
                text = text .. " - XP : " .. taskXpReward .. "  \n"
                text = text .. " - Money : " .. taskMoneyReward .. "  \n"
                for i, reward in ipairs(taskRewards) do
                    local itemName = ItemType(reward.id):getName()
                    text = text .. " - " .. itemName .. " x " .. reward.amount .. "  \n"
                end

            end

            player:showTextDialog(34266, text)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

        end
        return true
    end
	return false
end

shared:groupType("normal")
shared:register()
