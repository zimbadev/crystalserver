--[[

Look README.md for look the reserved action/unique

]]
CorpseAction = {
	-- 6 itens diferentes com o mesmo action id
	[2001] = {
		{ itemId = 4285, itemPos = { { x = 32211, y = 31273, z = 10 } } }, -- pile of bones
		{ itemId = 4024, itemPos = { { x = 32258, y = 31098, z = 10 } } }, -- slain skeleton
		{ itemId = 4240, itemPos = { { x = 32514, y = 32248, z = 8 } } }, -- dead human
		{ itemId = 3634, itemPos = { { x = 32876, y = 31958, z = 11 } } }, -- dead tree
		{ itemId = 10205, itemPos = { { x = 33054, y = 31312, z = 8 } } }, -- pile of bones
		{ itemId = 6082, itemPos = { { x = 33146, y = 32341, z = 8 } } }, -- dead human
	},
	[20001] = {
		itemId = false,
		itemPos = { { x = xxxxx, y = xxxxx, z = xx } },
	},
	-- Others actions
	-- Threatened dreams quest
	[20002] = {
		itemId = 4285,
		itemPos = { { x = 32949, y = 31810, z = 7 } },
	},
	-- The cursed crystal skeletons
	[40001] = {
		itemId = 4285,
		itemPos = {
			{ x = 31974, y = 32907, z = 8 },
			{ x = 32031, y = 32914, z = 8 },
		},
	},
	-- The Great Dragon Hunt Quest
	[50806] = {
		itemId = 21412,
		itemPos = {
			{ x = 32991, y = 32642, z = 8 },
		},
	},
}

CorpseUnique = {
	-- human remains
	[3111] = {
		itemId = 3133,
		itemPos = { x = 32455, y = 31165, z = 12 },
	},
	-- The Ice Island Quest - Skeleton
	[3112] = {
		itemId = 4024,
		itemPos = { x = 32258, y = 31098, z = 10 },
	},
	-- Tinder Box Quest - Chyllfroest
	[3263] = {
		itemId = 4285,
		itemPos = { x = 32085, y = 31025, z = 1 },
	},
	-- sarcophagus
	[3503] = {
		itemId = 1994,
		itemPos = { x = 33235, y = 32803, z = 12 },
	},
	-- stone coffin
	[3505] = {
		itemId = 1983,
		itemPos = { x = 32122, y = 31912, z = 14 },
	},
	-- pile of bones
	[9259] = {
		itemId = 10205,
		itemPos = { x = 33054, y = 31312, z = 8 },
	},
	-- Dark trails (Quandon corpse)
	-- Path: data\scripts\actions\quests\dark_trails\corpse.lua
	[20001] = {
		itemId = 21123,
		itemPos = { x = 33574, y = 31952, z = 6 },
	},
	-- Lions rock corpse
	-- Path: data\scripts\actions\quests\lions_rock\lions_rock.lua
	[20002] = {
		itemId = 6082,
		itemPos = { x = 33146, y = 32341, z = 8 },
	},
	-- The Ice Island Quest - Formorgar Mines Hoist - Skeleton
	[20003] = {
		itemId = 4285,
		itemPos = { x = 32211, y = 31273, z = 10 },
	},

	-- ---------------------------------------------------------
	-- Declared here since the world.otbm stopped storing ids
	-- ---------------------------------------------------------
	-- sarcophagus
	[50949] = {
		itemId = 1994,
		itemPos = { x = 33145, y = 32663, z = 15 },
	},
	-- sarcophagus
	[50950] = {
		itemId = 1994,
		itemPos = { x = 33174, y = 32932, z = 15 },
	},
	-- sarcophagus
	[50951] = {
		itemId = 1994,
		itemPos = { x = 33349, y = 32825, z = 14 },
	},
	-- sarcophagus
	[50952] = {
		itemId = 1994,
		itemPos = { x = 33126, y = 32589, z = 15 },
	},
	-- sarcophagus
	[50953] = {
		itemId = 1994,
		itemPos = { x = 33186, y = 33010, z = 14 },
	},
	-- sarcophagus
	[50954] = {
		itemId = 1994,
		itemPos = { x = 33182, y = 32712, z = 14 },
	},
	-- sarcophagus
	[50955] = {
		itemId = 1994,
		itemPos = { x = 33041, y = 32772, z = 14 },
	},
}
