local reward = {
	[58103] = 35562,
}
local quiver = Action()
function quiver.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(58103) ~= 1 then
		player:addItem(reward[item.uid], 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a quiver.")
		player:setStorageValue(58103, 1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end
for uniqueId, _ in pairs(reward) do
	quiver:uid(uniqueId)
end
quiver:register()
