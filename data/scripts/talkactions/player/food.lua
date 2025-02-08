local food = TalkAction("!food")

local config = {
	price = 1000,
	itemId = 3731,
	quantity = 100,
}

function food.onSay(player, words, param)
	if player:removeMoneyBank(config.price) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:addItem(config.itemId, config.quantity)
		player:sendTextMessage(MESSAGE_LOOK, string.format("You bought %d food for %d gold!", config.quantity, config.price))
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage(string.format("You need at least %d gold coins.", config.price))
	end
end

food:groupType("normal")
food:register()
