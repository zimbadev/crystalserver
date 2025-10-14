local config = {
    id = 13,
    name = "Misguided Camp",
    tier = "beginner",
    monsters = {
        "Misguided Thief",
        "Misguided Bully",
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

local taskMisguidedCamp = KosOTSTask(config)

taskMisguidedCamp:register()
