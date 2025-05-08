local reward = {
	[58001] = 43862,
}
local woodenmouthpiece = Action()
function woodenmouthpiece.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(58001) ~= 1 then
		player:addItem(reward[item.uid], 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a wooden mouthpiece.")
		player:setStorageValue(58001, 1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end
for uniqueId, _ in pairs(reward) do
	woodenmouthpiece:uid(uniqueId)
end
woodenmouthpiece:register()

local conchShell = Action()
function conchShell.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(58002) ~= 1 then
		item:transform(43811)
		player:addItem(43861, 1)
		player:setStorageValue(58002, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a conch shell.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The blue seashell is empty.")
	end
	return true
end
conchShell:id(43810)
conchShell:register()

local mergeConchHorn = Action()
function mergeConchHorn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 43862 and target.itemid == 43861 then
		item:remove(1)
		target:remove(1)
		player:addItem(43863, 1)
		player:say("You have merged the conch shell and the wooden mouthpiece and created a conch shell horn.", TALKTYPE_MONSTER_SAY)
	else
		player:sendCancelMessage("You need to use the wooden mouthpiece on the conch shell.")
	end
	return true
end

mergeConchHorn:id(43862)
mergeConchHorn:register()
