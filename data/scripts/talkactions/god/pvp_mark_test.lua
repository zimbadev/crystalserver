-- PvP-box protocol RE helper (opcode 0x93 CreatureMark, client 15.25).
-- /pvpmark <markType>[,<weaponType>]
--   weaponType omitted / 255 -> legacy border mark [0x93][id][0x01][markType] (markType = color byte)
--   weaponType set           -> new-style mark    [0x93][id][markType][weaponType]
-- Sent about your current target (or yourself if no target). Watch which value renders the
-- yellow / orange / brown PvP situation box, then wire it into the real PvP-situation code.
local pvpMark = TalkAction("/pvpmark")

function pvpMark.onSay(player, words, param)
	if param == "" then
		player:sendCancelMessage("Usage: /pvpmark <markType>[,<weaponType>] — e.g. /pvpmark 2 or /pvpmark 1,3")
		return true
	end

	local split = param:split(",")
	local markType = tonumber(split[1])
	local weaponType = tonumber(split[2]) or 255
	if not markType then
		player:sendCancelMessage("markType must be a number (0-255).")
		return true
	end

	local target = player:getTarget() or player
	player:sendCreatureSquare(target, markType, weaponType)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[pvpmark] target=%s markType=%d weaponType=%d (%s)", target:getName(), markType, weaponType, weaponType == 255 and "legacy border" or "new-style mark"))
	return true
end

pvpMark:separator(" ")
pvpMark:groupType("god")
pvpMark:register()
