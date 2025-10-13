local setMotd = TalkAction("!setmotd")

function setMotd.onSay(player, words, param)
	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() ~= GUILDLEVEL_LEADER then
		player:sendCancelMessage("Only the guild leader can change the MOTD.")
		return true
	end

	local guildId = guild:getId()
	local newMotd = param ~= "" and param or ""
	if #newMotd > 255 then
		player:sendCancelMessage("The MOTD cannot exceed 255 characters.")
		return true
	end

	Game.setGuildMotd(guildId, newMotd)
	player:closeChannel(0x00)
	player:openChannel(0x00)
	return true
end

setMotd:separator(" ")
setMotd:channel(0)
setMotd:groupType("normal")
setMotd:register()
