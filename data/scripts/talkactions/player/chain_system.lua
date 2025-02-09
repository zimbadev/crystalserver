local feature = TalkAction("!chain")

local validValues = {
	"on",
	"off",
}

function feature.onSay(player, words, param)
	if not configManager.getBoolean(configKeys.TOGGLE_CHAIN_SYSTEM) then
		player:sendTextMessage(MESSAGE_FAILURE, "Chain system have been disabled by the administrator.")
		return true
	end

	if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) and configManager.getBoolean(configKeys.CHAIN_SYSTEM_VIP_ONLY) and not player:isVip() then
		player:sendCancelMessage("You need to be VIP to use this command!")
		return true
	end

	if not table.contains(validValues, param) then
		local validValuesStr = table.concat(validValues, "/")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid param specified. Usage: !chain [" .. validValuesStr .. "]")
		return true
	end

	if param == "on" then
		player:setFeature(Features.ChainSystem, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Chain System is now enabled.")
	elseif param == "off" then
		player:setFeature(Features.ChainSystem, false)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Chain System is now disabled.")
	end
	return true
end

feature:separator(" ")
feature:groupType("normal")
feature:register()
