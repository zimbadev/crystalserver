local pos = Position(532, 687, 10)

local demonhelmetLever = Action()

function demonhelmetLever.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	local stoneItem

	if item.uid == Storage.CrystalServer.Quests.DemonHelmet.Lever and item.itemid == 2772 then
		stoneItem = Tile(pos):getItemById(1842)
		if stoneItem then
			stoneItem:remove()
		end
		item:transform(item.itemid + 1)
	elseif item.uid == Storage.CrystalServer.Quests.DemonHelmet.Lever and item.itemid == 2773 then
		Game.createItem(1842, 1, pos)
		item:transform(item.itemid - 1)
	else
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	return true
end

demonhelmetLever:uid(Storage.CrystalServer.Quests.DemonHelmet.Lever)
demonhelmetLever:register()
