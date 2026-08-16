local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local pick = Action()

function pick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Mission 03 Shadows of Yalahar Quest
	if target and target:isItem() and target:getId() == 8106 then
		if player:getStorageValue(ShadowsOfYalahar.Mission03) ~= 1 then
			return true
		end

		target:transform(8107)
		player:addItem(9251, 1)
		return true
	end

	return onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
end

pick:id(3456)
pick:register()
