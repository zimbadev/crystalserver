local randomOutfit = TalkAction("!randomoutfit")

local config = {
	changeInterval = 100,
	showEffect = false,
}

local validValues = {
	"on",
	"off",
}

local activePlayers = {}

local function generateRandomColors(outfit)
	outfit.lookHead = math.random(0, 132)
	outfit.lookBody = math.random(0, 132)
	outfit.lookLegs = math.random(0, 132)
	outfit.lookFeet = math.random(0, 132)
	return outfit
end

local function updateColors(playerId)
	local player = Player(playerId)
	if player and activePlayers[playerId] then
		local newOutfit = generateRandomColors(player:getOutfit())
		player:setOutfit(newOutfit)
		if config.showEffect then
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		end
		addEvent(updateColors, config.changeInterval, playerId)
	end
end

function randomOutfit.onSay(player, words, param)
	if not table.contains(validValues, param) then
		local validValuesStr = table.concat(validValues, "/")
		player:sendTextMessage(MESSAGE_FAILURE, "Invalid param specified. Usage: !randomoutfit [" .. validValuesStr .. "]")
		return true
	end

	local playerId = player:getId()

	if param == "on" then
		if activePlayers[playerId] then
			player:sendTextMessage(MESSAGE_FAILURE, "Random outfit is already active.")
			return true
		end

		activePlayers[playerId] = true
		updateColors(playerId)
		player:sendTextMessage(MESSAGE_LOOK, "Random outfit is now enabled.")
	else
		activePlayers[playerId] = nil
		player:sendTextMessage(MESSAGE_LOOK, "Random outfit is now disabled.")
	end

	return true
end

randomOutfit:separator(" ")
randomOutfit:groupType("normal")
randomOutfit:register()
