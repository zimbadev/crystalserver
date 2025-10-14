local config = {
    id = 4,
    name = "Cults",
    tier = "beginner",
    monsters = {
        "Cult Believer",
        "Cult Enforcer",
        "Cult Scholar",
        "Hero",
        "Vicious Squire",
        "Vile Grandmaster",
    },
    amount = 225,
    rewards = {
        xp = 1500000,
        money = 80000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskCults= KosOTSTask(config)

taskCults:register()
