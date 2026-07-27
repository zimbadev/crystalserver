local config = {
	boss = {
		name = "Murcion",
		position = Position(33008, 32365, 15),
	},
	timeToFightAgain = 60 * 60 * 20,
	playerPositions = {
		{ pos = Position(32974, 32365, 15), teleport = Position(33009, 32372, 15) },
		{ pos = Position(32975, 32365, 15), teleport = Position(33009, 32372, 15) },
		{ pos = Position(32976, 32365, 15), teleport = Position(33009, 32372, 15) },
		{ pos = Position(32977, 32365, 15), teleport = Position(33009, 32372, 15) },
		{ pos = Position(32978, 32365, 15), teleport = Position(33009, 32372, 15) },
	},
	specPos = {
		from = Position(33000, 32360, 15),
		to = Position(33017, 32375, 15),
	},
	spawnMushroomPos = {
		from = Position(33001, 32361, 15),
		to = Position(33015, 32373, 15),
	},
	exit = Position(33904, 31693, 15),
	monsters = {
		--{ name = "Mushroom", pos = Position(33015, 32365, 15) },
	},
	--Game.setStorageValue(010126, 0)
}

local leverMurcion = BossLever(config)
leverMurcion:position(Position(32979, 32365, 15))
leverMurcion:register()
