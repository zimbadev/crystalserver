local shrineReset = MoveEvent()

function shrineReset.onRemoveItem(item, position)
	local aid = item:getActionId()
	local itemPosition = item:getPosition()
	if itemPosition:getDistance(position) > 0 then
		item:transform(item.itemid - 2)
		item:setActionId(aid)
	end
	return true
end

shrineReset:type("removeitem")
shrineReset:id(50244)
shrineReset:register()
