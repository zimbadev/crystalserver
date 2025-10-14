local config = {
    id = 16,
    name = "The Lost",
    tier = "beginner",
    monsters = {
        "Lost Thrower",
        "Lost Husher",
        "Lost Basher",
        "Vulcongra",
        "War Golem",
        "Lost Berserker",
        "Enslaved Dwarf",
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

local taskTheLos = KosOTSTask(config)

taskTheLos:register()
