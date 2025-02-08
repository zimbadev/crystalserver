local backpack = TalkAction("!bp")

local itemConfig = {
	price = 20,
	itemId = 2854,
}

function backpack.onSay(player, words, param)
	local exhaustGroup = "talkactions"
	local exhaustTime = 2

	if player:getExhaustion(exhaustGroup) > 0 then
		player:sendCancelMessage("You are exhausted. Please wait before using this command again.")
		return true
	end

	if player:removeMoneyBank(itemConfig.price) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:addItem(itemConfig.itemId, 1)
		player:sendTextMessage(MESSAGE_LOOK, "You have bought a backpack!")
		player:setExhaustion(exhaustGroup, exhaustTime)
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You do not have enough money.")
	end

	return true
end

backpack:groupType("normal")
backpack:register()
