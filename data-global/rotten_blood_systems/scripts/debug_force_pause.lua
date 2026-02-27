local debugForcePause = TalkAction("/forcepause")

function debugForcePause.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local bossName = param:trim()
	if bossName == "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: /forcepause BossName")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Available: Vemiath, Chagorz, Bakragore")
		return false
	end

	-- Pausar spawn
	Game.setStorageValue(bossName .. "ElderBloodjawSpawnPaused", 1)
	Game.setStorageValue(bossName .. "TeleportPaused", 1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Forced pause for %s - Elder Bloodjaw spawn and teleport paused", bossName))

	-- Auto-reactivar después de 15 segundos
	addEvent(function()
		Game.setStorageValue(bossName .. "ElderBloodjawSpawnPaused", -1)
		Game.setStorageValue(bossName .. "TeleportPaused", -1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Auto-reactivated spawn for %s after 15 seconds", bossName))
	end, 15000)

	return false
end

debugForcePause:separator(" ")
debugForcePause:groupType("god")
debugForcePause:register()
