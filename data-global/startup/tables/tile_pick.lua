-- Look README.md for see the reserved action/unique numbers
-- It is for the pickable tiles (on use pick)

TilePickAction = {
	-- Pickable tiles, add new position and it create in-game
	[101] = {
		{
			itemId = false,
			itemPos = {
				{ x = 32774, y = 32289, z = 10 },
				{ x = 33094, y = 31626, z = 13 },
				{ x = 33081, y = 31651, z = 11 },
				{ x = 32266, y = 31892, z = 12 },
				{ x = 32266, y = 31916, z = 12 },
				{ x = 32204, y = 31887, z = 14 },
				{ x = 32165, y = 31890, z = 14 },
				{ x = 32162, y = 31921, z = 13 },
				{ x = 32149, y = 32110, z = 11 },
				{ x = 32302, y = 32257, z = 8 }, -- Battle Axe Quest
				{ x = 32437, y = 32239, z = 10 }, -- Life Ring Quest
				{ x = 32775, y = 32012, z = 10 },
				{ x = 32595, y = 32068, z = 9 },
				{ x = 32580, y = 32103, z = 11 },
				{ x = 32517, y = 32107, z = 14 },
				-- The Explorer Society
				{ x = 32295, y = 31441, z = 8 },
			},
		},
		{ -- dirt floor
			itemId = 355,
			itemPos = {
				{ x = 31947, y = 32593, z = 9 },
				{ x = 32323, y = 32418, z = 8 },
				{ x = 32328, y = 32413, z = 7 },
				{ x = 32346, y = 32360, z = 8 },
				{ x = 32363, y = 31967, z = 12 },
				{ x = 32371, y = 31990, z = 12 },
				{ x = 32377, y = 32029, z = 12 },
				{ x = 32377, y = 32056, z = 11 },
				{ x = 32380, y = 32078, z = 10 },
				{ x = 32385, y = 31970, z = 12 },
				{ x = 32402, y = 32022, z = 11 },
				{ x = 32418, y = 32056, z = 11 },
				{ x = 32426, y = 32029, z = 11 },
				{ x = 32794, y = 32334, z = 8 },
				{ x = 32805, y = 31258, z = 8 },
				{ x = 32851, y = 32285, z = 9 },
				{ x = 32856, y = 32252, z = 8 },
			},
		},
		{ itemId = 3221, itemPos = { { x = 31948, y = 31711, z = 6 } } }, -- Santas Mailbox
		{ itemId = 353, itemPos = { { x = 32497, y = 31888, z = 7 } } }, -- dirt floor
	},
}
