local config = {
    id = 6,
    name = "Feyrist",
    tier = "beginner",
    monsters = {
        "Kollos",
        "Pooka",
        "Pixie",
        "Nymph",
        "Twisted Pooka",
        "Dark Faun",
        "Boogy",
        "Faun",
        "Enfeebled Silencer",
        "Weakened Frazzlemaw",
    },
    amount = 400,
    rewards = {
        xp = 1500000,
        money = 100000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskFeyrist = KosOTSTask(config)

taskFeyrist:register()
