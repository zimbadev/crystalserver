local mute = TalkAction("/mute")

function mute.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	if param == "" then
		player:sendCancelMessage("You must specify a player. Usage: /mute playerName.")
		return true
	end

	local split = param:split(",")
	local targetName = split[1]:trim()
	local target = Player(targetName)

	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return true
	end

	if target:getGroup():getId() >= GROUP_TYPE_GAMEMASTER then
		player:sendCancelMessage("You cannot mute this character.")
		return true
	end

	target:setFeature(Features.MutePlayer, true)
	player:popupFYI(target:getName() .. " has been muted.")
	return true
end

mute:separator(" ")
mute:groupType("god")
mute:register()

---------------- // ----------------
local unmute = TalkAction("/unmute")

function unmute.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	if param == "" then
		player:sendCancelMessage("You must specify a player. Usage: /unmute playerName.")
		return true
	end

	local targetName = param:trim()
	local target = Player(targetName)

	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return true
	end

	target:setFeature(Features.MutePlayer, false)
	player:popupFYI(target:getName() .. " has been unmuted.")
	return true
end

unmute:separator(" ")
unmute:groupType("god")
unmute:register()
