local config = {
    id = 2,
    name = "Beginner",
    tier = "beginner",
    monsters = {
        "Amazon",
        "Valkyrie",
        "Minotaur",
        "Minotaur Guard",
        "Minotaur Mage",
        "Minotaur Mage",
        "Cyclops",
        "Cyclops Drone",
        "Cyclops Smith",
        "Stonerefiner",
    },
    amount = 100,
    rewards = {
        xp = 100000,
        money = 50000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskBeginner = KosOTSTask(config)

taskBeginner:register()
