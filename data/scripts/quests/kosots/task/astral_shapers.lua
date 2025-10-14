local config = {
    id = 17,
    name = "Astral Shapers",
    tier = "beginner",
    monsters = {
        "Broken Shaper",
        "Twisted Shaper",
        "Shaper Matriarch",
        "Stone Rhino"
    },
    amount = 600,
    rewards = {
        xp = 3000000,
        money = 100000,
        items = {
            { id = 65000, count = 1 },
        },
    },
    requirements = { minLevel = 10 },
}

local taskAstralShapers = KosOTSTask(config)

taskAstralShapers:register()
