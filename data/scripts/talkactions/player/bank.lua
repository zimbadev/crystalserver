local config = {
	enabled = true,
}

if not config.enabled then
	return
end

local balance = TalkAction("!balance")

function balance.onSay(player, words, param)
	player:sendTextMessage(MESSAGE_LOOK, "Your current bank balance is " .. FormatNumber(Bank.balance(player)) .. ".")
	return true
end

balance:separator(" ")
balance:groupType("normal")
balance:register()

local deposit = TalkAction("!deposit")

function deposit.onSay(player, words, param)
	local amount
	if param == "all" then
		amount = player:getMoney()
	else
		amount = tonumber(param)
		if not amount or amount <= 0 and isValidMoney(amount) then
			player:sendCancelMessage("Invalid amount.")
			return true
		end
	end

	if not Bank.deposit(player, amount) then
		player:sendCancelMessage("You don't have enough money.")
		return true
	end

	player:sendTextMessage(MESSAGE_LOOK, "You have deposited " .. FormatNumber(amount) .. " gold coins.")
	return true
end

deposit:separator(" ")
deposit:groupType("normal")
deposit:register()

local withdraw = TalkAction("!withdraw")

function withdraw.onSay(player, words, param)
	local amount = tonumber(param)

	if not amount or amount <= 0 and isValidMoney(amount) then
		player:sendCancelMessage("Invalid amount.")
		return true
	end

	local totalValue = amount
	local crystalCoins = math.floor(totalValue / 10000)
	totalValue = totalValue % 10000
	local platinumCoins = math.floor(totalValue / 100)
	totalValue = totalValue % 100
	local goldCoins = totalValue

	local crystalPiles = math.floor((crystalCoins + 99) / 100)
	local platinumPiles = math.floor((platinumCoins + 99) / 100)
	local goldPiles = math.floor((goldCoins + 99) / 100)
	local totalPiles = crystalPiles + platinumPiles + goldPiles

	local moneyWeight = getMoneyWeight(amount)
	if player:getFreeCapacity() < moneyWeight then
		player:sendCancelMessage("You don't have enough capacity to carry this amount of gold.")
		return true
	end

	if player:getFreeBackpackSlots() < totalPiles then
		player:sendCancelMessage("You don't have enough room in your backpack to carry all these coins.")
		return true
	end

	if not Bank.withdraw(player, amount) then
		player:sendCancelMessage("You don't have enough money.")
		return true
	end

	player:sendTextMessage(MESSAGE_LOOK, "You have withdrawn " .. FormatNumber(amount) .. " gold coins.")
	return true
end

withdraw:separator(" ")
withdraw:groupType("normal")
withdraw:register()

local transfer = TalkAction("!transfer")

function transfer.onSay(player, words, param)
	local split = param:split(",")
	local amount = tonumber(split[2])
	if not amount or amount <= 0 and isValidMoney(amount) then
		player:sendCancelMessage("Invalid amount.")
		return true
	end

	local name = split[1]
	if not name then
		player:sendCancelMessage("Invalid name.")
		return true
	end
	name = name:trim()
	local normalizedName = Game.getNormalizedPlayerName(name)
	if not normalizedName then
		player:sendCancelMessage("A player with name " .. name .. " does not exist.")
		return true
	end
	name = normalizedName

	if not player:transferMoneyTo(name, amount) then
		player:sendCancelMessage("You don't have enough money.")
		return true
	end

	player:sendTextMessage(MESSAGE_LOOK, "You have transferred " .. FormatNumber(amount) .. " gold coins to " .. name .. ".")
	return true
end

transfer:separator(" ")
transfer:groupType("normal")
transfer:register()
