local rake = Action()

function rake.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Wrath of the Emperor Mission02
	if target.itemid == 11366 then
		player:addItem(11329, 1)
		player:say("You dig out a handful of ordinary clay.", TALKTYPE_MONSTER_SAY)
		-- The Shattered Isles Parrot ring
	elseif target.itemid == 6094 then
		if player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheGovernorDaughter) == 1 then
			toPosition:sendMagicEffect(CONST_ME_POFF)
			Game.createItem(6093, 1, Position(32422, 32770, 1))
			player:say("You have found a ring.", TALKTYPE_MONSTER_SAY)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheGovernorDaughter, 2)
		end
		-- The Grumpy Stone
	elseif player:getStorageValue(2033032) == 1 then
		local positions = {
			{ x = 32617, y = 31863, z = 7 },
			{ x = 32616, y = 31864, z = 7 },
			{ x = 32615, y = 31866, z = 7 },
			{ x = 32620, y = 31864, z = 7 },
			{ x = 32619, y = 31865, z = 7 },
		}
		local positionStorages = {
			[1] = 2033033,
			[2] = 2033034,
			[3] = 2033035,
			[4] = 2033036,
			[5] = 2033037,
		}
		for i, pos in ipairs(positions) do
			if toPosition.x == pos.x and toPosition.y == pos.y and toPosition.z == pos.z then
				if player:getStorageValue(positionStorages[i]) == 1 then
					return true
				end
				player:setStorageValue(positionStorages[i], 1)
				player:say("*scratch* *scratch*", TALKTYPE_MONSTER_SAY)
				return true
			end
		end
	end

	return true
end

rake:id(3452)
rake:register()
