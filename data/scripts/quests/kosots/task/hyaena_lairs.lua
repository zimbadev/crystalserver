local config = {
    id = 18,
    name = "Hyaena Lairs",
    tier = "beginner",
    monsters = {
        "Werehyaena",
        "Werehyaena Shaman"
    },
    amount = 550,
    rewards = {
        xp = 3000000,
        money = 100000,
        items = {
            { id = 65000, count = 1 },
        },
    },
    requirements = { minLevel = 10 },
}

local taskHyaenaLairs = KosOTSTask(config)

taskHyaenaLairs:register()
