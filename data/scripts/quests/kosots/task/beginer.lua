local config = {
    id = 1,
    name = "Beginner",
    tier = "beginner",
    monsters = {"Rat"},
    amount = 1,
    rewards = {
        xp = 100000,
        money = 100,
        items = {
            { id = 65000, count = 1 }
        },
    },
    requirements = { minLevel = 10 },
}

local taskBeginer = KosOTSTask(config)

taskBeginer:register()
