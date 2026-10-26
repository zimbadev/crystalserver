-- Grave Danger: the team enters the ENTRANCE room in the south (before, it landed straight in
-- Zelos' room, which on the global server is closed until the 4 knights die). The lever creates Zelos, the 4
-- knights and the Risen Soldiers; the whole area (entrance + 4 rooms + corridors + Zelos' room) is the zone.
-- W: 24 min to defeat Zelos, up to 10 players. Mechanics in grave_danger_king_zelos.lua.
-- NOT CONFIRMED: 2 Risen Soldiers per knight room and 3 in Zelos' room at the start.
local ENTRANCE = Position(33445, 31573, 13)

local config = {
	boss = {
		name = "King Zelos",
		position = Position(33443, 31545, 13),
	},
	requiredLevel = 250,
	timeToDefeat = 24 * 60, -- W
	playerPositions = {
		{ pos = Position(33485, 31546, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31547, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31548, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31545, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33485, 31544, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31546, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31547, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31548, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31545, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
		{ pos = Position(33486, 31544, 13), teleport = ENTRANCE, effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33412, 31517, 13),
		to = Position(33476, 31579, 13),
	},
	monsters = {
		{ name = "Magnor Mournbringer", pos = Position(33463, 31529, 13) },
		{ name = "Nargol the Impaler", pos = Position(33423, 31529, 13) },
		{ name = "Rewar the Bloody", pos = Position(33463, 31562, 13) },
		{ name = "The Red Knight", pos = Position(33423, 31562, 13) },
		{ name = "Risen Soldier", pos = Position(33461, 31527, 13) },
		{ name = "Risen Soldier", pos = Position(33465, 31531, 13) },
		{ name = "Risen Soldier", pos = Position(33421, 31527, 13) },
		{ name = "Risen Soldier", pos = Position(33425, 31531, 13) },
		{ name = "Risen Soldier", pos = Position(33461, 31560, 13) },
		{ name = "Risen Soldier", pos = Position(33465, 31564, 13) },
		{ name = "Risen Soldier", pos = Position(33421, 31560, 13) },
		{ name = "Risen Soldier", pos = Position(33425, 31564, 13) },
		{ name = "Risen Soldier", pos = Position(33440, 31542, 13) },
		{ name = "Risen Soldier", pos = Position(33446, 31542, 13) },
		{ name = "Risen Soldier", pos = Position(33443, 31549, 13) },
	},
	exit = Position(32172, 31918, 8),
}

local lever = BossLever(config)

-- the 6 min ritual clock only starts when a NEW King Zelos was created (lever used successfully)
local baseOnUse = lever.onUse
function lever:onUse(player, selectedDifficulty)
	local before = Creature("King Zelos")
	local beforeId = before and before:getId() or 0
	local result = baseOnUse(self, player, selectedDifficulty)
	local after = Creature("King Zelos")
	if after and after:getId() ~= beforeId and GraveDangerZelos then
		GraveDangerZelos.start()
	end
	return result
end

lever:position({ x = 33484, y = 31546, z = 13 })
lever:register()
