local config = {
    id = 16,
    name = "Oskayaat",
    tier = "beginner",
    monsters = {
        "Weretiger",
        "White Weretiger",
        "Werecrocodile",
        "Feral Werecrocodile",
        "Werepanther",
        "Cunning Werepanther"
    },
    amount = 575,
    rewards = {
        xp = 2900000,
        money = 100000,
        items = {
            { id = 65000, count = 1 },
        },
    },
    requirements = { minLevel = 10 },
}

local taskOskayaat = KosOTSTask(config)

taskOskayaat:register()
