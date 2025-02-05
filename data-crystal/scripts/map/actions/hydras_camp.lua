local config = {
	{ position = Position(624, 433, 8), itemId = 1977 },
}

local hydrasCamp = Action()

function hydrasCamp.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	local stoneItem
	if item.uid == Storage.CrystalServer.HydrasCampLever and item.itemid == 2772 then
		for i = 1, #config do
			Game.createItem(config[i].itemId, 1, config[i].position)
		end
		item:transform(item.itemid + 1)
	elseif item.uid == Storage.CrystalServer.HydrasCampLever and item.itemid == 2773 then
		for i = 1, #config do
			stoneItem = Tile(config[i].position):getItemById(config[i].itemId)
			if stoneItem then
				stoneItem:remove()
			end
		end
		item:transform(item.itemid - 1)
	else
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	return true
end

hydrasCamp:uid(Storage.CrystalServer.HydrasCampLever)
hydrasCamp:register()
