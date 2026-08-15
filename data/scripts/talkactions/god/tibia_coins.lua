local addtcCommand = TalkAction("/addtc")
function addtcCommand.onSay(player, words, param)
	if not param or param:len() == 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Usage: /addtc {PlayerName},{amount}")
		return false
	end
	local params = param:split(",")
	if #params < 2 then
		player:sendTextMessage(MESSAGE_LOOK, "Usage: /addtc {PlayerName},{amount}")
		return false
	end
	local targetName = params[1]:trim()
	local amount = tonumber(params[2]:trim())
	if not amount or amount <= 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Invalid amount.")
		return false
	end
	local target = Player(targetName)
	if not target then
		player:sendTextMessage(MESSAGE_LOOK, string.format("Player %s not found.", targetName))
		return false
	end
	target:addTibiaCoins(amount)
	player:sendTextMessage(MESSAGE_LOOK, string.format("Added %d non-transferable Tibia Coins to %s.", amount, targetName))
	target:sendTextMessage(MESSAGE_LOOK, string.format("You received %d non-transferable Tibia Coins.", amount))
	return true
end
addtcCommand:separator(" ")
addtcCommand:setDescription("[Usage]: /addtc {PlayerName},{amount} - Add normal Tibia Coins")
addtcCommand:groupType("god")
addtcCommand:register()

local addttcCommand = TalkAction("/addttc")
function addttcCommand.onSay(player, words, param)
	if not param or param:len() == 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Usage: /addttc {PlayerName},{amount}")
		return false
	end
	local params = param:split(",")
	if #params < 2 then
		player:sendTextMessage(MESSAGE_LOOK, "Usage: /addttc {PlayerName},{amount}")
		return false
	end
	local targetName = params[1]:trim()
	local amount = tonumber(params[2]:trim())
	if not amount or amount <= 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Invalid amount.")
		return false
	end
	local target = Player(targetName)
	if not target then
		player:sendTextMessage(MESSAGE_LOOK, string.format("Player %s not found.", targetName))
		return false
	end
	target:addTransferableCoins(amount)
	player:sendTextMessage(MESSAGE_LOOK, string.format("Added %d transferable Tibia Coins to %s.", amount, targetName))
	target:sendTextMessage(MESSAGE_LOOK, string.format("You received %d transferable Tibia Coins.", amount))
	return true
end
addttcCommand:separator(" ")
addttcCommand:setDescription("[Usage]: /addttc {PlayerName},{amount} - Add transferable Tibia Coins")
addttcCommand:groupType("god")
addttcCommand:register()
