local addhtpCommand = TalkAction("/addhtp")

function addhtpCommand.onSay(player, words, param)
	if not param or param:len() == 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Usage: /addhtp {PlayerName},{points}")
		return false
	end

	local params = param:split(",")
	if #params < 2 then
		player:sendTextMessage(MESSAGE_LOOK, "Usage: /addhtp {PlayerName},{points}")
		return false
	end

	local targetName = params[1]:trim()
	local points = tonumber(params[2]:trim())
	if not points or points <= 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Invalid amount.")
		return false
	end

	local target = Player(targetName)
	if not target then
		player:sendTextMessage(MESSAGE_LOOK, string.format("Player %s not found.", targetName))
		return false
	end

	target:addTaskHuntingPoints(points)
	player:sendTextMessage(MESSAGE_LOOK, string.format("Added %d Hunting Task Points to %s.", points, targetName))
	target:sendTextMessage(MESSAGE_LOOK, string.format("You received %d Hunting Task Points.", points))
	return true
end

addhtpCommand:separator(" ")
addhtpCommand:setDescription("[Usage]: /addhtp {PlayerName},{points} - Add Hunting Task Points")
addhtpCommand:groupType("god")
addhtpCommand:register()
