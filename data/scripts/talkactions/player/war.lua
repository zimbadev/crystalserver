local talkaction = TalkAction("!war")

local function updateWarEmblems(guildId, enemyId)
	local guild = Guild(guildId)
	local enemyGuild = Guild(enemyId)
	if not guild or not enemyGuild then
		return
	end
	local gMembers = guild:getMembersOnline()
	local eMembers = enemyGuild:getMembersOnline()
	-- cross-guild updates (enemy vs enemy)
	for _, gp in ipairs(gMembers) do
		for _, ep in ipairs(eMembers) do
			gp:sendCreatureEmblem(ep)
			ep:sendCreatureEmblem(gp)
		end
	end

	-- same-guild updates (ally state inside each guild)
	for i = 1, #gMembers do
		for j = 1, #gMembers do
			local a = gMembers[i]
			local b = gMembers[j]
			if a ~= b then
				a:sendCreatureEmblem(b)
				b:sendCreatureEmblem(a)
			end
		end
	end
	for i = 1, #eMembers do
		for j = 1, #eMembers do
			local a = eMembers[i]
			local b = eMembers[j]
			if a ~= b then
				a:sendCreatureEmblem(b)
				b:sendCreatureEmblem(a)
			end
		end
	end
end

function talkaction.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.war") or 0

	if lastWarCommandTime > os.time() then
		local remainingCooldown = lastWarCommandTime - os.time()
		player:sendTextMessage(MESSAGE_FAILURE, "Can only be executed once every " .. cooldown .. " seconds. Remaining cooldown: " .. remainingCooldown)
		return true
	end

	player:kv():set("talkaction.war", os.time() + cooldown)

	-- Validate guild membership and leadership
	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You need to be in a guild in order to execute this command.")
		return true
	end

	local guildId = guild:getId() -- Ensure we use the guild ID instead of the object
	if player:getGuildLevel() < GUILDLEVEL_LEADER then
		player:sendCancelMessage("You cannot execute this command.")
		return true
	end

	-- Parse parameters manually to handle guild names with spaces
	local command, enemyName, kills = param:match("^(%w+),%s*([^,]+),?%s*(%d*),?%s*(%d*)$")
	if not command or not enemyName then
		player:sendChannelMessage("", "Warmode commands:", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		player:sendChannelMessage("", "!war invite, guildname, frags: Invite guild to start a war. Frags are optional; default values = 100 frags.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		player:sendChannelMessage("", "!war accept, guildname: Accept the invitation to start a war.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		player:sendChannelMessage("", "!war reject, guildname: Reject the invitation to start a war.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		player:sendChannelMessage("", "!war end, guildname: Ends the war if time is over. Aggressor can end the war before this time.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		return true
	end

	-- Validate enemy guild
	local enemy = getGuildId(enemyName)
	if not enemy then
		player:sendChannelMessage("", 'Guild "' .. enemyName .. '" does not exist.', TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		return true
	end

	if enemy == guildId then
		player:sendChannelMessage("", "You cannot perform war actions on your own guild.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		return true
	end

	local enemyGuildName = ""
	local tmp = db.storeQuery("SELECT `name` FROM `guilds` WHERE `id` = " .. enemy)
	if tmp then
		enemyGuildName = Result.getDataString(tmp, "name")
		Result.free(tmp)
	end

	-- Handle war actions
	if isInArray({ "accept", "reject", "cancel" }, command) then
		handlePendingWar(player, guildId, enemy, enemyGuildName, command)
		-- reload wars to reflect DB changes before pushing emblems
		for _, p in ipairs(Guild(guildId):getMembersOnline()) do
			p:reloadGuildWarList()
		end
		for _, p in ipairs(Guild(enemy):getMembersOnline()) do
			p:reloadGuildWarList()
		end
		updateWarEmblems(guildId, enemy)
		return true
	elseif command == "invite" then
		handleWarInvite(player, guildId, enemy, enemyGuildName, kills)
		return true
	elseif isInArray({ "end", "finish" }, command) then
		handleWarEnd(player, guildId, enemy, enemyGuildName, command)
		for _, p in ipairs(Guild(guildId):getMembersOnline()) do
			p:reloadGuildWarList()
		end
		for _, p in ipairs(Guild(enemy):getMembersOnline()) do
			p:reloadGuildWarList()
		end
		updateWarEmblems(guildId, enemy)
		return true
	end

	return true
end

function handlePendingWar(player, guildId, enemy, enemyName, command)
	local query = "`guild1` = " .. enemy .. " AND `guild2` = " .. guildId
	if command == "cancel" then
		query = "`guild1` = " .. guildId .. " AND `guild2` = " .. enemy
	end

	local tmp = db.storeQuery("SELECT `id`, `started`, `ended` FROM `guild_wars` WHERE " .. query .. " AND `status` = 0")
	if not tmp then
		player:sendChannelMessage("", "Currently there's no pending invitation for a war with " .. enemyName .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		return true
	end

	local updateQuery = "UPDATE `guild_wars` SET "
	local msg = "accepted " .. enemyName .. " invitation to war."
	if command == "reject" then
		updateQuery = updateQuery .. "`ended` = " .. os.time() .. ", `status` = 2"
		msg = "rejected " .. enemyName .. " invitation to war."
	elseif command == "cancel" then
		updateQuery = updateQuery .. "`ended` = " .. os.time() .. ", `status` = 3"
		msg = "canceled invitation to a war with " .. enemyName .. "."
	else -- accept
		updateQuery = updateQuery .. "`started` = " .. os.time() .. ", `ended` = " .. ((Result.getDataInt(tmp, "ended")) + (os.time() - (Result.getDataInt(tmp, "started")))) .. ", `status` = 1"
	end

	updateQuery = updateQuery .. " WHERE `id` = " .. Result.getDataInt(tmp, "id")
	Result.free(tmp)
	db.query(updateQuery)
	broadcastMessage(getPlayerGuildName(player) .. " has " .. msg, MESSAGE_ADMINISTRATOR)
end

function handleWarInvite(player, guildId, enemy, enemyName, kills)
	local str = ""
	local tmp = db.storeQuery("SELECT `guild1`, `status` FROM `guild_wars` WHERE `guild1` IN (" .. guildId .. "," .. enemy .. ") AND `guild2` IN (" .. enemy .. "," .. guildId .. ") AND `status` IN (0, 1)")
	if tmp then
		if Result.getDataInt(tmp, "status") == 0 then
			if Result.getDataInt(tmp, "guild1") == guildId then
				str = "You have already invited " .. enemyName .. " to war."
			else
				str = enemyName .. " have already invited you to war."
			end
		else
			str = "You are already on a war with " .. enemyName .. "."
		end
		Result.free(tmp)
	end

	if str ~= "" then
		player:sendChannelMessage("", str, TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		return true
	end

	local defaultFrags = configManager.getNumber(configKeys.GUILD_WARS_DEFAULT_FRAGS)
	local minimumFrags = configManager.getNumber(configKeys.GUILD_WARS_MINIMUM_FRAGS)

	local frags = tonumber(kills)
	if frags ~= nil then
		frags = math.max(minimumFrags, math.min(1000, frags))
	else
		frags = defaultFrags
	end

	local warHours = 24
	local beginning, ending = os.time(), warHours
	ending = ending ~= 0 and (beginning + (ending * 3600)) or 0

	db.query("INSERT INTO `guild_wars` (`guild1`, `guild2`, `name1`, `name2`, `started`, `ended`, `frags_limit`) VALUES (" .. guildId .. ", " .. enemy .. ", " .. db.escapeString(getPlayerGuildName(player)) .. ", " .. db.escapeString(enemyName) .. ", " .. beginning .. ", " .. ending .. ", " .. frags .. ")")
	broadcastMessage(getPlayerGuildName(player) .. " has invited " .. enemyName .. " for war with a frags limit of " .. frags .. ".", MESSAGE_ADMINISTRATOR)
end

function handleWarEnd(player, guildId, enemy, enemyName, command)
	local status = (command == "end" and 1 or 4)
	local tmp = db.storeQuery("SELECT `id` FROM `guild_wars` WHERE `guild1` = " .. guildId .. " AND `guild2` = " .. enemy .. " AND `status` = " .. status)
	if tmp then
		local updateQuery = "UPDATE `guild_wars` SET `ended` = " .. os.time() .. ", `status` = 4 WHERE `id` = " .. Result.getDataInt(tmp, "id")
		Result.free(tmp)
		db.query(updateQuery)
		broadcastMessage(getPlayerGuildName(player) .. " has " .. (status == 4 and "mend fences" or "ended up a war") .. " with " .. enemyName .. ".", MESSAGE_ADMINISTRATOR)
		return true
	end

	if status == 4 then
		player:sendChannelMessage("", "Currently there's no pending war truce from " .. enemyName .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		return true
	end

	tmp = db.storeQuery("SELECT `id`, `ended` FROM `guild_wars` WHERE `guild1` = " .. enemy .. " AND `guild2` = " .. guildId .. " AND `status` = 1")
	if tmp then
		if Result.getDataInt(tmp, "ended") > os.time() then
			Result.free(tmp)
			player:sendChannelMessage("", "You cannot request ending for war with " .. enemyName .. " yet.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
			return true
		end

		local updateQuery = "UPDATE `guild_wars` SET `status` = 4, `ended` = " .. os.time() .. " WHERE `id` = " .. Result.getDataInt(tmp, "id")
		Result.free(tmp)
		db.query(updateQuery)
		broadcastMessage(getPlayerGuildName(player) .. " has signed an armstice declaration on a war with " .. enemyName .. ".", MESSAGE_ADMINISTRATOR)
		return true
	end

	player:sendChannelMessage("", "Currently there's no active war with " .. enemyName .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
end

if configManager.getBoolean(configKeys.TOGGLE_GUILD_WARS) then
	talkaction:separator(" ")
	talkaction:groupType("normal")
	talkaction:register()
end
