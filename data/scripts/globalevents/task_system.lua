local spawnBillyTheTasker = GlobalEvent("SpawnBillyTheTasker")



function spawnBillyTheTasker.onStartup()
	if configManager.getBoolean(configKeys.KOS_TASK_SYSTEM) then

        for i = 1, #KOS_TASK_SYSTEM_NPC do
            local kosTaskSystemNpc = KOS_TASK_SYSTEM_NPC[i]
            local npc = Game.createNpc(kosTaskSystemNpc.name, kosTaskSystemNpc.position)
            if npc then
                npc:setMasterPos(kosTaskSystemNpc.position)
                logger.info("KosTaskSystem Spawned " .. kosTaskSystemNpc.name)
            end
        end

        return
	end

end

spawnBillyTheTasker:register()
