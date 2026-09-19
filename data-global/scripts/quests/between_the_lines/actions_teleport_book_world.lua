local teleport = Action()

function teleport.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item:getId()
	local itemPos = item:getPosition()

	if itemId == 50978 and itemPos == Position(33185, 31794, 7) then
		local targetPosition = Position(32520, 32514, 8) -- chapter I
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_OPEN_BOOKMACHINE)
		itemPos:sendMagicEffect(CONST_ME_OPEN_BOOKSPELL)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are drawn into the pages of the book.")
		return true
	elseif itemId == 51528 and itemPos == Position(32522, 32512, 8) then
		local targetPosition = Position(33185, 31795, 7) -- front of edron book
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_OPEN_BOOKMACHINE)
		itemPos:sendMagicEffect(CONST_ME_OPEN_BOOKSPELL)
		return true
	elseif itemId == 51624 and itemPos == Position(32526, 32512, 8) then
		local targetPosition = Position(32526, 32513, 9) -- chapter II
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_OPEN_BOOKMACHINE)
		itemPos:sendMagicEffect(CONST_ME_OPEN_BOOKSPELL)
		return true
	elseif itemId == 51625 and itemPos == Position(32536, 32512, 8) then
		local targetPosition = Position(32526, 32513, 9) -- chapter III
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_OPEN_BOOKMACHINE)
		itemPos:sendMagicEffect(CONST_ME_OPEN_BOOKSPELL)
		return true
	elseif itemId == 51626 and itemPos == Position(32540, 32512, 8) then
		local targetPosition = Position(32585, 32558, 11) -- chapter IV
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_OPEN_BOOKMACHINE)
		itemPos:sendMagicEffect(CONST_ME_OPEN_BOOKSPELL)
		return true
	elseif itemId == 51756 then
		local targetPosition = Position(32520, 32514, 8) -- chapter I

		if itemPos == Position(32526, 32512, 9) or itemPos == Position(32552, 32594, 10) or itemPos == Position(32585, 32557, 11) then
			player:teleportTo(targetPosition)
			player:getPosition():sendMagicEffect(CONST_ME_OPEN_BOOKMACHINE)
			itemPos:sendMagicEffect(CONST_ME_OPEN_BOOKSPELL)
			return true
		end
	end

	return false
end

teleport:id(50978, 51528, 51624, 51625, 51626, 51756)
teleport:register()
