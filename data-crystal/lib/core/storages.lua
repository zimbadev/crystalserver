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
			Frostania = 9064,
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

		-- DODAJEMY DEMON OAK TUTAJ
		U8_2 = {
			TheDemonOak = {
				AxeBlowsBird = 10001,
				AxeBlowsLeft = 10002,
				AxeBlowsRight = 10003,
				AxeBlowsFace = 10004,
				Done = 10005,
				Progress = 10006,
				Squares = 10007,
			},
		},
		-- DODAJEMY BARBARIAN ARENA (U8_0)
		U8_0 = { -- update 8.0 - Reserved Storages 41151 - 41350
			BarbarianArena = {
				Arena = 41151,
				PitDoor = 41152,
				QuestLogGreenhorn = 41153,
				QuestLogScrapper = 41154,
				QuestLogWarlord = 41155,
				RewardGreenhorn = 41156,
				RewardGreenhornWeapons = 41157,
				RewardGreenhornBP = 41158,
				RewardGreenhornPresent = 41159,
				RewardScrapper = 41160,
				RewardScrapperWeapons = 41161,
				RewardScrapperBP = 41162,
				RewardScrapperPresent = 41163,
				RewardWarlord = 41164,
				RewardWarlordWeapons = 41165,
				RewardWarlordBP = 41166,
				RewardWarlordPresent = 41167,
				TrophyGreenhorn = 41168,
				TrophyScrapper = 41169,
				TrophyWarlord = 41170,
				GreenhornDoor = 41171,
				ScrapperDoor = 41172,
				WarlordDoor = 41173,
			},
			TheInquisitionQuest = {
				Questline = 41691,
				Mission07 = 41698,
				RewardDoor = 41699,
				EnterTeleport = 41706,
				Reward = 41707,
				RewardRoomText = 41708,
			},
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
