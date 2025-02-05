--[[
Reserved player action storage key ranges (const.hpp)
	It is possible to place the storage in a quest door, so the player who has that storage will go through the door

	Reserved player action storage key ranges (const.hpp at the source)
	[10000000 - 20000000]
	[1000 - 1500]
	[2001 - 2011]

	Others reserved player action/storages
	[100] = unmovable/untrade/unusable items
	[101] = use pick floor
	[102] = well down action
	[103-120] = others keys action
	[103] = key 0010
	[303] = key 0303
	[1000] = level door. Here 1 must be used followed by the level.
	Example: 1010 = level 10,
	1100 = level 100]

	Questline = Storage through the Quest
]]

Storage = {
	-- Crystal Server storages
	-- Tiquanda
	CrystalServer = {
		Citizen = {
			DesertCity = 9056,
			Inferno = 9057,
			Venore = 9058,
			Karmia = 9059,
			Tiquanda = 9060,
			PremiumIsland = 9061,
			Folda = 9062,
			LibertyBay = 9063,
		},
		AdventurersGuild = {
			Stone = 52130,
			FreeStone = 52131,
		},
		Quests = {
			Behemoth = {
				GuardianHalberd = 5006,
				DemonShield = 5007,
				GoldenArmor = 5008,
			},
			CobraBastion = {
				Questline = 52311,
			},
			DemonHelmet = {
				Lever = 14031,
				SteelBoots = 5003,
				DH = 5004,
				DemonShield = 5005,
			},
			Rookgaard = {
				Mace = 5000,
				ChainHelmet = 5001,
				ChainArmor = 5002,
			},
			WelcomeToCrystalServer = {
				Start = 40000,
				Mission = 40001,
			},
		},
		HydrasCampLever = 14030,
		TrainingRoom = {
			NORTH = 2017,
			SOUTH = 2018,
			WEST = 2019,
			EAST = 2020,
		},
		UnderWater = {
			S1 = 4550,
			S2 = 4551,
			S3 = 4552,
			S4 = 4553,
			S5 = 4554,
			S6 = 4555,
			S7 = 4556,
			S8 = 4557,
		},
		Portals = {
			S1 = 4558,
			S2 = 4559,
		},
	},

	Quest = {
		Key = {
			ID1000 = 103,
		},
		ExampleQuest = {
			Example = 9000,
			Door = 9001,
		},
	},

	Imbuement = 30004,
}

GlobalStorage = {
	ExampleQuest = {
		Example = 60000,
	},
	KeysUpdate = 40000, -- Reserved storage from 40000 - 40000
}

startupGlobalStorages = {}
