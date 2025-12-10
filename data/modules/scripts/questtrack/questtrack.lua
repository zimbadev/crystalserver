function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		local quests = {}
		local missions = msg:getByte()
		for i = 1, missions do
			quests[#quests + 1] = msg:getU16()
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

		player:resetTrackedMissions(quests)
	end
end
