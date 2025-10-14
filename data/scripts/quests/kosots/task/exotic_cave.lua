local config = {
    id = 11,
    name = "Exotic Cave",
    tier = "beginner",
    monsters = {
        "Exotic Cave Spider",
        "Exotic Bat",
    },
    amount = 500,
    rewards = {
        xp = 2500000,
        money = 100000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskExoticCave = KosOTSTask(config)

taskExoticCave:register()
