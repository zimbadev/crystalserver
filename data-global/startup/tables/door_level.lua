--[[

Look README.md for look the reserved action/unique
Put the position of each range level doors
Just add new positions and it go work in the game

]]
LevelDoorAction = {
	-- Doors for level 20
	[1020] = {
		itemId = false,
		itemPos = {
			{ x = 32673, y = 32100, z = 8 },
		},
	},
	-- Doors for level 25
	[1025] = {
		{
			itemId = false,
			itemPos = {
				{ x = 32804, y = 31583, z = 2 },
			},
		},
		{ itemId = 5102, itemPos = { { x = 32325, y = 32389, z = 9 } } }, -- gate of expertise
	},
	-- Doors for level 30
	[1030] = {
		{
			itemId = false,
			itemPos = {
				{ x = 33302, y = 31691, z = 11 },
				{ x = 33302, y = 31692, z = 11 },
				{ x = 32567, y = 31969, z = 3 },
				{ x = 32479, y = 32174, z = 15 },
			},
		},
		{ -- gate of expertise
			itemId = 5111,
			itemPos = {
				{ x = 32479, y = 31634, z = 10 },
				{ x = 32486, y = 31633, z = 10 },
			},
		},
		{ -- gate of expertise
			itemId = 5102,
			itemPos = {
				{ x = 32483, y = 31630, z = 10 },
				{ x = 32483, y = 31635, z = 10 },
			},
		},
		{ itemId = 5129, itemPos = { { x = 32795, y = 32327, z = 10 } } }, -- gate of expertise
		{ -- gate of expertise
			itemId = 1680,
			itemPos = {
				{ x = 32825, y = 31093, z = 7 },
				{ x = 32911, y = 31082, z = 6 },
			},
		},
	},
	-- gate of expertise
	[1032] = {
		itemId = 1648,
		itemPos = { { x = 32510, y = 31956, z = 13 } },
	},
	-- Doors for level 35
	[1035] = {
		{
			itemId = false,
			itemPos = {
				{ x = 32448, y = 32042, z = 8 },
			},
		},
		{ itemId = 1648, itemPos = { { x = 32475, y = 31946, z = 13 } } }, -- gate of expertise
	},
	-- Doors for level 40
	[1040] = {
		{
			itemId = false,
			itemPos = {
				{ x = 32981, y = 31760, z = 9 },
				{ x = 32353, y = 32073, z = 11 },
				{ x = 32544, y = 32179, z = 14 },
				-- The Djinn War - The Efreet
				{ x = 33050, y = 32622, z = 6 },
				{ x = 33050, y = 32623, z = 6 },
				{ x = 33102, y = 32537, z = 6 },
				{ x = 33103, y = 32537, z = 6 },
			},
		},
		{ -- gate of expertise
			itemId = 8365,
			itemPos = {
				{ x = 32819, y = 31084, z = 8 },
				{ x = 32819, y = 31085, z = 8 },
			},
		},
		{ itemId = 9863, itemPos = { { x = 32826, y = 31496, z = 7 } } }, -- gate of expertise
		{ -- gate of expertise
			itemId = 5293,
			itemPos = {
				{ x = 33265, y = 32278, z = 7 },
				{ x = 33266, y = 32278, z = 7 },
			},
		},
		{ itemId = 5120, itemPos = { { x = 33271, y = 32418, z = 12 } } }, -- gate of expertise
	},
	-- Doors for level 45
	[1045] = {
		itemId = false,
		itemPos = {
			{ x = 32612, y = 32253, z = 7 },
			{ x = 32602, y = 32207, z = 10 },
		},
	},
	-- Doors for level 50
	[1050] = {
		{
			itemId = false,
			itemPos = {
				{ x = 32212, y = 32435, z = 10 },
				{ x = 32874, y = 31974, z = 12 },
				{ x = 32875, y = 31974, z = 12 },
			},
		},
		{ itemId = 6262, itemPos = { { x = 32234, y = 32140, z = 9 } } }, -- gate of expertise
		{ itemId = 5291, itemPos = { { x = 32554, y = 32860, z = 9 } } }, -- gate of expertise
		{ itemId = 1680, itemPos = { { x = 32909, y = 31074, z = 7 } } }, -- gate of expertise
		{ itemId = 1678, itemPos = { { x = 32910, y = 31088, z = 7 } } }, -- gate of expertise
		{ itemId = 9565, itemPos = { { x = 33775, y = 31699, z = 8 } } }, -- gate of expertise
	},
	-- Doors for level 60
	[1060] = {
		{
			itemId = false,
			itemPos = {
				{ x = 33085, y = 31650, z = 10 },
				{ x = 32223, y = 31869, z = 14 },
				{ x = 32483, y = 31722, z = 15 },
			},
		},
		{ itemId = 6264, itemPos = { { x = 32381, y = 32731, z = 4 } } }, -- gate of expertise
		{ itemId = 1680, itemPos = { { x = 32911, y = 31079, z = 6 } } }, -- gate of expertise
		{ -- gate of expertise
			itemId = 9565,
			itemPos = {
				{ x = 33032, y = 32398, z = 11 },
				{ x = 33037, y = 32398, z = 11 },
			},
		},
	},
	-- Doors for level 70
	[1070] = {
		itemId = false,
		itemPos = {
			{ x = 33190, y = 31684, z = 14 },
			{ x = 33195, y = 31684, z = 14 },
		},
	},
	-- Doors for level 80
	[1080] = {
		{
			itemId = false,
			itemPos = {
				{ x = 33297, y = 31670, z = 14 },
			},
		},
		{ itemId = 5120, itemPos = { { x = 31928, y = 32633, z = 10 } } }, -- gate of expertise
		{ itemId = 1680, itemPos = { { x = 32784, y = 31187, z = 9 } } }, -- gate of expertise
		{ itemId = 5102, itemPos = { { x = 32834, y = 32280, z = 10 } } }, -- gate of expertise
		{ itemId = 11237, itemPos = { { x = 33077, y = 31180, z = 8 } } }, -- gate of expertise
	},
	-- Doors for level 100
	[1100] = {
		{
			itemId = false,
			itemPos = {
				{ x = 33211, y = 31638, z = 13 },
				{ x = 33214, y = 31671, z = 13 },
			},
		},
		{ itemId = 1687, itemPos = { { x = 32808, y = 32631, z = 11 } } }, -- gate of expertise
		{ -- gate of expertise
			itemId = 11237,
			itemPos = {
				{ x = 33080, y = 31212, z = 5 },
				{ x = 33081, y = 31212, z = 5 },
			},
		},
	},

	-- ---------------------------------------------------------
	-- Declared here since the world.otbm stopped storing ids
	-- ---------------------------------------------------------
	-- gate of expertise
	[1999] = {
		itemId = 1696,
		itemPos = { { x = 32882, y = 32527, z = 11 } },
	},
}
