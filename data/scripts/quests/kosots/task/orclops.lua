local config = {
    id = 8,
    name = "Orclops",
    tier = "beginner",
    monsters = {
        "Orclops Doomhauler",
        "Orclops Ravager",
    },
    amount = 500,
    rewards = {
        xp = 2000000,
        money = 100000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskOrclops = KosOTSTask(config)

taskOrclops:register()
