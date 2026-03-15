local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(2033025) == 1 and player:getStorageValue(2033026) < 3 then
		local pos = toPosition
		local bedStorage = nil
		if pos.x == 32391 and pos.y == 32220 and pos.z == 6 then
			bedStorage = 2033028
		elseif pos.x == 33001 and pos.y == 32060 and pos.z == 5 then
			bedStorage = 2033029
		elseif pos.x == 32328 and pos.y == 31794 and pos.z == 6 then
			bedStorage = 2033030
		end

		if bedStorage then
			if player:getStorageValue(bedStorage) == 1 then
				player:say("You already placed a present here.", TALKTYPE_MONSTER_SAY)
				return false
			end
			player:setStorageValue(bedStorage, 1)
			local current = player:getStorageValue(2033026)
			player:setStorageValue(2033026, current + 1)
			player:removeItem(25302, 1)
			player:say("You carefully place a present on the bed and grab a milk tooth from under the pillow.", TALKTYPE_MONSTER_SAY)
			player:addItem(25303, 1)

			return true
		end
	end
	return false
end

action:id(25302)
action:register()
