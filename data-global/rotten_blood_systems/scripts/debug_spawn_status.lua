local debugSpawnStatus = TalkAction("/debugspawn")

function debugSpawnStatus.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local bosses = { "Vemiath", "Chagorz", "Bakragore" }

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "=== Elder Bloodjaw Spawn Status ===")

	for _, bossName in ipairs(bosses) do
		local teleportPaused = Game.getStorageValue(bossName .. "TeleportPaused")
		local spawnPaused = Game.getStorageValue(bossName .. "ElderBloodjawSpawnPaused")

		local teleportStatus = (teleportPaused == 1) and "PAUSED" or "ACTIVE"
		local spawnStatus = (spawnPaused == 1) and "PAUSED" or "ACTIVE"

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s: Teleport=%s (%d), Spawn=%s (%d)", bossName, teleportStatus, teleportPaused, spawnStatus, spawnPaused))
	end

	return false
end

debugSpawnStatus:separator(" ")
debugSpawnStatus:groupType("god")
debugSpawnStatus:register()
