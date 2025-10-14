local config = {
    id = 9,
    name = "Caverna Examina",
    tier = "beginner",
    monsters = {
        "Putrid Mummy",
        "Giant Spider",
    },
    amount = 550,
    rewards = {
        xp = 2000000,
        money = 80000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskCavaranaExamina = KosOTSTask(config)

taskCavaranaExamina:register()
