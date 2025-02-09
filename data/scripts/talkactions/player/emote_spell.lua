local emoteSpell = TalkAction("!emote")

local validValues = {
	"on",
	"off",
}

function emoteSpell.onSay(player, words, param)
	if not configManager.getBoolean(configKeys.EMOTE_SPELLS) then
		player:sendTextMessage(MESSAGE_FAILURE, "Emote spells have been disabled by the administrator.")
		return true
	end

	if not table.contains(validValues, param) then
		local validValuesStr = table.concat(validValues, "/")
		player:sendTextMessage(MESSAGE_FAILURE, "Invalid param specified. Usage: !emote [" .. validValuesStr .. "]")
		return true
	end

	if param == "on" then
		player:setFeature(Features.EmoteSpells, true)
		player:sendTextMessage(MESSAGE_LOOK, "You have activated emote spells.")
	elseif param == "off" then
		player:setFeature(Features.EmoteSpells, false)
		player:sendTextMessage(MESSAGE_LOOK, "You have deactivated emote spells.")
	end
	return true
end

emoteSpell:separator(" ")
emoteSpell:groupType("normal")
emoteSpell:register()
