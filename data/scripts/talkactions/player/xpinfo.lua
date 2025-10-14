local xpInfo = TalkAction("!xpinfo")

function xpInfo.onSay(player, words, param)
    local text = ""

	local xpBoostTimeLeft = player:getXpBoostTime()

	local xpBoostPercent = player:getXpBoostPercent()

    text = text .. "XP Boost: " .. xpBoostPercent .. "%"

	player:showTextDialog(639, text)
	return true
end

xpInfo:groupType("normal")
xpInfo:register()
