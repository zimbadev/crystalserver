local config = {
    id = 15,
    name = "Bounac",
    tier = "beginner",
    monsters = {
        "Lion Knight",
        "Lion Archer",
        "Lion Warlock",
        "Usurper Warlock",
        "Usurper Archer",
        "Usurper Knight"
    },
    amount = 450,
    rewards = {
        xp = 2500000,
        money = 100000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskBounac = KosOTSTask(config)

taskBounac:register()
