local config = {
    id = 10,
    name = "Oramond Minotaurs",
    tier = "beginner",
    monsters = {
        "Mooh'Tah Warrior",
        "Minotaur Hunter",
        "Worm Priestess",
        "Moohtant",
        "Minotaur Amazon",
        "Execowtioner",
    },
    amount = 700,
    rewards = {
        xp = 2500000,
        money = 100000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskOramondMinotaurs = KosOTSTask(config)

taskOramondMinotaurs:register()
