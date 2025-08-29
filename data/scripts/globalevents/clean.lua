function executeClean(interval)
	cleanMap()
	local message = "Game map cleaned, next clean in " .. string.diff(interval / 1000) .. "."
	Game.broadcastMessage(message, MESSAGE_GAME_HIGHLIGHT)
	return true
end

local autoCleanTick = GlobalEvent("autoClean.onThink")
function autoCleanTick.onThink(interval, lastExecution)
	Game.broadcastMessage("Game map cleaning within 30 seconds, please pick up your items!", MESSAGE_GAME_HIGHLIGHT)
	addEvent(executeClean, 30000, interval)
	return true
end

autoCleanTick:interval(7200000)
autoCleanTick:register()
