local config = {
    id = 7,
    name = "Krailos",
    tier = "beginner",
    monsters = {
        "Undead Gladiator",
        "Nightmare Scion",
        "Nightmare",
        "Clomp",
        "Ogre Shaman",
        "Ogre Brute",
        "Ogre Savage",
    },
    amount = 300,
    rewards = {
        xp = 1500000,
        money = 100000,
        items = {

        },
    },
    requirements = { minLevel = 10 },
}

local taskKrailos = KosOTSTask(config)

taskKrailos:register()
