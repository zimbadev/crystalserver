local nictrosPosition = Position(33427, 31428, 13)
local baelocPosition = Position(33422, 31428, 13)

local config = {
	boss = {
		name = "Sir Nictros",
		createFunction = function()
			local nictros = Game.createMonster("Sir Nictros", nictrosPosition, true, true)
			if not nictros then
				return false
			end
			nictros:registerEvent("SirNictrosThink")

			local baeloc = Game.createMonster("Sir Baeloc", baelocPosition, true, true)
			if not baeloc then
				return false
			end
			baeloc:registerEvent("SirBaelocThink")

			-- Add dialogues and events
			if baeloc and nictros then
				baeloc:say("Ah look my Brother! Challengers! After all this time finally a chance to prove our skills!")

				addEvent(function()
					if nictros then
						nictros:say("Indeed! It has been a while! As the elder one I request the right of the first battle!")
					end
				end, 6 * 1000)

				addEvent(function()
					if baeloc then
						baeloc:say("Oh, man! You always get the fun!")
						if nictros then
							nictros:teleportTo(Position(33426, 31437, 13))
							nictros:setMoveLocked(false)
						end
					end
				end, 12 * 1000)
			end

			return true
		end,
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(33424, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33425, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33426, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33427, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33428, 31413, 13), teleport = Position(33423, 31448, 13) },
	},
	specPos = {
		from = Position(33414, 31426, 13),
		to = Position(33433, 31449, 13),
	},
	onUseExtra = function(player)
		addEvent(function()
			local nictros = Tile(nictrosPosition):getTopCreature()
			if not nictros then
				return
			end
			nictros:teleportTo(Position(33427, 31436, 13))
		end, 5 * 1000)
	end,
	exit = Position(33290, 32474, 9),
}

local lever = BossLever(config)
lever:position(Position(33423, 31413, 13))
lever:register()
