local addCoins = TalkAction("/addcoins")

function addCoins.onSay(player, words, param)
	-- Log the command usage
	logCommand(player, words, param)

	local usage = "/addcoins PLAYER NAME[,COIN TYPE],AMOUNT"
	if param == "" then
		player:sendCancelMessage("Parameters required. Usage: " .. usage)
		return true
	end

	local split = param:split(",")
	if not (split[1] and split[#split]) then
		player:sendCancelMessage("Insufficient parameters. Usage: " .. usage)
		return true
	end

	local targetName = string.trimSpace(split[1])
	local target = Player(targetName)
	if not target then
		player:sendCancelMessage("Player '" .. targetName .. "' is not online.")
		return true
	end

	local coinTypeValue, amount
	if #split == 2 then
		-- If only two parameters are provided, assume non-transferable coins (0)
		coinTypeValue = 0
		amount = tonumber(split[2])
	elseif #split == 3 then
		-- If three parameters are provided, use the specified coin type
		coinTypeValue = tonumber(split[2])
		amount = tonumber(split[3])
		if coinTypeValue ~= 0 and coinTypeValue ~= 1 then
			player:sendCancelMessage("Invalid coin type. Use '0' for non-transferable coins or '1' for transferable coins.")
			return true
		end
	else
		player:sendCancelMessage("Invalid number of parameters. Usage: " .. usage)
		return true
	end

	local coinType = (coinTypeValue == 1) and "coins_transferable" or "coins"
	if not amount or amount <= 0 then
		player:sendCancelMessage("Invalid amount. The amount must be a positive number.")
		return true
	end

	local accountId = target:getAccountId()
	local query = string.format("UPDATE `accounts` SET `%s` = `%s` + %d WHERE `id` = %d", coinType, coinType, amount, accountId)
	db.query(query)

	player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Added " .. amount .. " " .. coinType .. " to player '" .. targetName .. "'.")
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. amount .. " " .. ((coinTypeValue == 1) and "transferable coins" or "non-transferable coins") .. "!")
	target:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
end

addCoins:separator(" ")
addCoins:groupType("god")
addCoins:register()
