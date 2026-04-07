local forbiddenFruit = Action()

function forbiddenFruit.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ForbiddenFruit) >= 1 then -- this storage prevents fruit from being eaten again, it's proably used in some sort of secret yet to discover in cipsoft's tibia
		return true
	end

	item:remove(1)
	player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ForbiddenFruit, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have now tasted the forbidden fruit. You wonder if this was a good idea.")

	if not player:hasAchievement("Forbidden Fruit") then
		player:addAchievement("Forbidden Fruit")
	end

	return true
end

forbiddenFruit:id(24966)
forbiddenFruit:register()
