local luckycharm = Action()

function luckycharm.onUse(player, item, fromPosition, itemEx, toPosition)
	if item.itemid ~= 12171 or itemEx.itemid ~= 12172 then
		return false
	end

	local S = Storage.Quest.U8_7.RottinWoodAndTheMarriedMen
	local mission01 = player:getStorageValue(S.Mission01)
	local task01 = player:getStorageValue(S.Task01)

	-- Only usable while Mission 1 or the Lucky Loop task is actually in progress
	if mission01 == 1 or task01 == 1 then
		item:remove(1)
		itemEx:remove(1)
		player:addItem(12173, 1)
	end
	return true
end

luckycharm:id(12171)
luckycharm:register()
