local config = {
	boss = {
		name = "Arbaziloth",
		position = Position(34034, 32330, 14),
	},
	timeToFightAgain = 60 * 60 * 20,
	playerPositions = {
		{ pos = Position(34058, 32395, 14), teleport = Position(34034, 32340, 14) },
		{ pos = Position(34058, 32396, 14), teleport = Position(34034, 32340, 14) },
		{ pos = Position(34058, 32397, 14), teleport = Position(34034, 32340, 14) },
		{ pos = Position(34058, 32398, 14), teleport = Position(34034, 32340, 14) },
		{ pos = Position(34058, 32399, 14), teleport = Position(34034, 32340, 14) },
	},
	specPos = {
		from = Position(34025, 32322, 14),
		to = Position(34043, 32341, 14),
	},
	exit = Position(34058, 32403, 14),
	monsters = {
		{ name = "The Forgemaster", pos = Position(34033, 32330, 14) },
	},
}

Game.setStorageValue("globalArbazilothHeal", 0)

local leverArbaziloth = BossLever(config)
leverArbaziloth:position(Position(34058, 32394, 14))
leverArbaziloth:register()
