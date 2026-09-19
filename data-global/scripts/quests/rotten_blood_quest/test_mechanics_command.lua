local logger = Spdlog.info

local testMechanics = TalkAction("/testmechanics")

function testMechanics.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local params = param:split(",")
	local action = params[1] and params[1]:trim():lower()
	local bossName = params[2] and params[2]:trim()

	if action == "disable" and bossName then
		Game.setStorageValue("boss" .. bossName .. "NoFunctions", 1)
		Game.setStorageValue(bossName .. "TeleportPaused", 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss " .. bossName .. " mechanics disabled")
		logger("Player " .. player:getName() .. " disabled mechanics for boss " .. bossName)
	elseif action == "enable" and bossName then
		Game.setStorageValue("boss" .. bossName .. "NoFunctions", -1)
		Game.setStorageValue(bossName .. "TeleportPaused", -1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss " .. bossName .. " mechanics enabled")
		logger("Player " .. player:getName() .. " enabled mechanics for boss " .. bossName)
	elseif action == "status" and bossName then
		local mechanicsStatus = Game.getStorageValue("boss" .. bossName .. "NoFunctions") == 1 and "DISABLED" or "ENABLED"
		local teleportStatus = Game.getStorageValue(bossName .. "TeleportPaused") == 1 and "PAUSED" or "ACTIVE"

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss " .. bossName .. ":")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "  Mechanics: " .. mechanicsStatus)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "  Teleport: " .. teleportStatus)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage:")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "/testmechanics disable, Vemiath")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "/testmechanics enable, Vemiath")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "/testmechanics status, Vemiath")
	end

	return false
end

testMechanics:separator(" ")
testMechanics:groupType("god")
testMechanics:register()
