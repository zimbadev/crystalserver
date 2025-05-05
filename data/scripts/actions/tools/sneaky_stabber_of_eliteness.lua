local toolGear = Action()

function toolGear.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if math.random(1000) > 10 then
		if onUseKitchenKnife(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseRope(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseShovel(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUsePick(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseMachete(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseSpoon(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		end
	else
		player:say("Oh no! Your tool is jammed and can't be used for a minute.", TALKTYPE_MONSTER_SAY)
		player:addAchievementProgress("Bad Timing", 10)
		item:transform(item.itemid + 1)
		item:decay()
	end
	return true
end

toolGear:id(9594)
toolGear:register()
