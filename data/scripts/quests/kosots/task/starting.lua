local config = {
    id = 1,
    name = "Starting",
    tier = "beginner",
    monsters = {
        "Rat",
        "Rotworm",
        },
    amount = 60,
    rewards = {
        xp = 20000,
        money = 20000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskStarting = KosOTSTask(config)

taskStarting:register()
