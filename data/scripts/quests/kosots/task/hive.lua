local config = {
    id = 5,
    name = "Hive",
    tier = "beginner",
    monsters = {
        "Waspoid",
        "Crawler",
        "Insectoid Worker",
        "Spidris",
        "Swarmer",
        "Spitter",
    },
    amount = 200,
    rewards = {
        xp = 1500000,
        money = 80000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskHive = KosOTSTask(config)

taskHive:register()
