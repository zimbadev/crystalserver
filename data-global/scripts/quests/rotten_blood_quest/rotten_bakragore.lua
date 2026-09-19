local config = {
	boss = {
		name = "Bakragore",
		position = Position(33044, 32394, 15),
	},
	requiredLevel = 250,
	timeToFightAgain = ParseDuration("68h") / ParseDuration("1s"),
	playerPositions = {
		{ pos = Position(33010, 32392, 15), teleport = Position(33044, 32407, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33011, 32392, 15), teleport = Position(33044, 32407, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33012, 32392, 15), teleport = Position(33044, 32407, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33013, 32392, 15), teleport = Position(33044, 32407, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33014, 32392, 15), teleport = Position(33044, 32407, 15), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33034, 32389, 15),
		to = Position(33053, 32410, 15),
	},
	exit = Position(34106, 32052, 13),
}

local lever = BossLever(config)
lever:position(Position(33015, 32392, 15))
lever:register()
