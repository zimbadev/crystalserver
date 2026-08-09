--[[
	A Piece of Cake - Cake Golem Raids.
	Aligned with server's actual SERVER SAVE (configManager/GLOBAL_SERVER_SAVE_TIME, e.g., "06:00"): 
		* 1st raid occurs CakeQuest.Config.RAID_OFFSET_MINUTES minutes AFTER the save (default: 4 min).
		* Subsequent raids repeat every CakeQuest.Config.RAID_INTERVAL_MINUTES minutes (default: 1h thereafter, throughout the day.
]]

-- Reads your server's actual server save time (config.lua:globalServerSaveTime, default "06:00") and schedules the raids based on it.
local saveTimeString = configManager.getString(configKeys.GLOBAL_SERVER_SAVE_TIME) or "06:00"
local saveHourStr, saveMinuteStr = saveTimeString:match("(%d+):(%d+)")
local saveMinutesTotal = (tonumber(saveHourStr) or 6) * 60 + (tonumber(saveMinuteStr) or 0)

local firstSlotMinutes = (saveMinutesTotal + CakeQuest.Config.RAID_OFFSET_MINUTES) % 1440
local slotsPerDay = math.ceil(1440 / CakeQuest.Config.RAID_INTERVAL_MINUTES)

for slot = 1, slotsPerDay do
	local slotMinutes = (firstSlotMinutes + (slot - 1) * CakeQuest.Config.RAID_INTERVAL_MINUTES) % 1440
	local slotHour = math.floor(slotMinutes / 60)
	local slotMinute = slotMinutes % 60
	local slotTimeString = ("%02d:%02d"):format(slotHour, slotMinute)

	local raidEvent = GlobalEvent("CakeQuestRaidSlot" .. slot)
	raidEvent.onTime = function(interval)
		CakeQuest.runRaid()
		return true
	end
	raidEvent:time(slotTimeString)
	raidEvent:register()
end
