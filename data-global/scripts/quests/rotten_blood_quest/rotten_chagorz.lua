local config = {
	boss = {
		name = "Chagorz",
		position = Position(33044, 32362, 15),
	},
	timeToFightAgain = 60 * 60 * 20,
	playerPositions = {
		{ pos = Position(33074, 32367, 15), teleport = Position(33044, 32373, 15) },
		{ pos = Position(33075, 32367, 15), teleport = Position(33044, 32373, 15) },
		{ pos = Position(33076, 32367, 15), teleport = Position(33044, 32373, 15) },
		{ pos = Position(33077, 32367, 15), teleport = Position(33044, 32373, 15) },
		{ pos = Position(33078, 32367, 15), teleport = Position(33044, 32373, 15) },
	},
	specPos = {
		from = Position(33035, 32358, 15),
		to = Position(33052, 32375, 15),
	},
	spawnMushroomPos = {
		from = Position(33001, 32361, 15),
		to = Position(33015, 32373, 15),
	},
	exit = Position(33904, 31693, 15),
	monsters = {
		--{ name = "Elder Bloodjaw", pos = Position(33048, 32367, 15) },
		--{ name = "Elder Bloodjaw", pos = Position(33040, 32367, 15) },
	},
	Game.setStorageValue(010126, 1),
}

local leverMurcion = BossLever(config)
leverMurcion:position(Position(33079, 32367, 15))
leverMurcion:register()
