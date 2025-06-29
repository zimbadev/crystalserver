--[[

Look README.md for look the reserved action/unique

]]
QuestDoorAction = {
	-- Svargrond arena door
	[Storage.Quest.U8_0.BarbarianArena.PitDoor] = {
		itemId = false,
		itemPos = {
			{ x = 368, y = 229, z = 7 },
			{ x = 368, y = 230, z = 7 },
			{ x = 368, y = 231, z = 7 },
		},
	},
	[Storage.Quest.U8_0.BarbarianArena.GreenhornDoor] = {
		itemId = false,
		itemPos = { { x = 362, y = 197, z = 7 } },
	},
	[Storage.Quest.U8_0.BarbarianArena.ScrapperDoor] = {
		itemId = false,
		itemPos = { { x = 362, y = 190, z = 7 } },
	},
	[Storage.Quest.U8_0.BarbarianArena.WarlordDoor] = {
		itemId = false,
		itemPos = { { x = 362, y = 183, z = 7 } },
	},
	[Storage.Quest.U8_0.TheInquisitionQuest.RewardDoor] = {
		itemId = false,
		itemPos = { { x = 436, y = 434, z = 8 } },
	},
	-- The pits of inferno door
	[Storage.Quest.U7_8.ThePitsOfInferno.ShortcutHubDoor] = {
		itemId = false,
		itemPos = { { x = 537, y = 192, z = 6 } },
	},
	[Storage.Quest.U7_8.ThePitsOfInferno.ShortcutLeverDoor] = {
		itemId = false,
		itemPos = {
			{ x = 570, y = 179, z = 11 },
			{ x = 570, y = 180, z = 11 },
		},
	},
}

QuestDoorUnique = {
	--[[ Exxample of usage
	[22001] = {
		itemId = 11239,
		itemPos = { x = 32055, y = 31885, z = 6 },
	},]]
}
