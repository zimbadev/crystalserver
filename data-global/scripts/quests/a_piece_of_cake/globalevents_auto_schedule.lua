--[[ 
	A Piece of Cake - Auto Schedule
	It works in two ways:
		1) onTime("06:00") - a daily check;
		2) onStartup - runs immediately when the server starts up.
	Try to covers the scenario where you change the date to "today" and restart the server.
	
	
	To test it outside the official window, use `/cakequest start`.
]]
local function checkSchedule()
	local withinWindow = CakeQuest.isWithinEventWindow()
	local stage = CakeQuest.getStage()

	if CakeQuest.shouldAutoStartToday() then
		CakeQuest.startFreshOccurrence()
		Game.broadcastMessage("A Piece of Cake has begun! Cake Golems are attacking the cities - deliver Sweet and Sugary Substances and lure golems to the extraction machines!", MESSAGE_EVENT_ADVANCE)
		return
	end

	if not withinWindow then
		if stage == 1 then
			CakeQuest.setStage(0)
			Game.broadcastMessage("The World Quest window has ended - the Cake Golems retreat. Better luck next year!", MESSAGE_EVENT_ADVANCE)
		end
		if stage >= 2 then
			CakeQuest.endOfEventCleanup()
		end
	end
end

local cakeAutoScheduleDaily = GlobalEvent("CakeQuestAutoScheduleDaily")
function cakeAutoScheduleDaily.onTime(interval)
	checkSchedule()
	return true
end
cakeAutoScheduleDaily:time("06:00")
cakeAutoScheduleDaily:register()

local cakeAutoScheduleStartup = GlobalEvent("CakeQuestAutoScheduleStartup")
function cakeAutoScheduleStartup.onStartup()
	checkSchedule()
	return true
end
cakeAutoScheduleStartup:register()
