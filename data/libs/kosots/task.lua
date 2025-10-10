---@class KosOTSTask
---@field private name string
KosOTSTask = {}
KosOTSTaskIds = {}

--[[
local config = {
    name = "Beginner",
    tier = "beginner",
    monsters = {
        { name = "orc", displayId = 10 },
        { name = "troll", displayId = 11 },
        { name = "rat", displayId = 12 },
        { name = "wolf", displayId = 13 },
    },
    amount = 100,
    rewards = {
    xp = 100000,
    money = 0,
    items = {
        { id = 2160, count = 5 }
    },
    requirements = { minLevel = 10 },
}
]]
setmetatable(KosOTSTask, {
	---@param self KosOTSTask
	---@param config table
	__call = function(self, config)

		if not config.name then
			error("KosOTSTask: name is required")
		end
		return setmetatable({
			name = config.name:lower(),
			amount = tonumber(config.amount),
			id = tonumber(config.id),
			monsters = config.monsters,
            rewards = config.rewards

		}, { __index = KosOTSTask })
	end,
})

---@param self KosOTSTask
---@return boolean
function KosOTSTask:register()
	local missingParams = {}
	if not self.name then
		table.insert(missingParams, "task.name")
	end
	if #missingParams > 0 then
		local name = self.name or "unknown"
		return false
	end

	KosOTSTask[self.id] = self
    KosOTSTaskIds[self.name:lower()] = self.id
	return true
end

---@return {name: string, exit: Position|nil}[]
function KosOTSTask:getTaskByStage()
	local stageTasks = {

    }

    logger.debug("KosOTSTask:getTaskByStage - Sprawdzanie stage")
	for name, task in pairs(KosOTSTask) do
		-- Pomijamy metody i inne nieinstancje
		if type(task) == "table" then
            logger.error("KosOTSTask:getTaskByStage() - boss with name {}", task.name)
			table.insert(stageTasks, task)
		end
	end
	return stageTasks
end

function KosOTSTask:getTaskByName(taskName)
    local taskId = KosOTSTaskIds[taskName:lower()]
    if taskId ~= nil then
        return KosOTSTask[taskId]
    end
    return nil
end

function KosOTSTask:taskContainsMonster(creatureName)
    return table.contains(self.monsters, creatureName)
end





