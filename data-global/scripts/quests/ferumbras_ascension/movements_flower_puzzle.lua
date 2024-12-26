local positions = {
	[1] = {
		squarePos = Position(33452, 32721, 14),
		flowerOne = Position(33455, 32685, 14),
		flowerTwo = Position(33455, 32686, 14),
		flowerThree = Position(33455, 32687, 14),
	},
	[2] = {
		squarePos = Position(33455, 32721, 14),
		flowerOne = Position(33456, 32685, 14),
		flowerTwo = Position(33456, 32686, 14),
		flowerThree = Position(33456, 32687, 14),
	},
	[3] = {
		squarePos = Position(33458, 32721, 14),
		flowerOne = Position(33457, 32685, 14),
		flowerTwo = Position(33457, 32686, 14),
		flowerThree = Position(33457, 32687, 14),
	},
	[4] = {
		squarePos = Position(33461, 32721, 14),
		flowerOne = Position(33458, 32685, 14),
		flowerTwo = Position(33458, 32686, 14),
		flowerThree = Position(33458, 32687, 14),
	},
	[5] = {
		squarePos = Position(33464, 32721, 14),
		flowerOne = Position(33459, 32685, 14),
		flowerTwo = Position(33459, 32686, 14),
		flowerThree = Position(33459, 32687, 14),
	},
	[6] = {
		squarePos = Position(33467, 32721, 14),
		flowerOne = Position(33460, 32685, 14),
		flowerTwo = Position(33460, 32686, 14),
		flowerThree = Position(33460, 32687, 14),
	}, -- done
	[7] = {
		squarePos = Position(33452, 32724, 14),
		flowerOne = Position(33455, 32691, 14),
		flowerTwo = Position(33455, 32692, 14),
		flowerThree = Position(33455, 32693, 14),
	},
	[8] = {
		squarePos = Position(33455, 32724, 14),
		flowerOne = Position(33456, 32691, 14),
		flowerTwo = Position(33456, 32692, 14),
		flowerThree = Position(33456, 32693, 14),
	},
	[9] = {
		squarePos = Position(33458, 32724, 14),
		flowerOne = Position(33457, 32691, 14),
		flowerTwo = Position(33457, 32692, 14),
		flowerThree = Position(33457, 32693, 14),
	},
	[10] = {
		squarePos = Position(33461, 32724, 14),
		flowerOne = Position(33458, 32691, 14),
		flowerTwo = Position(33458, 32692, 14),
		flowerThree = Position(33458, 32693, 14),
	},
	[11] = {
		squarePos = Position(33464, 32724, 14),
		flowerOne = Position(33459, 32691, 14),
		flowerTwo = Position(33459, 32692, 14),
		flowerThree = Position(33459, 32693, 14),
	},
	[12] = {
		squarePos = Position(33467, 32724, 14),
		flowerOne = Position(33460, 32691, 14),
		flowerTwo = Position(33460, 32692, 14),
		flowerThree = Position(33460, 32693, 14),
	}, -- done
	[13] = {
		squarePos = Position(33452, 32727, 14),
		flowerOne = Position(33455, 32707, 14),
		flowerTwo = Position(33455, 32708, 14),
		flowerThree = Position(33455, 32709, 14),
	},
	[14] = {
		squarePos = Position(33455, 32727, 14),
		flowerOne = Position(33456, 32707, 14),
		flowerTwo = Position(33456, 32708, 14),
		flowerThree = Position(33456, 32709, 14),
	},
	[15] = {
		squarePos = Position(33458, 32727, 14),
		flowerOne = Position(33457, 32707, 14),
		flowerTwo = Position(33457, 32708, 14),
		flowerThree = Position(33457, 32709, 14),
	},
	[16] = {
		squarePos = Position(33461, 32727, 14),
		flowerOne = Position(33458, 32707, 14),
		flowerTwo = Position(33458, 32708, 14),
		flowerThree = Position(33458, 32709, 14),
	},
	[17] = {
		squarePos = Position(33464, 32727, 14),
		flowerOne = Position(33459, 32707, 14),
		flowerTwo = Position(33459, 32708, 14),
		flowerThree = Position(33459, 32709, 14),
	},
	[18] = {
		squarePos = Position(33467, 32727, 14),
		flowerOne = Position(33460, 32707, 14),
		flowerTwo = Position(33460, 32708, 14),
		flowerThree = Position(33460, 32709, 14),
	},
}

local flowerPuzzle = MoveEvent()

function clearFlowers(tiles)
	for _, tile in ipairs(tiles) do
		local items = tile:getItems()
		for i = 1, #items do
			if items[i]:getId() == 3676 or items[i]:getId() == 3677 or items[i]:getId() == 3678 then
				items[i]:remove()
			end
		end
	end
end

function flowerPuzzle.onStepIn(creature, item, position, fromPosition)
	for i, itempos in ipairs(positions) do
		if position == itempos.squarePos then
			local flowerOneTile = Tile(itempos.flowerOne)
			local flowerTwoTile = Tile(itempos.flowerTwo)
			local flowerThreeTile = Tile(itempos.flowerThree)
			local flowerTiles = { flowerOneTile, flowerTwoTile, flowerThreeTile }

			local itemId
			if i <= 6 then
				itemId = 3677
			elseif i <= 12 then
				itemId = 3678
			else
				itemId = 3676
			end

			local step = item.itemid - 22538 + 1

			if step == 4 then
				clearFlowers(flowerTiles)
				item:transform(22538)
			else
				clearFlowers(flowerTiles)
				Game.createItem(itemId, 1, flowerTiles[step]:getPosition())
				item:transform(item.itemid + 1)
			end

			return true
		end
	end
	return false
end

flowerPuzzle:type("stepin")
flowerPuzzle:id(22538, 22539, 22540, 22541)
flowerPuzzle:register()
