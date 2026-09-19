local talk = TalkAction("!fps")

function talk.onSay(player, words, param)
	local keyValue = "talkaction-fps"
	local exhaustionTime = player:kv():get(keyValue) or 0
	local currentTime = os.time()
	local cooldown = 60 * 30

	-- Check if the player is still in cooldown period
	if currentTime < exhaustionTime then
		player:sendCancelMessage(string.format("You are currently exhausted. Please wait %s before using this command again.", Game.getTimeInWords(exhaustionTime - currentTime)))
		return true
	end

	-- Get player's name and position
	local playerName = player:getName()
	local playerPosition = player:getPosition()
	logger.debug("Player {} is disconnecting at position: {}, Y: {}, Z: {}", playerName, playerPosition.x, playerPosition.y, playerPosition.z)

	-- Disconnect the player
	player:dropConnection()
	player:kv():set(keyValue, currentTime + cooldown)
	return true
end

talk:setDescription("Disconnects the player to refresh the connection and potentially improve FPS. Usage: !fps")
talk:groupType("normal")
talk:register()
