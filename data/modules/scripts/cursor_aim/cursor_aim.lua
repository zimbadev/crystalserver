-- TEMP diagnostic: dump the C2S 0xF3 (243) payload to discover its format.
-- 0xF3 is a Cipsoft custom the server normally ignores (case 0xF3: break).
-- Suspected to carry the crosshair/cursor tile position. This module reads the
-- bytes (which the dispatcher would otherwise discard) and logs them as hex.
function onRecvbyte(player, msg, byte)
	if byte ~= 0xF3 then
		return
	end

	local remaining = msg:getLength() - (msg:getBufferPosition() - 7)
	local parts = {}
	local n = math.min(remaining, 24)
	for i = 1, n do
		parts[#parts + 1] = string.format("%02X", msg:getByte())
	end
	logger.info("[F3-DUMP] remaining={} bytes={}", remaining, table.concat(parts, " "))
end
