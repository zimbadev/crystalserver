local config = {
    id = 3,
    name = "Dragons",
    tier = "beginner",
    monsters = {
        "Dragon",
        "Dragon Lord",
        "Frost Dragon",
        "Frost Dragon Hatchling",
        "Elder Wyrm",
        "Wyrm",
    },
    amount = 175,
    rewards = {
        xp = 800000,
        money = 70000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskDragon = KosOTSTask(config)

taskDragon:register()
