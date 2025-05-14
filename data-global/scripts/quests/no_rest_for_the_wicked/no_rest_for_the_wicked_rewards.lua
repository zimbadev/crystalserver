local rewards = {
	[57237] = 49520,
	[57238] = 49522,
	[57239] = 49523,
	[57240] = 49524,
	[57241] = 49525,
	[57242] = 49526,
	[57243] = 49527,
	[57244] = 49530,
	[57245] = 49528,
	[57246] = 49529,
}

local theForgeRewards = Action()
function theForgeRewards.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Reward) < 1 then
		player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Reward, 1)
		player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline, 3)
		player:addItem(rewards[item.uid], 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. ItemType(rewards[item.uid]):getName() .. ".")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end

for uniqueId, info in pairs(rewards) do
	theForgeRewards:uid(uniqueId)
end

theForgeRewards:register()
