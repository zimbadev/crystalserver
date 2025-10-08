local config = {
    name = "Beginner",
    tier = "beginner",
    monsters = {"Rat"},
    amount = 100,
    rewards = {
        xp = 100000,
        money = 0,
        items = {
            { id = 2160, count = 5 }
        },
    },
    requirements = { minLevel = 10 },
    repeatable = true,
}

local taskBeginer = KosOTSTask(config)

taskBeginer:register()
