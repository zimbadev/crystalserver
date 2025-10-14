local config = {
    id = 12,
    name = "Razachai",
    tier = "beginner",
    monsters = {
        "Lizard Zaogun",
        "Lizard Chosen",
        "Lizard Noble",
        "Lizard Magistratus",
        "Lizard Legionnaire",
        "Lizard Dragon Priest",
        "Lizard High Guard",
        "Killer Caiman",
        "Brimstone Bug",
        "Souleater",
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

local taskRazachai = KosOTSTask(config)

taskRazachai:register()
