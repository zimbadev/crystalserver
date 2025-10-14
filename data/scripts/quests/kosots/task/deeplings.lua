local config = {
    id = 14,
    name = "Deeplings",
    tier = "beginner",
    monsters = {
        "Deepling Spellsinger",
        "Deepling Warrior",
        "Deepling Master Librarian",
        "Deepling Tyrant",
        "Deepling Elite",
        "Deepling Guard",
        "Shark",
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

local taskDeeplings = KosOTSTask(config)

taskDeeplings:register()
