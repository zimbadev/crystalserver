local tutorial = MoveEvent()

function tutorial.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if player:getStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting) > 0 then
		player:sendTutorial(3)
		player:setStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting, -1)
	end

	return true
end

tutorial:type("stepin")
tutorial:position(Position(32561, 32485, 7))
tutorial:position(Position(32562, 32485, 7))
tutorial:register()
