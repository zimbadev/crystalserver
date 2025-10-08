if not Quests then
	Quests = {
		[1] = {
			name = "The Ultimate Challenges",
			startStorageId = Storage.Quest.U8_0.BarbarianArena.QuestLogGreenhorn,
			startStorageValue = 1,
			missions = {},
		},
  [2] = {
              name = "KosOTS HunterSquad",
              			startStorageId = Storage.KosOts.TaskSystem.QuestLogEntry,
              			startStorageValue = 1,
              			missions = {
              				[1] = {
              					name = "Task Points",
                                  storageId = Storage.KosOts.TaskSystem.QuestLinePoints,
                                  missionId = 2000,
                                	startValue = 0,
                                	endValue = 1,
                                	description = function(player)
                                		return string.format("You joined the 'KosOTS HunterSquad'. Ask Billy The Tasker for some hunting tasks. You already gained %d points.", (math.max(player:getStorageValue(Storage.KosOts.TaskSystem.POINTSSTORAGE), 0)))
                                	end,
              				}
              			},
          },
	}

	local modes = {
		{ name = "Greenhorn", storage = Storage.Quest.U8_0.BarbarianArena.QuestLogGreenhorn, missionId = 10312 },
		{ name = "Scrapper", storage = Storage.Quest.U8_0.BarbarianArena.QuestLogScrapper, missionId = 10313 },
		{ name = "Warlord", storage = Storage.Quest.U8_0.BarbarianArena.QuestLogWarlord, missionId = 10314 },
	}

	for i, mode in ipairs(modes) do
		Quests[1].missions[i] = {
			name = "Barbarian Arena - " .. mode.name .. " Mode",
			storageId = mode.storage,
			missionId = mode.missionId,
			startValue = 1,
			endValue = 2,
			states = {
				[1] = "You have to defeat all enemies in this mode.",
				[2] = "You have defeated all enemies in this mode.",
			},
		}
	end
end
