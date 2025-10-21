-- Guild Management TalkActions
-- Commands: !setmotd, !disband, !invite, !leave, !kick, !promote, !demote, !passleader, !nick, !setrankname, !createguild, !joinguild

-- !setmotd command
local setMotd = TalkAction("!setmotd")

function setMotd.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() ~= GUILDLEVEL_LEADER then
		player:sendCancelMessage("Only the guild leader can change the MOTD.")
		return true
	end

	local guildId = guild:getId()
	local newMotd = param ~= "" and param or ""
	if #newMotd > 255 then
		player:sendCancelMessage("The MOTD cannot exceed 255 characters.")
		return true
	end

	Game.setGuildMotd(guildId, newMotd)
	player:closeChannel(0x00)
	player:openChannel(0x00)
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	setMotd:separator(" ")
	setMotd:channel(0)
	setMotd:groupType("normal")
	setMotd:register()
end

-- !disband command
local disband = TalkAction("!disband")

function disband.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() ~= GUILDLEVEL_LEADER then
		player:sendCancelMessage("Only the guild leader can disband the guild.")
		return true
	end

	local players = Game.getPlayers()
	for _, onlinePlayer in pairs(players) do
		if onlinePlayer:getId() ~= player:getId() and isInWar(player:getId(), onlinePlayer:getId()) then
			player:sendCancelMessage("You cannot disband the guild while in war.")
			return true
		end
	end

	local guildId = guild:getId()
	Game.disbandGuild(guildId)
	player:sendTextMessage(MESSAGE_STATUS, "Guild has been disbanded.")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	disband:channel(0)
	disband:groupType("normal")
	disband:register()
end

-- !invite command
local invite = TalkAction("!invite")

