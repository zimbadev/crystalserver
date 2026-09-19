--[[
	A Piece of Cake - Cake Server Save
	Runs exactly at your server's real server-save time. If the ground floor's final round was already won, activates Brutus and the world bonus and spawns Brutus on the isle.
]]

local cakeServerSaveCompletion = GlobalEvent("CakeQuestServerSaveCompletion")

function cakeServerSaveCompletion.onTime(interval)
	if CakeQuest.get(CakeQuest.Keys.PendingBrutusBonus, false) then
		CakeQuest.activateBrutusAndBonus()
	end
	return true
end

local saveTimeString = configManager.getString(configKeys.GLOBAL_SERVER_SAVE_TIME) or "06:00"
cakeServerSaveCompletion:time(saveTimeString)
cakeServerSaveCompletion:register()
