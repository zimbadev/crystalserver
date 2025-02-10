local frags = TalkAction("!frags")

function frags.onSay(player, words, param)
	local fragTime = configManager.getNumber(configKeys.FRAG_TIME)
	local skullTime = player:getSkullTime()
	local fragsList = player:getKills()
	local totalFrags = 0

	for fragIndex, fragTable in pairs(fragsList) do
		for subKey, subValue in pairs(fragTable) do
			if subKey == 1 then
				local resultName = db.storeQuery("SELECT `name` FROM `players` WHERE `id` = " .. db.escapeString(subValue))
				local name = Result.getString(resultName, "name")
				totalFrags = totalFrags + 1
			elseif subKey == 2 then
				local formattedDate = os.date("%d %b %Y, %H:%M:%S", subValue)
			elseif subKey == 3 then
			else
			end
		end
	end

	player:sendTextMessage(MESSAGE_LOOK, "You have " .. totalFrags .. " unjustified kills.")
	return true
end

frags:separator(" ")
frags:groupType("normal")
frags:register()
