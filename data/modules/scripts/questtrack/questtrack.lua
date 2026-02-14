function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		local function getRemainingBytes()
			return msg:getLength() - (msg:getBufferPosition() - 7)
		end

		if getRemainingBytes() < 3 then
			return
		end

		local receivedMissionsFromClient = {}
		local missions = msg:getByte()

		local requiredBytes = (missions * 2) + 2
		if getRemainingBytes() < requiredBytes then
			return
		end

		for i = 1, missions do
			table.insert(receivedMissionsFromClient, msg:getU16())
		end

		local automaticallyTrackNewQuests = msg:getByte()
		local automaticallyUntrackCompletedQuests = msg:getByte()

		if automaticallyTrackNewQuests == 1 then
			player:kv():set("tracker-new-quest", automaticallyTrackNewQuests)
		else
			player:kv():remove("tracker-new-quest")
		end

		if automaticallyUntrackCompletedQuests == 1 then
			player:kv():set("untracker-quest", automaticallyUntrackCompletedQuests)
		else
			player:kv():remove("untracker-quest")
		end

		player:resetTrackedMissions(receivedMissionsFromClient)
	end
end
