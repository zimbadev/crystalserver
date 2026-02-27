local debugElderBloodjaw = TalkAction("/debugelder")

function debugElderBloodjaw.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local pos = player:getPosition()
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Checking for Elder Bloodjaw around position " .. pos.x .. "," .. pos.y .. "," .. pos.z)

	-- Verificar en diferentes rangos
	for radius = 1, 5 do
		local spectators = Game.getSpectators(pos, false, false, radius, radius, radius, radius)
		local elderCount = 0

		for _, creature in ipairs(spectators) do
			if creature:isMonster() and creature:getName():lower() == "elder bloodjaw" then
				elderCount = elderCount + 1
				local creaturePos = creature:getPosition()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Found Elder Bloodjaw at " .. creaturePos.x .. "," .. creaturePos.y .. "," .. creaturePos.z)
			end
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Radius " .. radius .. ": " .. elderCount .. " Elder Bloodjaw found")
	end

	-- Verificar teleports cercanos
	for radius = 1, 5 do
		local spectators = Game.getSpectators(pos, false, false, radius, radius, radius, radius)

		for _, creature in ipairs(spectators) do
			-- Verificar tiles alrededor para items
			local creaturePos = creature:getPosition()
			local tile = Tile(creaturePos)
			if tile then
				local items = tile:getItems()
				if items then
					for _, item in ipairs(items) do
						if item.itemid == 37000 then
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Found teleport (37000) at " .. creaturePos.x .. "," .. creaturePos.y .. "," .. creaturePos.z .. " with ActionId " .. item:getActionId())
						end
					end
				end
			end
		end
	end

	-- Verificar tile actual del jugador
	local playerTile = Tile(pos)
	if playerTile then
		local items = playerTile:getItems()
		if items then
			for _, item in ipairs(items) do
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Item on player tile: ID " .. item.itemid .. " ActionId " .. item:getActionId())
			end
		end
	end

	return false
end

debugElderBloodjaw:groupType("god")
debugElderBloodjaw:register()
