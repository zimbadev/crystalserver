local blessTalkAction = TalkAction("/blessplayer")

function blessTalkAction.onSay(player, words, param)
	local target = player
	if param ~= "" then
		target = Player(param)
		if not target then
			player:sendCancelMessage("Player " .. param .. " not found.")
			return false
		end
	end

	local added, already = {}, {}

	for id, bless in pairs(Blessings.All) do
		if target:hasBlessing(id) then
			already[#already + 1] = bless.name
		else
			target:addBlessing(id, 1)
			added[#added + 1] = bless.name
		end
	end

	local logMessage
	if #added == 0 then
		logMessage = target:getName() .. " already has all blessings."
	else
		logMessage = "You blessed " .. target:getName() .. " with " .. table.concat(added, ", ") .. "."
		if #already > 0 then
			logMessage = logMessage .. " Already had: " .. table.concat(already, ", ") .. "."
		end
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, logMessage)

	if target ~= player and #added > 0 then
		target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by " .. player:getName() .. " with " .. table.concat(added, ", ") .. ".")
	end

	return false
end

blessTalkAction:separator(" ")
blessTalkAction:groupType("god")
blessTalkAction:register()
