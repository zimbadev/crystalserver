local config = {
	boss = {
		name = "Lord Retro",
		position = Position(33578, 31013, 15),
	},
	timeToFightAgain = 20 * 60 * 60,
	playerPositions = {
		{ pos = Position(33516, 31055, 15), teleport = Position(33577, 31022, 15) },
		{ pos = Position(33517, 31055, 15), teleport = Position(33577, 31023, 15) },
		{ pos = Position(33518, 31055, 15), teleport = Position(33577, 31024, 15) },
		{ pos = Position(33519, 31055, 15), teleport = Position(33577, 31025, 15) },
		{ pos = Position(33520, 31055, 15), teleport = Position(33577, 31026, 15) },
	},
	specPos = {
		from = Position(33564, 31004, 15),
		to = Position(33597, 31035, 15),
	},
	exit = Position(33446, 31016, 14),
}

local lever = BossLever(config)
lever:position(Position(33515, 31055, 15))
lever:register()
