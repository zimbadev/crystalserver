local config = {
	boss = {
		name = "Sugar Daddy",
		position = Position(33369, 32220, 9),
	},
	timeToFightAgain = 60 * 60 * 20,
	playerPositions = {
		{ pos = Position(33339, 32221, 9), teleport = Position(33372, 32234, 9) },
		{ pos = Position(33339, 32222, 9), teleport = Position(33372, 32234, 9) },
		{ pos = Position(33339, 32223, 9), teleport = Position(33372, 32234, 9) },
		{ pos = Position(33339, 32224, 9), teleport = Position(33372, 32234, 9) },
		{ pos = Position(33339, 32225, 9), teleport = Position(33372, 32234, 9) },
	},
	specPos = {
		from = Position(33360, 32215, 9),
		to = Position(33382, 32246, 9),
	},
	exit = Position(33397, 32201, 9),
}

local leverSugarDaddy = BossLever(config)
leverSugarDaddy:position(Position(33339, 32220, 9))
leverSugarDaddy:register()
