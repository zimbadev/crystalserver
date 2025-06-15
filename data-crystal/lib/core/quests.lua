if not Quests then
	Quests = {
		[1] = {
			name = "The Ultimate Challenges",
			startStorageId = Storage.Quest.U8_0.BarbarianArena.QuestLogGreenhorn,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "Barbarian Arena - Greenhorn Mode",
					storageId = Storage.Quest.U8_0.BarbarianArena.QuestLogGreenhorn,
					missionId = 10312,
					startValue = 1,
					endValue = 2,
					states = {
						[1] = "You have to defeat all enemies in this mode.",
						[2] = "You have defeated all enemies in this mode.",
					},
				},
				[2] = {
					name = "Barbarian Arena - Scrapper Mode",
					storageId = Storage.Quest.U8_0.BarbarianArena.QuestLogScrapper,
					missionId = 10313,
					startValue = 1,
					endValue = 2,
					states = {
						[1] = "You have to defeat all enemies in this mode.",
						[2] = "You have defeated all enemies in this mode.",
					},
				},
				[3] = {
					name = "Barbarian Arena - Warlord Mode",
					storageId = Storage.Quest.U8_0.BarbarianArena.QuestLogWarlord,
					missionId = 10314,
					startValue = 1,
					endValue = 2,
					states = {
						[1] = "You have to defeat all enemies in this mode.",
						[2] = "You have defeated all enemies in this mode.",
					},
				},
			},
		},
			[2] = {
			name = "The Inquisition",
			startStorageId = Storage.Quest.U8_0.TheInquisitionQuest.Questline,
			startStorageValue = 2,
			missions = {
				[1] = {
					name = "The Shadow Nexus",
					storageId = Storage.Quest.U8_0.TheInquisitionQuest.Mission07,
					missionId = 10251,
					startValue = 1,
					endValue = 5,
					states = {
						[1] = "Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. \z
						The Demon Forge is located in the Thyranox Hero Cave, through a portal after the Vampire Shield Quest.",
						[2] = "You destroyed the shadow nexus! Get back to Karmia City and report your mission to Henricus.",
						[3] = "Now ask to Henricus for a outfit. He will give you the 2nd addon of the Demon Hunter Outfits.",
						[4] = "You got the the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!",
						[5] = "You have completed The Inquisition Quest! You can now buy the Blessing of the Inquisition!",
					},
				},
			},
		},
	}
end
