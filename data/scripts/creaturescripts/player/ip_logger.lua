local playerIpLogger = CreatureEvent("PlayerIpLogger")

function playerIpLogger.onLogin(player)
	if not configManager.getBoolean(configKeys.LOG_PLAYER_IP) then
		return true
	end

	local function logIP()
		local file = io.open("data/logs/iplog.txt", "a")
		if file then
			file:write(string.format("[%s] %s | AccID: %d | IP: %s\n", os.date("%Y-%m-%d %H:%M:%S"), player:getName(), player:getAccountId(), Game.convertIpToString(player:getIp())))
			file:close()
		end
	end

	pcall(logIP)
	return true
end

playerIpLogger:register()
