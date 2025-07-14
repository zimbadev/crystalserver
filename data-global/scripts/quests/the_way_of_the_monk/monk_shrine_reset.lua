local shrineReset = MoveEvent()

function shrineReset.onRemoveItem(item, position)
	local aid = item.actionid
	addEvent(function(pos, aid)
		local tile = Tile(pos)
		if not tile then
			return
		end
		local shrine = tile:getItemById(50242)
		if shrine then
			shrine:setActionId(aid)
		end
	end, 1, Position(position), aid)
	return true
end

shrineReset:type("removeitem")
shrineReset:id(50244)
shrineReset:register()
