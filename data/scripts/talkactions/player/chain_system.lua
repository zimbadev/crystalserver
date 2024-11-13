local feature = TalkAction("!chain")

local validValues = {
	"on",
	"off",
}

function feature.onSay(player, words, param)
	if not configManager.getBoolean(configKeys.TOGGLE_CHAIN_SYSTEM) then
		return true
	end

	if not table.contains(validValues, param) then
		local validValuesStr = table.concat(validValues, "/")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid param specified. Usage: !chain [" .. validValuesStr .. "]")
		return true
	end

	if param == "on" then
		player:setFeature(Features.ChainSystem, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Chain System is now enabled.")
	elseif param == "off" then
		player:setFeature(Features.ChainSystem, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Chain System is now disabled.")
	end
	return true
end

feature:separator(" ")
feature:groupType("normal")
feature:register()
