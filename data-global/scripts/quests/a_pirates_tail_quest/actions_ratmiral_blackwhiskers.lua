local ratmiralPosition = Position(33917, 31350, 13)
local mateRatticuPosition = Position(33907, 31351, 14)
local catkillerPosition = Position(33904, 31351, 15)
local rateyePosition = Position(33903, 31367, 15)
local palisadePosition = Position(33902, 31363, 15)
local monstersSmellyCheese = {
	{ name = "Smelly Cheese", pos = Position(33909, 31349, 14) },
	{ name = "Smelly Cheese", pos = Position(33905, 31355, 14) },
	{ name = "Smelly Cheese", pos = Position(33901, 31346, 14) },
	{ name = "Smelly Cheese", pos = Position(33907, 31374, 15) },
	{ name = "Smelly Cheese", pos = Position(33900, 31369, 15) },
	{ name = "Smelly Cheese", pos = Position(33904, 31364, 15) },
	{ name = "Smelly Cheese", pos = Position(33894, 31364, 15) },
	{ name = "Smelly Cheese", pos = Position(33902, 31354, 15) },
	{ name = "Smelly Cheese", pos = Position(33910, 31354, 15) },
	{ name = "Smelly Cheese", pos = Position(33912, 31348, 15) },
	{ name = "Smelly Cheese", pos = Position(33899, 31345, 15) },
	{ name = "Smelly Cheese", pos = Position(33906, 31345, 15) },
}

local config = {
	boss = {
		name = "Ratmiral Blackwhiskers",
		createFunction = function()
			local ratmiral = Game.createMonster("Ratmiral Blackwhiskers", ratmiralPosition, true, true)
			if ratmiral then
				ratmiral:setMoveLocked(true)
			end
			local catkiller = Game.createMonster("Mister Catkiller", catkillerPosition, true, true)
			local ratticus = Game.createMonster("1st Mate Ratticus", mateRatticuPosition, true, true)
			local rateye = Game.createMonster("Rateye Ric", rateyePosition, true, true)
			local palisade = Game.createMonster("Weak Spot", palisadePosition, true, true)

			for _, m in ipairs(monstersSmellyCheese) do
				Game.createMonster(m.name, m.pos, true, true)
			end

			return ratmiral and catkiller and ratticus and catkiller and rateye and palisade
		end,
	},
	requiredLevel = 150,
	playerPositions = {
		{ pos = Position(33893, 31388, 15), teleport = Position(33903, 31374, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33894, 31388, 15), teleport = Position(33903, 31374, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33895, 31388, 15), teleport = Position(33903, 31374, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33896, 31388, 15), teleport = Position(33903, 31374, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33897, 31388, 15), teleport = Position(33903, 31374, 15), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33887, 31342, 13),
		to = Position(33921, 31375, 15),
	},
	centerRoom = Position(33902, 31370, 15),

	exit = Position(33891, 31197, 7),

	onUseExtra = function(player)
		local specPos = {
			from = Position(33887, 31342, 13),
			to = Position(33921, 31375, 15),
		}

		local itemsToRemove = { 35686, 5542 }

		for x = specPos.from.x, specPos.to.x do
			for y = specPos.from.y, specPos.to.y do
				for z = specPos.from.z, specPos.to.z do
					local tile = Tile(Position(x, y, z))
					if tile then
						for _, itemId in ipairs(itemsToRemove) do
							local item = tile:getItemById(itemId)
							if item then
								item:remove()
							end
						end
					end
				end
			end
		end

		return true
	end,
}

local lever = BossLever(config)
lever:position(Position(33892, 31388, 15))
lever:register()
