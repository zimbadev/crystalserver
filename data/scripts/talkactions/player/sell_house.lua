local sellHouse = TalkAction("!sellhouse")

function sellHouse.onSay(player, words, param)
	if configManager.getBoolean(configKeys.CYCLOPEDIA_HOUSE_AUCTION) then
		player:sendTextMessage(MESSAGE_FAILURE, "Command have been disabled by the administrator.")
		return true
	end

	local tradePartner = Player(param)
	if not tradePartner or tradePartner == player then
		player:sendCancelMessage("Trade player not found.")
		return true
	end

	local house = player:getTile():getHouse()
	if not house then
		player:sendCancelMessage("You must stand in your house to initiate the trade.")
		return true
	end

	if not tradePartner:isPremium() then
		player:sendCancelMessage("The new owner need a premium account.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local toggleGuildhall = configManager.getBoolean(configKeys.TOGGLE_GUILDHALL_NEED_GUILD)
	if toggleGuildhall then
		if house:isGuildhall() then
			if tradePartner:getGuildLevel() ~= GUILDLEVEL_LEADER then
				player:sendCancelMessage("Only the leader of a guild can receive a guild hall.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		end
	end

	local maxHousesLimit = configManager.getNumber(configKeys.MAX_HOUSES_LIMIT)
	local playerHouses = Game:getHouseCountByAccount(tradePartner:getAccountId())
	if playerHouses >= maxHousesLimit then
		player:sendCancelMessage("The new owner has reached house limit: " .. maxHousesLimit .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local returnValue = house:startTrade(player, tradePartner)
	if returnValue ~= RETURNVALUE_NOERROR then
		player:sendCancelMessage(returnValue)
	end
	return true
end

sellHouse:separator(" ")
sellHouse:groupType("normal")
sellHouse:register()
