-- Burning Heart: Herald of Fire boss lever (Crimson Court)
local HERALD_SPAWN = Position(32496, 32656, 15)

local config = {
	boss = {
		name = "Herald of Fire",
		createFunction = function()
			return Game.createMonster("Herald of Fire", HERALD_SPAWN, true, true)
		end,
	},
	requiredLevel = 12,
	-- Player tiles (lever room) -> boss room
	-- The lever sends players to 32493,32659,15; spread on y so they don't stack.
	playerPositions = {
		{ pos = Position(32435, 32654, 15), teleport = Position(32493, 32659, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32435, 32655, 15), teleport = Position(32493, 32660, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32435, 32656, 15), teleport = Position(32493, 32661, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32435, 32657, 15), teleport = Position(32493, 32662, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32435, 32658, 15), teleport = Position(32493, 32663, 15), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32487, 32649, 15),
		to = Position(32504, 32664, 15),
	},
	exit = Position(32418, 32686, 13),
}

local lever = BossLever(config)
lever:position(Position(32435, 32653, 15))
lever:register()
