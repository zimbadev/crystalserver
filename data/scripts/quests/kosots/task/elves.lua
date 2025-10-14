local config = {
    id = 2,
    name = "Elves",
    tier = "beginner",
    monsters = {
        "Crazed Summer Rearguard",
        "Crazed Summer Vanguard",
        "Insane Siren",
        "Arachnophobica",
        "Crazed Winter Rearguard",
        "Crazed Winter Vanguard",
        "Soul-Broken Harbinger",
        "Thanatursus",
    },
    amount = 1200,
    rewards = {
        xp = 8500000,
        money = 300000,
        items = {
            { id = 65000, count = 3 },
            { id = 65001, count = 1 }
        },
    },
    requirements = { minLevel = 10 },
}

local taskElves = KosOTSTask(config)

taskElves:register()
