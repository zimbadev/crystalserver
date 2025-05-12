local buyHouse = TalkAction("!buyhouse")

function buyHouse.onSay(player, words, param)
	if configManager.getBoolean(configKeys.CYCLOPEDIA_HOUSE_AUCTION) then
		player:sendTextMessage(MESSAGE_FAILURE, "Command have been disabled by the administrator.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local housePrice = configManager.getNumber(configKeys.HOUSE_PRICE_PER_SQM)
	if housePrice == -1 then
		return true
	end

	if not player:isPremium() then
		player:sendCancelMessage("You need a premium account.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local houseBuyLevel = configManager.getNumber(configKeys.HOUSE_BUY_LEVEL)
	if player:getLevel() < houseBuyLevel then
		player:sendCancelMessage("You need to be level " .. houseBuyLevel .. " to buy a house.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local position = player:getPosition()
	position:getNextPosition(player:getDirection())

	local tile = Tile(position)
	local house = tile and tile:getHouse()
	local playerPos = player:getPosition()
	local houseEntry = house and house:getExitPosition()

	if not house or playerPos ~= houseEntry then
		player:sendCancelMessage("You have to be looking at the door of the house you would like to buy.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if house:getOwnerGuid() > 0 then
		player:sendCancelMessage("This house already has an owner.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local maxHousesLimit = configManager.getNumber(configKeys.MAX_HOUSES_LIMIT)
	local playerHouses = player:getAllHouses()
	if #playerHouses > maxHousesLimit then
		player:sendCancelMessage("You cannot buy more houses. The maximum number of houses you can own is " .. maxHousesLimit .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if house:hasItemOnTile() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot buy this house, as there are items inside it. Please, contact an administrator.")
		return true
	end

	local price = house:getPrice()
	if not player:removeMoneyBank(price) then
		player:sendCancelMessage("You do not have enough money.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	metrics.addCounter("balance_decrease", remainsPrice, {
		player = player:getName(),
		context = "house_purchase",
	})

	house:setHouseOwner(player:getGuid())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have successfully bought this house, be sure to have the money for the rent in the bank.")
	return true
end

buyHouse:separator(" ")
buyHouse:groupType("normal")
buyHouse:register()
