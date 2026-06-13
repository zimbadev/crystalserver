local selectVocationNewhaven = MoveEvent()

local function scheduleStarterItems(playerId, attemptsLeft)
	local player = Player(playerId)
	if not player or player:getStorageValue(Storage.Quest.U15_12.newhavenStarterItems) > 0 then
		return
	end

	if player:getVocation():getId() ~= VOCATION_NONE then
		Newhaven.giveStarterItems(player)
		return
	end

	if attemptsLeft <= 0 then
		return
	end

	addEvent(scheduleStarterItems, 1000, playerId, attemptsLeft - 1)
end

function selectVocationNewhaven.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:teleportTo(Position(32544, 32515, 7))

	if player:getVocation():getId() == VOCATION_NONE then
		player:sendTutorial(2)
		scheduleStarterItems(player:getId(), 60)
	else
		Newhaven.giveStarterItems(player)
	end

	player:addMapMark(Position(32554, 32507, 7), 11, "Avriel's Shop")
	player:addMapMark(Position(32570, 32503, 7), 3, "Spells")
	player:addMapMark(Position(32553, 32497, 7), 9, "Ferry House")
	player:addMapMark(Position(32567, 32490, 7), 13, "Bank")
	player:addMapMark(Position(32595, 32458, 7), 8, "Corrupted Mines")
	player:addMapMark(Position(32526, 32430, 7), 8, "Muglex Clan Camp")

	player:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, 1)
	player:setStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting, 1)
	player:setStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor, 1)

	return true
end

selectVocationNewhaven:type("stepin")
selectVocationNewhaven:position(Position(32538, 32514, 7))
selectVocationNewhaven:register()
