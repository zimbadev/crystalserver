local shared = TalkAction("!shared")

function shared.onSay(player, words, param)
	if player then
		local text = "-- Party Info -- \n\n"
		text = text .. "-----------\n"
		text = text .. "Min Level: " .. math.ceil((player:getLevel() * 2) / 3) .. "  \n"
		text = text .. "Max Level: " .. math.ceil((player:getLevel() * player:getLevel()) / ((player:getLevel() * 2) / 3)) .. "  \n"
		text = text .. "-----------\n"
		player:showTextDialog(34266, text)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
	return false
end

shared:groupType("normal")
shared:register()
