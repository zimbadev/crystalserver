local toolGear = Action()

local function onUseSickle(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 5463 then
		target:transform(5462)
		target:decay()
		Game.createItem(5466, 1, toPosition)
		return true
	end
end

function toolGear.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if math.random(1000) > 10 then
		if onUseScythe(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseSickle(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseRope(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseShovel(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUsePick(player, item, fromPosition, target, toPosition, isHotkey) then
			return true
		elseif onUseMachete(player, item, fromPosition, target, toPosition, isHotkey) then
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

toolGear:id(9596)
toolGear:register()
