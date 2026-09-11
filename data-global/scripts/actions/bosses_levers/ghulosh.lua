local bossPosition = Position(32756, 32720, 10)

local config = {
	boss = {
		name = "Ghulosh",
		position = bossPosition,
		-- The 75/50/25% transformations in creaturescripts_ghulosh.lua are driven by a
		-- global stage counter, so it has to go back to stage one on every fight.
		createFunction = function()
			Game.setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.Library.Ghulosh, 1)

			local monster = Game.createMonster("Ghulosh", bossPosition, true, true)
			if not monster then
				return false
			end

			monster:registerEvent("BossLeverOnDeath")
			return true
		end,
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(32747, 32773, 10), teleport = Position(32757, 32727, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32748, 32773, 10), teleport = Position(32757, 32727, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32749, 32773, 10), teleport = Position(32757, 32727, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32750, 32773, 10), teleport = Position(32757, 32727, 10), effect = CONST_ME_TELEPORT },
		{ pos = Position(32751, 32773, 10), teleport = Position(32757, 32727, 10), effect = CONST_ME_TELEPORT },
	},
	monsters = {
		{ name = "bone jaw", pos = Position(32755, 32721, 10) },
		{ name = "the book of death", pos = Position(32755, 32716, 10) },
	},
	specPos = {
		from = Position(32748, 32713, 10),
		to = Position(32763, 32729, 10),
	},
	exit = Position(32660, 32713, 13),
}

local lever = BossLever(config)
lever:position({ x = 32746, y = 32773, z = 10 })
lever:register()
