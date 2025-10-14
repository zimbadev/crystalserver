local config = {
    id = 17,
    name = "Issavi",
    tier = "beginner",
    monsters = {
        "Lamassu",
        "Crypt Warden",
        "Sphinx",
        "Feral Sphinx",
        "Adult Goanna",
        "Young Goanna",
        "Manticore",
    },
    amount = 500,
    rewards = {
        xp = 7500000,
        money = 250000,
        items = {
            { id = 65000, count = 3 },
            { id = 65001, count = 1 }
        },
    },
    requirements = { minLevel = 10 },
}

local taskIssavi = KosOTSTask(config)

taskIssavi:register()
