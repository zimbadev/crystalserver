local positions = {
	{ fromPos = Position(33600, 31927, 3), toPos = Position(33606, 31931, 3) },
	{ fromPos = Position(32772, 31163, 8), toPos = Position(32778, 31168, 8) }
}

local function isInRestrictedArea(position)
	for _, restrictedArea in ipairs(positions) do
		if position.x >= restrictedArea.fromPos.x and position.x <= restrictedArea.toPos.x and
		   position.y >= restrictedArea.fromPos.y and position.y <= restrictedArea.toPos.y and
		   position.z == restrictedArea.fromPos.z then
			return true
		end
	end
	return false
end

local disableMovingItems = EventCallback("DisableMovingItems")

disableMovingItems.playerOnMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if isInRestrictedArea(toPosition) then
		if item:getId() == ITEM_WATERBALL or item:getId() == ITEM_WATERBALL_SPLASH then
			return true
		end

		self:sendTextMessage(MESSAGE_FAILURE, "You cannot throw items into the water.")
		return false
	end
	return true
end

disableMovingItems:register()