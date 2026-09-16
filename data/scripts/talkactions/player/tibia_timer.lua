local statusTime = TalkAction("!time")
function statusTime.onSay(player, words, param)
	local period = getTibiaTimerDayOrNight()
	local message = string.format("The time is " .. getFormattedWorldTime() .. ". It is %s.", period)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	return false
end

statusTime:groupType("normal")
statusTime:register()
