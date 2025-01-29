local featrue = TalkAction("!spellwords")

local validValues = {
	"on",
	"off",
}

function featrue.onSay(player, words, param)
	if not configManager.getBoolean(configKeys.EMOTE_SPELLS) then
		player:sendTextMessage(MESSAGE_FAILURE, "Spell name instead of words have been disabled by the administrator.")
		return true
	end

	if not table.contains(validValues, param) then
		local validValuesStr = table.concat(validValues, "/")
		player:sendTextMessage(MESSAGE_FAILURE, "Invalid param specified. Usage: !spellwords [" .. validValuesStr .. "]")
		return true
	end

	if param == "on" then
		player:setFeature(Features.SpellNameInsteadOfWords, true)
		player:sendTextMessage(MESSAGE_LOOK, "You have activated spell name instead of words.")
	elseif param == "off" then
		player:setFeature(Features.SpellNameInsteadOfWords, false)
		player:sendTextMessage(MESSAGE_LOOK, "You have deactivated spell name instead of words.")
	end
	return true
end

featrue:separator(" ")
featrue:groupType("normal")
featrue:register()
