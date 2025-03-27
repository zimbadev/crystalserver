local config = {
	boss = {
		name = "The Unwelcome",
		position = Position(33708, 31539, 14),
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(33736, 31537, 14), teleport = Position(33707, 31545, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33737, 31537, 14), teleport = Position(33707, 31545, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33738, 31537, 14), teleport = Position(33707, 31545, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33739, 31537, 14), teleport = Position(33707, 31545, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33740, 31537, 14), teleport = Position(33707, 31545, 14), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33699, 31529, 14),
		to = Position(33719, 31546, 14),
	},
	exit = Position(33611, 31528, 10),
}

local function spawnBosses(leverPosition)
	Game.createMonster("Brother Worm", Position(33708, 31531, 14))
	Position(33708, 31531, 14):sendMagicEffect(CONST_ME_TELEPORT)
end

local lever = BossLever(config)
local originalOnUse = lever.onUse
function lever:onUse(creature, item, position, fromPosition)
	local ret = originalOnUse(self, creature, item, position, fromPosition)
	if ret then
		addEvent(spawnBosses, 100, position)
	end
	return ret
end
lever:position({ x = 33735, y = 31537, z = 14 })
lever:register()
