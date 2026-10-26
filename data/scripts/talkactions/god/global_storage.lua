local talkaction = TalkAction("/globalstorage")
function talkaction.onSay(player, words, param)
	local usage = "Usage: /globalstorage <storage key>,<optional value>"
	if not param or param == "" then
		player:sendCancelMessage(usage)
		return false
	end
	local split = param:split(",")
	if #split < 1 then
		player:sendCancelMessage(usage)
		return false
	end
	local storageKey = tonumber((string.trimSpace(split[1])))
	local storageValue = split[2] and tonumber((string.trimSpace(split[2])))
	if not storageKey then
		player:sendCancelMessage("Invalid storage key. It must be a number.")
		return true
	end
	if not storageValue then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Global Storage - " .. storageKey .. "] = " .. Game.getStorageValue(storageKey))
	else
		Game.setStorageValue(storageKey, storageValue)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Global Storage - " .. storageKey .. "] set to " .. storageValue)
	end
	return true
end
talkaction:separator(" ")
talkaction:groupType("god")
talkaction:register()
