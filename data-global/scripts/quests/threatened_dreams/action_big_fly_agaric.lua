local action = Action()
local grumpyStoneStorage = 2033032
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(grumpyStoneStorage) == 2 then
		player:addItem(24946, 1)
		player:say("You discovered the fourth map part between the big fly agaric's gills.", TALKTYPE_MONSTER_SAY)
		player:setStorageValue(grumpyStoneStorage, 3)
		return true
	end
	return false
end

action:id(25385)
action:register()
