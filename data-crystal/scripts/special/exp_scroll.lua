local expScroll = Action()

function expScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local minExp = 1000
	local maxExp = 500000
	local randomExp = math.random(minExp, maxExp)
	player:addExperience(randomExp)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. randomExp .. " EXP points!")
	item:remove(1)
	return true
end

expScroll:id(23682)
expScroll:register()
