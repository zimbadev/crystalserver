-- Discovery System debug tool (the system itself runs automatically - see discovery_system.lua).
-- Usage:
--   /disco                    -> resend DiscoveryData (refresh the Cyclopedia Map tab)
--   /disco status             -> summary per main area + subareas in progress
--   /disco where              -> your position + which subarea footprint matches
--   /disco done [subId]       -> restore/mark subarea(s) complete
--   /disco reset              -> wipe your discovery progress
--   /disco tp                 -> teleport to Thais City (pilot subarea)
--   /disco poi                -> reveal your current rolled viewpoints in the server log
--   /disco donate <areaId> <gold> -> donate to a MAIN area (goal = boost scheduled)
--   /disco donations          -> pools + boost states (scheduled / active until)
--   /disco ss                 -> simulate the server-save boundary (activate/expire boosts)

local talkaction = TalkAction("/disco")

function talkaction.onSay(player, words, param)
	local arg = (param or ""):trim():lower()

	if arg == "reset" then
		DiscoverySystem.reset(player)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] discovery progress wiped.")
		return true
	end

	-- restore: /disco done            -> mark ALL registered subareas complete
	--          /disco done 28         -> mark subarea 28 complete
	if arg == "done" or arg:match("^done ") then
		local subId = tonumber(arg:match("done%s+(%d+)"))
		local n = DiscoverySystem.markComplete(player, subId)
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[disco] marked %d subarea(s) complete + rewards applied.", n))
		return true
	end

	if arg == "tp" then
		player:teleportTo(Position(32369, 32214, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] teleported to Thais City.")
		return true
	end

	if arg == "where" then
		local pos = player:getPosition()
		local subId, def = DiscoverySystem.findSubarea(pos)
		local match = def and string.format("%s (%d)%s", def.name, subId, def.approx and " [approx box]" or "") or "none"
		local line = string.format("pos (%d, %d, %d) -> subarea: %s", pos.x, pos.y, pos.z, match)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] " .. line)
		logger.info("[disco] {} where: {}", player:getName(), line)
		return true
	end

	if arg == "status" then
		for _, line in ipairs(DiscoverySystem.status(player)) do
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] " .. line)
		end
		return true
	end

	if arg:match("^donate ") then
		local areaId, amount = arg:match("donate%s+(%d+)%s+(%d+)")
		if not areaId then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] usage: /disco donate <mainAreaId> <gold>")
			return true
		end
		local ok, err = DiscoverySystem.donate(player, tonumber(areaId), tonumber(amount))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ok and "[disco] donation registered." or ("[disco] " .. err))
		return true
	end

	if arg == "donations" then
		for _, line in ipairs(DiscoverySystem.donationStatus()) do
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] " .. line)
		end
		return true
	end

	if arg == "resetdonations" then
		DiscoverySystem.resetDonations()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] all donation pools and boosts reset to zero.")
		return true
	end

	-- simulate the server-save boundary (activates scheduled boosts, expires old ones)
	if arg == "ss" then
		local n = DiscoverySystem.onServerSave()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[disco] server-save boundary simulated, %d boost(s) activated.", n))
		return true
	end

	if arg == "poi" then
		if DiscoverySystem.dumpPois(player) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] active viewpoints dumped to the server log.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] no active discovery session.")
		end
		return true
	end

	DiscoverySystem.sendDiscoveryData(player)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[disco] DiscoveryData sent. Open Cyclopedia -> Map tab.")
	return true
end

talkaction:separator(" ")
talkaction:groupType("god")
talkaction:register()
