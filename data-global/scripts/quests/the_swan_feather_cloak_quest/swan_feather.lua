local config = {
	rewardId = 26181,
	rewardCount = 5,
}

local swanfeather = Action()

function swanfeather.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getFreeCapacity() < ItemType(config.rewardId):getWeight() * config.rewardCount then
		player:sendCancelMessage("You don't have enough capacity.")
		return false
	end

	local storage = 8042025
	local cooldownTime = 3600
	local timeNow = os.time()
	local cooldownExpires = player:getStorageValue(storage)

	if cooldownExpires ~= -1 and timeNow < cooldownExpires then
		local timeLeft = cooldownExpires - timeNow
		local minutes = math.floor(timeLeft / 60)
		local seconds = timeLeft % 60
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You must wait %d minutes and %d seconds before plucking another feather.", minutes, seconds))
		return false
	end

	player:addItem(config.rewardId, config.rewardCount)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You pluck %d swan feathers.", config.rewardCount))
	player:setStorageValue(storage, timeNow + cooldownTime)
	toPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

swanfeather:id(25445)
swanfeather:register()