function invite.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() < GUILDLEVEL_VICE then
		player:sendCancelMessage("You need to be at least Vice-Leader to invite players.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !invite playerName")
		return true
	end

	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Player is not online.")
		return true
	end

	if targetPlayer:getGuild() then
		player:sendCancelMessage("This player is already in a guild.")
		return true
	end

	local guildId = guild:getId()
	Game.invitePlayerToGuild(guildId, param)
	player:sendChannelMessage("", "Player " .. param .. " has been invited to the guild.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
	targetPlayer:sendTextMessage(MESSAGE_STATUS, "You have been invited to join " .. guild:getName() .. " guild.")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	invite:separator(" ")
	invite:channel(0)
	invite:groupType("normal")
	invite:register()
end

-- !leave command
local leave = TalkAction("!leave")

function leave.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() == GUILDLEVEL_LEADER then
		player:sendCancelMessage("The guild leader cannot leave the guild. Use !disband to disband the guild.")
		return true
	end

	local players = Game.getPlayers()
	for _, onlinePlayer in pairs(players) do
		if onlinePlayer:getId() ~= player:getId() and isInWar(player:getId(), onlinePlayer:getId()) then
			player:sendCancelMessage("You cannot leave the guild while in war.")
			return true
		end
	end

	local guildId = guild:getId()
	local playerName = player:getName()
	Game.removePlayerFromGuild(guildId, playerName)
	player:sendTextMessage(MESSAGE_STATUS, "You have left the guild.")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	leave:channel(0)
	leave:groupType("normal")
	leave:register()
end

-- !kick command
local kick = TalkAction("!kick")

function kick.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() < GUILDLEVEL_VICE then
		player:sendCancelMessage("You need to be at least Vice-Leader to kick players.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !kick playerName")
		return true
	end

	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Player is not online.")
		return true
	end

	if not targetPlayer:getGuild() or targetPlayer:getGuild():getId() ~= guild:getId() then
		player:sendCancelMessage("This player is not in your guild.")
		return true
	end

	if targetPlayer:getGuildLevel() >= player:getGuildLevel() then
		player:sendCancelMessage("You cannot kick a player with equal or higher rank.")
		return true
	end

	local guildId = guild:getId()
	Game.removePlayerFromGuild(guildId, param)
	player:sendChannelMessage("", "Player " .. param .. " has been removed from the guild.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
	targetPlayer:sendTextMessage(MESSAGE_STATUS, "You have been removed from the guild.")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	kick:separator(" ")
	kick:channel(0)
	kick:groupType("normal")
	kick:register()
end

-- !promote command
local promote = TalkAction("!promote")

function promote.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() < GUILDLEVEL_VICE then
		player:sendCancelMessage("You need to be at least Vice-Leader to promote players.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !promote playerName")
		return true
	end

	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Player is not online.")
		return true
	end

	if not targetPlayer:getGuild() or targetPlayer:getGuild():getId() ~= guild:getId() then
		player:sendCancelMessage("This player is not in your guild.")
		return true
	end

	if targetPlayer:getGuildLevel() >= player:getGuildLevel() then
		player:sendCancelMessage("You cannot promote a player with equal or higher rank.")
		return true
	end

	local guildId = guild:getId()
	Game.promotePlayer(guildId, param)
	player:sendChannelMessage("", "Player " .. param .. " has been promoted.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
	targetPlayer:sendTextMessage(MESSAGE_STATUS, "You have been promoted in the guild.")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	promote:separator(" ")
	promote:channel(0)
	promote:groupType("normal")
	promote:register()
end

-- !demote command
local demote = TalkAction("!demote")

function demote.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() < GUILDLEVEL_VICE then
		player:sendCancelMessage("You need to be at least Vice-Leader to demote players.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !demote playerName")
		return true
	end

	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Player is not online.")
		return true
	end

	if not targetPlayer:getGuild() or targetPlayer:getGuild():getId() ~= guild:getId() then
		player:sendCancelMessage("This player is not in your guild.")
		return true
	end

	if targetPlayer:getGuildLevel() >= player:getGuildLevel() then
		player:sendCancelMessage("You cannot demote a player with equal or higher rank.")
		return true
	end

	if targetPlayer:getGuildLevel() <= 1 then
		player:sendCancelMessage("Cannot demote a player below Member rank.")
		return true
	end

	local guildId = guild:getId()
	Game.demotePlayer(guildId, param)
	player:sendChannelMessage("", "Player " .. param .. " has been demoted.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
	targetPlayer:sendTextMessage(MESSAGE_STATUS, "You have been demoted in the guild.")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	demote:separator(" ")
	demote:channel(0)
	demote:groupType("normal")
	demote:register()
end

-- !passleader command
local passLeader = TalkAction("!passleader")

function passLeader.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() ~= GUILDLEVEL_LEADER then
		player:sendCancelMessage("Only the guild leader can pass leadership.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !passleader playerName")
		return true
	end

	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Player is not online.")
		return true
	end

	if not targetPlayer:getGuild() or targetPlayer:getGuild():getId() ~= guild:getId() then
		player:sendCancelMessage("This player is not in your guild.")
		return true
	end

	if targetPlayer:getId() == player:getId() then
		player:sendCancelMessage("You cannot pass leadership to yourself.")
		return true
	end

	local guildId = guild:getId()
	local success = Game.passLeadership(guildId, param)
	if success then
		player:sendChannelMessage("", "Leadership has been passed to " .. param .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		targetPlayer:sendTextMessage(MESSAGE_STATUS, "You are now the leader of the guild.")
		player:sendTextMessage(MESSAGE_STATUS, "You are now a Vice-Leader of the guild.")
	else
		player:sendCancelMessage("Failed to pass leadership. The player may not be eligible.")
	end
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	passLeader:separator(" ")
	passLeader:channel(0)
	passLeader:groupType("normal")
	passLeader:register()
end

-- !nick command
local nick = TalkAction("!nick")

function nick.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() ~= GUILDLEVEL_LEADER then
		player:sendCancelMessage("Only guild Leader can use this command.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !nick playerName, newNick (leave newNick empty to reset)")
		return true
	end

	local params = param:split(",")
	if #params < 1 then
		player:sendCancelMessage("Usage: !nick playerName, newNick (leave newNick empty to reset)")
		return true
	end

	local playerName = params[1]:trim()
	local newNick = ""
	if #params >= 2 then
		newNick = params[2]:trim()
	end

	local targetPlayer = Player(playerName)
	if not targetPlayer then
		player:sendCancelMessage("Player is not online.")
		return true
	end

	if not targetPlayer:getGuild() or targetPlayer:getGuild():getId() ~= guild:getId() then
		player:sendCancelMessage("This player is not in your guild.")
		return true
	end

	if #newNick > 15 then
		player:sendCancelMessage("Guild nick cannot exceed 15 characters.")
		return true
	end

	local guildId = guild:getId()
	Game.setPlayerGuildNick(guildId, playerName, newNick)

	if newNick == "" then
		player:sendChannelMessage("", "Guild nick for " .. playerName .. " has been reset.", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		targetPlayer:sendTextMessage(MESSAGE_STATUS, "Your guild nick has been reset.")
	else
		player:sendChannelMessage("", "Guild nick for " .. playerName .. " has been set to " .. newNick .. ".", TALKTYPE_CHANNEL_R1, CHANNEL_GUILD)
		targetPlayer:sendTextMessage(MESSAGE_STATUS, "Your guild nick has been changed to " .. newNick .. ".")
	end
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	nick:separator(" ")
	nick:channel(0)
	nick:groupType("normal")
	nick:register()
end

-- !setrankname command
local setRankName = TalkAction("!setrankname")

function setRankName.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage("You are not in a guild.")
		return true
	end

	if player:getGuildLevel() ~= GUILDLEVEL_LEADER then
		player:sendCancelMessage("Only the guild leader can change rank names.")
		return true
	end

	local params = param:split(",")
	if #params < 2 then
		player:sendCancelMessage("Usage: !setrankname rankLevel, newName")
		return true
	end

	local rankLevel = tonumber(params[1]:trim())
	local newName = params[2]

	if not rankLevel or rankLevel < 1 or rankLevel > 3 then
		player:sendCancelMessage("Rank level must be between 1 and 3.")
		return true
	end

	if #newName > 20 then
		player:sendCancelMessage("Rank name cannot exceed 20 characters.")
		return true
	end

	local guildId = guild:getId()
	Game.setRankName(guildId, rankLevel, newName)
	player:sendTextMessage(MESSAGE_STATUS, "Rank " .. rankLevel .. " name has been changed to " .. newName .. ".")
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	setRankName:separator(" ")
	setRankName:channel(0)
	setRankName:groupType("normal")
	setRankName:register()
end

-- !createguild command
local createGuild = TalkAction("!createguild")

function createGuild.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	if player:getGuild() then
		player:sendCancelMessage("You are already in a guild.")
		return true
	end

	local levelToFormGuild = configManager.getNumber(configKeys.LEVEL_TO_FORM_GUILD)
	if player:getLevel() < levelToFormGuild then
		player:sendCancelMessage("You need to be at least level " .. levelToFormGuild .. " to create a guild.")
		return true
	end

	local createGuildOnlyPremium = configManager.getBoolean(configKeys.CREATE_GUILD_ONLY_PREMIUM)
	if createGuildOnlyPremium and not player:isPremium() then
		player:sendCancelMessage("Only premium players can create guilds.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !createguild guild name")
		return true
	end

	local guildName = param:trim()
	if #guildName < 3 or #guildName > 20 then
		player:sendCancelMessage("Guild name must be between 3 and 20 characters.")
		return true
	end

	local guildId = Game.createGuild(guildName, player:getName())
	if guildId > 0 then
		player:sendTextMessage(MESSAGE_LOOK, "Guild '" .. guildName .. "' has been created successfully!")
	else
		player:sendCancelMessage("Failed to create guild. Guild name may already exist or you may already be in a guild.")
	end
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	createGuild:separator(" ")
	createGuild:groupType("normal")
	createGuild:register()
end

-- !joinguild command
local joinGuild = TalkAction("!joinguild")

function joinGuild.onSay(player, words, param)
	local cooldown = 2 -- seconds, prevent db overload
	local lastWarCommandTime = player:kv():get("talkaction.guild.commands") or 0

	if lastWarCommandTime > os.time() then
		player:sendCancelMessage("Can only be executed once every " .. cooldown .. " seconds")
		return true
	end

	player:kv():set("talkaction.guild.commands", os.time() + cooldown)

	if player:getGuild() then
		player:sendCancelMessage("You are already in a guild.")
		return true
	end

	if param == "" then
		player:sendCancelMessage("Usage: !joinguild guild name")
		return true
	end

	local guildName = param:trim()
	if #guildName < 3 or #guildName > 20 then
		player:sendCancelMessage("Guild name must be between 3 and 20 characters.")
		return true
	end

	local success = Game.joinGuild(guildName, player:getName())
	if success then
		player:sendTextMessage(MESSAGE_LOOK, "You have successfully joined the guild " .. guildName .. "!")
	else
		player:sendCancelMessage("Failed to join guild. You must have an invitation to join this guild.")
	end
	return true
end

local ingameGuildManagement = configManager.getBoolean(configKeys.INGAME_GUILD_MANAGEMENT)
if ingameGuildManagement then
	joinGuild:separator(" ")
	joinGuild:groupType("normal")
	joinGuild:register()
end
